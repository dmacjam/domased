class EventsController < ApplicationController
  before_filter :authenticate, only: :new
  load_and_authorize_resource

  def index
  	if params[:lat].present?
  		@events = Event.near([params[:lat],params[:lng]],25).sorted
    	#@types = @events.select('type_id','count(*)').group(:type_id)
    	#types = Event.joins(:type).select("types.id,count(*)").group("types.id").order("types.id")
    	#@types = @events.joins("RIGHT JOIN types ON types.id=events.type_id").select("types.id AS typ_id,count(*)").group("types.id,events.id").order("types.id")
    	#@events=Event.sorted.includes(:type).page(params[:page])
    else
		@events = Event.all
  	end

	if params[:typ].present?
		@types = Type.where("id=?",params[:typ])
		@events = @events.includes(:type).where("type_id=?",params[:typ]).page(params[:page])
	else
		@types = Type.select("types.id,types.name,count(*)").from(@events).
    		     joins("JOIN types ON types.id=subquery.type_id").group("types.name,types.id")
    			 .order("types.name ASC")
    	@events = @events.includes(:type).page(params[:page])	
	end
  end

  def calendar
 	@events_by_date = Event.all.group_by{ |i| i.date.to_date }
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def search
	if params[:date].present?
		@events = Event.where("date>=? AND date<=?",params[:date].to_time.beginning_of_day,params[:date].to_time.end_of_day)
	end
  end

  def show
  end

  def new
    @event=Event.new({:description => 'Opis podujatia'})
  end

  def create
    @event=Event.new(event_params)
    @event.geocode
    if @event.save
      flash[:success]="Podujatie bolo úspešne vytvorené."
      redirect_to @event
    else
      render('new')
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      @event.geocode
      flash[:info]="Podujatie bolo úspešne upravené."
      redirect_to @event
    else
      render('edit')
    end
  end

  def destroy
    @event=Event.find(params[:id]).destroy
    flash[:success]="Podujatie #{@event.name} bolo uspesne zmazane."
    redirect_to(:action => 'index')
  end


  private
    def event_params
      params.require(:event).permit(:name,:description,:type_id,:form_date,:form_time, :address)
    end
end

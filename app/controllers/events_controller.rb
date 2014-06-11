class EventsController < ApplicationController

  def index
    @events=Event.sorted.includes(:type).page(params[:page])
  end

  def search
    if params[:lat].present? && params[:lng].present?
      @events=Event.near([params[:lat],params[:lng]],20)
      @events=@events.is_type(params[:id_type]) if params[:id_type].present?
      @events=@events.page(params[:page])
    else
      @events=Event.sorted.page(params[:page])
    end
  end

  def show
    @event=Event.find(params[:id])
  end

  def new
    @event=Event.new({:description => 'Opis podujatia'})
  end

  def create
    @event=Event.new(event_params)
    if @event.save
      flash[:success]="Podujatie bolo uspesne vytvorene."
      redirect_to @event
    else
      render('new')
    end
  end

  def edit
    @event=Event.find(params[:id])
  end

  def update
    @event=Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice]="Podujatie bolo uspesne upravene."
      redirect_to @event
    else
      render('edit')
    end
  end

  def destroy
    @event=Event.find(params[:id]).destroy
    flash[:notice]="Podujatie #{@event.name} bolo uspesne zmazane."
    redirect_to(:action => 'index')
  end


  private
    def event_params
      params.require(:event).permit(:name,:description,:type_id,:form_date,:form_time, :address)
    end
end

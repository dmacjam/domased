class EventsController < ApplicationController
  #layout false

  def index
    #@events=Event.all
    @events=Event.sorted
  end

  def search
    if params[:search_city].present?
      @events=Event.near(params[:search_city],20)
      @events=@events.is_type(params[:id_type]) if params[:id_type].present?
    else
      @events=Event.all
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
      redirect_to(:action => 'index')
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
      redirect_to(:action => 'show', :id => @event.id)
    else
      render('edit')
    end
  end

  def delete
    @event=Event.find(params[:id])
  end

  def destroy
    @event=Event.find(params[:id]).destroy
    flash[:notice]="Podujatie #{@event.name} bolo uspesne zmazane."
    redirect_to(:action => 'index')
  end


  private

    def event_params
      params.require(:event).permit(:name,:description,:type_id,:date, :address)
    end
end

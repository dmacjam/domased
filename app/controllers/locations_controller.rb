class LocationsController < ApplicationController
  def index
      if params[:q].present?
        @locations=Location.near(params[:q],20)
      else
        @locations=Location.all
      end

  end

  def show
    @location=Location.find(params[:id])
  end

  def new
    @location=Location.new
  end

  def create
    @location=Location.new(location_params)
    if @location.save
      flash[:notice]="Nova lokalita bola uspesne vytvorena"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

private
  def location_params
    params.require(:location).permit(:city,:address)
  end


end

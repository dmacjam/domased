class FacebookPlacesController < ApplicationController
  before_action :set_facebook_place, only: [:show, :edit, :update, :destroy]

  # GET /facebook_places
  # GET /facebook_places.json
  def index
    @facebook_places = FacebookPlace.order("created_at ASC")	#.paginate(page: params[:page])
  end

  # GET /facebook_places/1
  # GET /facebook_places/1.json
  def show
  end

  # GET /facebook_places/new
  def new
    @facebook_place = FacebookPlace.new
  end

  # GET /facebook_places/1/edit
  def edit
  end

  # POST /facebook_places
  # POST /facebook_places.json
  def create
    @facebook_place = FacebookPlace.new(facebook_place_params)

    respond_to do |format|
      if @facebook_place.save
        format.html { redirect_to @facebook_place, notice: 'Facebook place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facebook_place }
      else
        format.html { render action: 'new' }
        format.json { render json: @facebook_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facebook_places/1
  # PATCH/PUT /facebook_places/1.json
  def update
    respond_to do |format|
      if @facebook_place.update(facebook_place_params)
        format.html { redirect_to @facebook_place, notice: 'Facebook place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facebook_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook_places/1
  # DELETE /facebook_places/1.json
  def destroy
    @facebook_place.destroy
    respond_to do |format|
      format.html { redirect_to facebook_places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facebook_place
      @facebook_place = FacebookPlace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facebook_place_params
      params.require(:facebook_place).permit(:place_id, :checked)
    end
end

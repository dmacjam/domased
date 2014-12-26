class FacebookPlacesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @facebook_places = FacebookPlace.order("created_at ASC")	#.paginate(page: params[:page])
  end

  # GET /facebook_places/1
  # GET /facebook_places/1.json
  def show
  end

  # GET /facebook_places/new
  def new
  end

  # GET /facebook_places/1/edit
  def edit
  end

  # POST /facebook_places
  # POST /facebook_places.json
  def create
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
        # Never trust parameters from the scary internet, only allow the white list through.
    def facebook_place_params
      params.require(:facebook_place).permit(:place_id, :name)
    end
end

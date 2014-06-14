require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FacebookPlacesController do

  # This should return the minimal set of attributes required to create a valid
  # FacebookPlace. As you add validations to FacebookPlace, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "place_id" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FacebookPlacesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all facebook_places as @facebook_places" do
      facebook_place = FacebookPlace.create! valid_attributes
      get :index, {}, valid_session
      assigns(:facebook_places).should eq([facebook_place])
    end
  end

  describe "GET show" do
    it "assigns the requested facebook_place as @facebook_place" do
      facebook_place = FacebookPlace.create! valid_attributes
      get :show, {:id => facebook_place.to_param}, valid_session
      assigns(:facebook_place).should eq(facebook_place)
    end
  end

  describe "GET new" do
    it "assigns a new facebook_place as @facebook_place" do
      get :new, {}, valid_session
      assigns(:facebook_place).should be_a_new(FacebookPlace)
    end
  end

  describe "GET edit" do
    it "assigns the requested facebook_place as @facebook_place" do
      facebook_place = FacebookPlace.create! valid_attributes
      get :edit, {:id => facebook_place.to_param}, valid_session
      assigns(:facebook_place).should eq(facebook_place)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FacebookPlace" do
        expect {
          post :create, {:facebook_place => valid_attributes}, valid_session
        }.to change(FacebookPlace, :count).by(1)
      end

      it "assigns a newly created facebook_place as @facebook_place" do
        post :create, {:facebook_place => valid_attributes}, valid_session
        assigns(:facebook_place).should be_a(FacebookPlace)
        assigns(:facebook_place).should be_persisted
      end

      it "redirects to the created facebook_place" do
        post :create, {:facebook_place => valid_attributes}, valid_session
        response.should redirect_to(FacebookPlace.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved facebook_place as @facebook_place" do
        # Trigger the behavior that occurs when invalid params are submitted
        FacebookPlace.any_instance.stub(:save).and_return(false)
        post :create, {:facebook_place => { "place_id" => "invalid value" }}, valid_session
        assigns(:facebook_place).should be_a_new(FacebookPlace)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FacebookPlace.any_instance.stub(:save).and_return(false)
        post :create, {:facebook_place => { "place_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested facebook_place" do
        facebook_place = FacebookPlace.create! valid_attributes
        # Assuming there are no other facebook_places in the database, this
        # specifies that the FacebookPlace created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        FacebookPlace.any_instance.should_receive(:update).with({ "place_id" => "MyString" })
        put :update, {:id => facebook_place.to_param, :facebook_place => { "place_id" => "MyString" }}, valid_session
      end

      it "assigns the requested facebook_place as @facebook_place" do
        facebook_place = FacebookPlace.create! valid_attributes
        put :update, {:id => facebook_place.to_param, :facebook_place => valid_attributes}, valid_session
        assigns(:facebook_place).should eq(facebook_place)
      end

      it "redirects to the facebook_place" do
        facebook_place = FacebookPlace.create! valid_attributes
        put :update, {:id => facebook_place.to_param, :facebook_place => valid_attributes}, valid_session
        response.should redirect_to(facebook_place)
      end
    end

    describe "with invalid params" do
      it "assigns the facebook_place as @facebook_place" do
        facebook_place = FacebookPlace.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FacebookPlace.any_instance.stub(:save).and_return(false)
        put :update, {:id => facebook_place.to_param, :facebook_place => { "place_id" => "invalid value" }}, valid_session
        assigns(:facebook_place).should eq(facebook_place)
      end

      it "re-renders the 'edit' template" do
        facebook_place = FacebookPlace.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FacebookPlace.any_instance.stub(:save).and_return(false)
        put :update, {:id => facebook_place.to_param, :facebook_place => { "place_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested facebook_place" do
      facebook_place = FacebookPlace.create! valid_attributes
      expect {
        delete :destroy, {:id => facebook_place.to_param}, valid_session
      }.to change(FacebookPlace, :count).by(-1)
    end

    it "redirects to the facebook_places list" do
      facebook_place = FacebookPlace.create! valid_attributes
      delete :destroy, {:id => facebook_place.to_param}, valid_session
      response.should redirect_to(facebook_places_url)
    end
  end

end
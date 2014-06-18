class PublicController < ApplicationController

  def home
  end

  def about
  end

  def login
  	if current_user
  	  redirect_to root_path
  	end
  end


end

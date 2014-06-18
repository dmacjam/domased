class PublicController < ApplicationController

  def home
 	if current_user
	 	@events = Event.all.where("type_id IN (?)",current_user.type_ids).limit(6)
  	end 
  end

  def about
  end

  def login
  	if current_user
  	  redirect_to root_path
  	end
  end


end

class User < ActiveRecord::Base
  #validates_presence_of :username
  has_many :created_events, :class_name => "Event"  #user.created_events - zobrazi vsetky vytvorene eventy userom
end

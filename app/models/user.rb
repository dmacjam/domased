class User < ActiveRecord::Base
  #validates_presence_of :username
  has_many :created_events, :class_name => "Event"  #user.created_events - zobrazi vsetky vytvorene eventy userom
  has_many :comments                                #user.comments- zobrazi polozky v rich join table comments
  has_many :event_comments, :through => :comments, :source => :event
                                                    # user.event_comments zobrazi vsetky komentare usera
end

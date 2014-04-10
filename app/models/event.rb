class Event < ActiveRecord::Base
  #validates_presence_of :name, :date
  belongs_to :type
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
                                                                      #event.creator zobrazi usera, kt. vytvoril event
  belongs_to :locality
  has_many :comments                                                      #zobrazi rich join table komentare
  has_many :user_comments, :through => :comments, :source => :user
                                                                #event.user_comments zobrazi vsetky commenty k eventu
end

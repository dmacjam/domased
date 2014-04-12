class Event < ActiveRecord::Base
  validates :name, :presence =>  { :message => 'Nezadal si nazov podujatia' },
                    :length => {:within => 4..30, :message => 'Nazov podujatia musi byt v rozadhu 4-30 znakov'}

  belongs_to :type
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
                                                                      #event.creator zobrazi usera, kt. vytvoril event
  belongs_to :location
  has_many :comments                                                      #zobrazi rich join table komentare
  has_many :user_comments, :through => :comments, :source => :user
                                                                #event.user_comments zobrazi vsetky commenty k eventu
end

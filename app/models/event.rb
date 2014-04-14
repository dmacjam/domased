class Event < ActiveRecord::Base
  validates :name, :presence =>  { :message => 'Nezadal si nazov podujatia' },
                    :length => {:within => 4..30, :message => 'Nazov podujatia musi byt v rozadhu 4-30 znakov'}

  validates :address, :presence => { :message => 'Musis zadat mesto'}


  belongs_to :type
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
                                                                      #event.creator zobrazi usera, kt. vytvoril event
  has_many :comments                                                      #zobrazi rich join table komentare
  has_many :user_comments, :through => :comments, :source => :user
                                                                #event.user_comments zobrazi vsetky commenty k eventu

  #Vstup od pouzivatela mi rozhodi do stlpcov v DB.
  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.city = geo.city
      obj.address = geo.address
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  after_validation :geocode

  scope :sorted, lambda{order("events.date ASC")}
  scope :is_type, lambda{ |typ| where(:type_id => typ)}

=begin
  def self.vyhladaj(city)
    if city
      find(1)
    else
      find(:all)
    end
  end
=end

=begin
  def my_address
    [city,address].compact.join(', ')
  end
=end
end

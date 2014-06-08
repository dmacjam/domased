class Event < ActiveRecord::Base
  self.per_page = 12

  validates :name, :presence =>  { :message => 'Nezadal si nazov podujatia' },
                    :length => {:within => 4..80, :message => 'Nazov podujatia musi byt v rozadhu 4-30 znakov'}

  #validates :address, :presence => { :message => 'Musis zadat mesto'}
  validates_uniqueness_of :name


  after_validation :reverse_geocode, :if => :has_coordinates
  after_validation :geocode, :if => :has_address, :unless => :has_coordinates

  belongs_to :type
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
                                                                      #event.creator zobrazi usera, kt. vytvoril event
  has_many :comments                                                      #zobrazi rich join table komentare
  has_many :user_comments, :through => :comments, :source => :user
                                                                #event.user_comments zobrazi vsetky commenty k eventu

  #Vstup od pouzivatela mi rozhodi do stlpcov v DB.
  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.address = [geo.city,geo.address].compact.join(',')
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  reverse_geocoded_by :latitude, :longitude

  scope :sorted, lambda{ order("events.date ASC") }
  scope :is_type, lambda{ |typ| where(:type_id => typ)}

  def has_coordinates
    latitude.present? && longitude.present?
  end

  def has_address
    address.present?
  end

end

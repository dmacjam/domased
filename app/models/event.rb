class Event < ActiveRecord::Base
  self.per_page = 12

  validates :name, presence:  { :message => 'Nezadal si nazov podujatia' },
                    length: {:within => 4..80, :message => 'Nazov podujatia musi byt v rozadhu 4-30 znakov'},
                    uniqueness: true
  validates :type_id, presence: true
  validates :address, :presence => { :message => 'Musis zadat mesto'}, unless: :has_coordinates?

  #after_validation :reverse_geocode, if: :has_coordinates?
  #after_validation :geocode, if: :do_geocode?
  
  belongs_to :type
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
                                                                      #event.creator zobrazi usera, kt. vytvoril event
  
  attr_writer :form_date,:form_time
  #attr_accessor :lat,:lng
  before_save :save_date, unless: :date_present
  validate :check_date_time, unless:  :date_present 
  validates_format_of :form_time, with: /\A\d{1,2}:\d{2}\b/, message: "Nespravny format casu", unless: :date_present
  validates_format_of :form_date, with: /\A\d{2}-\d{2}-\d{4}\b/, message: "Nespravny format datumu.", unless: :date_present
 
  def date_present
	date.present?
  end

  #Vstup od pouzivatela mi rozhodi do stlpcov v DB.
  geocoded_by :address do |obj,results|
    if geo = results.first
      if obj.new_record?
      	obj.address = [geo.city,geo.address].compact.join(',')
      	obj.latitude = geo.latitude
      	obj.longitude = geo.longitude
	  else
	  	obj.update_attribute(:address, [geo.city,geo.address].compact.join(',') )
	  	obj.update_attribute(:latitude,geo.latitude)
        obj.update_attribute(:longitude,geo.longitude)
      end
    end
  end

  reverse_geocoded_by :latitude, :longitude
  
  scope :sorted, lambda{ order("events.date ASC") }
  scope :is_type, lambda{ |typ| where(:type_id => typ)}

  
  
  
  def has_coordinates?
    latitude.present? && longitude.present?
  end

  def has_address?
    address.present?
  end

  def do_geocode?
	has_address? && !has_coordinates?
  end

  def form_date
	@form_date || date.try(:strftime,"%m %d %Y")
  end

  def form_time
	@form_time || date.try(:strftime, "%H:%M")
  end

  def parse_form_datetime
	Time.zone.parse("#{@form_date} #{@form_time}")
  end
  
  def save_date
	self.date = parse_form_datetime 
  end

  def check_date_time
    if !@form_date.present? || !@form_time.present?
		errors.add :date, "Zadaj datum a cas"
	end

    if parse_form_datetime.nil?
    	errors.add :date, "Chybny datum"
	end
  rescue ArgumentError
  	  errors.add :date, "Mimo rozsahu"
  end

  #def check
  #	Rails.logger.info("Som TU")
  #	result = Geocoder.search(address)
  #	if result
  #		update_attribute(:latitude,result[0].coordinates[0])
  #		update_attribute(:longitude,result[0].coordinates[1])
  #		update_attribute(:address,result[0].address)
  #		Rails.logger.info("Spracovavam #{result[0].address}")
  #	end
  #	self.save
  # end

end

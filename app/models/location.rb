class Location < ActiveRecord::Base
  has_many :events

  validates :city, :presence => {:message => "Musis zadat mesto"}

  geocoded_by :my_address
  after_validation :geocode



  def my_address
    [city,address].compact.join(', ')
  end
end

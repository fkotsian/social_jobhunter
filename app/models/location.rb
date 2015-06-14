# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  street1     :string
#  street2     :string
#  city        :string
#  region      :string
#  postal_code :string
#  country     :string           default("USA")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ActiveRecord::Base
  def to_s
    "#{street1} #{street2}, #{city}, #{region} #{postal_code}, #{country}"
  end
  
  def self.unknown_location
    find_by(country: 'Unknown Location') || create!(country: 'Unknown Location')
  end
end

require 'spec_helper'
require_relative '../../app/models/location'

describe Location do  
  it 'outputs a stringified version of its attributes' do
    l = Location.create!(
      street1: '123 Fake St.',
      street2: 'Apt 4',
      city: 'Springfield',
      region: 'Illinois',
      postal_code: '00001',
      country: 'Tvland'
    )
    expect(l.to_s).to eq '123 Fake St. Apt 4, Springfield, Illinois 00001, Tvland'
  end
end
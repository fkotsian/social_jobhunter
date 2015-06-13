require 'spec_helper'
require_relative '../../app/models/company'

describe Company do  
  it 'provides a baseline description' do
    c = Company.create!(name: 'fakeco')
    expect(c.description).to eq 'No description yet provided.'
  end
end
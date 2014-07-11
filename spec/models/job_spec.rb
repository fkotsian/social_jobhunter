require 'spec_helper'

describe Job do
  it "has a valid factory"
  it "belongs to a company"
  it "has one category"
  it "has a title"
  it "may have a URL"
  it "may have a salary bottom"
  it "may have a salary top"
  
  context "new Job" do
    it "has a status of 'Open'"
  end
  
  context "closed Job" do
    it "has a status of 'Closed'"
  end
end
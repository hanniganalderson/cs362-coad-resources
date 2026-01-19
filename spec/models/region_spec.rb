require 'rails_helper'

RSpec.describe Region, type: :model do

  it "has a name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it "has many tickets" do
    should have_many(:tickets)
  end

  it "validates presence of name" do
    should validate_presence_of(:name)
  end

  it "validates length of name" do
    should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
  end

  it "validates uniqueness of name" do
    should validate_uniqueness_of(:name).case_insensitive
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
    expect(result).to eq('Mt. Hood')
  end

  it "finds or creates unspecified region" do
    region = Region.unspecified
    expect(region.name).to eq('Unspecified')
  end

end

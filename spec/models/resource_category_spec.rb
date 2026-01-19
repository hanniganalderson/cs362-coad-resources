require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:category) {
    ResourceCategory.new
  }

  it "responds to name" do
    expect(category).to respond_to(:name)
  end

  it "responds to active" do
    expect(category).to respond_to(:active)
  end

  it "has and belongs to many organizations" do
    should have_and_belong_to_many(:organizations)
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
    should validate_uniqueness_of(:name).case_insensitive(false)
  end

end

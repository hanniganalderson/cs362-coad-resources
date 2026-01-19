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
    should validate_uniqueness_of(:name).case_insensitive
  end

  it "activates category" do
    category = ResourceCategory.new(active: false)
    category.activate
    expect(category.active).to eq(true)
  end

  it "deactivates category" do
    category = ResourceCategory.new(active: true)
    category.deactivate
    expect(category.active).to eq(false)
  end

  it "returns true when inactive" do
    category = ResourceCategory.new(active: false)
    expect(category.inactive?).to eq(true)
  end

  it "returns name as string representation" do
    category = ResourceCategory.new(name: 'Test')
    expect(category.to_s).to eq('Test')
  end

  it "finds or creates unspecified category" do
    category = ResourceCategory.unspecified
    expect(category.name).to eq('Unspecified')
  end

  it "returns active categories" do
    active = ResourceCategory.create(name: 'Test1', active: true)
    inactive = ResourceCategory.create(name: 'Test2', active: false)
    result = ResourceCategory.active
    expect(result).to include(active)
    expect(result).not_to include(inactive)
  end

  it "returns inactive categories" do
    active = ResourceCategory.create(name: 'Test1', active: true)
    inactive = ResourceCategory.create(name: 'Test2', active: false)
    result = ResourceCategory.inactive
    expect(result).to include(inactive)
    expect(result).not_to include(active)
  end

end

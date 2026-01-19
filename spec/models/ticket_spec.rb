require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) {
    Ticket.new
  }

  it "responds to name" do
    expect(ticket).to respond_to(:name)
  end

  it "responds to description" do
    expect(ticket).to respond_to(:description)
  end

  it "responds to phone" do
    expect(ticket).to respond_to(:phone)
  end

  it "responds to closed" do
    expect(ticket).to respond_to(:closed)
  end

  it "responds to closed_at" do
    expect(ticket).to respond_to(:closed_at)
  end

  it "responds to organization_id" do
    expect(ticket).to respond_to(:organization_id)
  end

  it "responds to region_id" do
    expect(ticket).to respond_to(:region_id)
  end

  it "responds to resource_category_id" do
    expect(ticket).to respond_to(:resource_category_id)
  end

  it "belongs to region" do
    should belong_to(:region)
  end

  it "belongs to organization" do
    should belong_to(:organization).optional
  end

  it "belongs to resource_category" do
    should belong_to(:resource_category)
  end

  it "validates presence of name" do
    should validate_presence_of(:name)
  end

  it "validates presence of phone" do
    should validate_presence_of(:phone)
  end

  it "validates presence of region_id" do
    should validate_presence_of(:region_id)
  end

  it "validates presence of resource_category_id" do
    should validate_presence_of(:resource_category_id)
  end

  it "validates length of name" do
    should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
  end

  it "validates length of description" do
    should validate_length_of(:description).is_at_most(1020).on(:create)
  end

  it "validates phone is plausible" do
    ticket = Ticket.new(name: 'Test', region_id: 1, resource_category_id: 1)
    ticket.phone = '+1 541 541 5415'
    ticket.valid?
    expect(ticket.errors[:phone]).to be_empty
  end

  it "returns true when ticket is open" do
    ticket = Ticket.new(closed: false)
    expect(ticket.open?).to eq(true)
  end

  it "returns true when ticket is captured" do
    ticket = Ticket.new
    ticket.organization = Organization.new
    expect(ticket.captured?).to eq(true)
  end

  it "returns ticket id as string representation" do
    ticket = Ticket.new
    ticket.id = 123
    expect(ticket.to_s).to eq('Ticket 123')
  end

  it "returns open tickets" do
    region = Region.create(name: 'Test Region')
    category = ResourceCategory.create(name: 'Test Category')
    open_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, organization_id: nil, region_id: region.id, resource_category_id: category.id)
    closed_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: true, region_id: region.id, resource_category_id: category.id)
    result = Ticket.open
    expect(result).to include(open_ticket)
    expect(result).not_to include(closed_ticket)
  end

  it "returns closed tickets" do
    region = Region.create(name: 'Test Region')
    category = ResourceCategory.create(name: 'Test Category')
    open_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, region_id: region.id, resource_category_id: category.id)
    closed_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: true, region_id: region.id, resource_category_id: category.id)
    result = Ticket.closed
    expect(result).to include(closed_ticket)
    expect(result).not_to include(open_ticket)
  end

  it "returns organization tickets" do
    region = Region.create(name: 'Test Region')
    category = ResourceCategory.create(name: 'Test Category')
    org_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, organization_id: 1, region_id: region.id, resource_category_id: category.id)
    open_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: false, organization_id: nil, region_id: region.id, resource_category_id: category.id)
    result = Ticket.all_organization
    expect(result).to include(org_ticket)
    expect(result).not_to include(open_ticket)
  end

  it "returns tickets for specific organization" do
    region = Region.create(name: 'Test Region')
    category = ResourceCategory.create(name: 'Test Category')
    org1_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, organization_id: 1, region_id: region.id, resource_category_id: category.id)
    org2_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: false, organization_id: 2, region_id: region.id, resource_category_id: category.id)
    result = Ticket.organization(1)
    expect(result).to include(org1_ticket)
    expect(result).not_to include(org2_ticket)
  end

  it "returns closed tickets for specific organization" do
    region = Region.create(name: 'Test Region')
    category = ResourceCategory.create(name: 'Test Category')
    org1_closed = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: true, organization_id: 1, region_id: region.id, resource_category_id: category.id)
    org1_open = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: false, organization_id: 1, region_id: region.id, resource_category_id: category.id)
    result = Ticket.closed_organization(1)
    expect(result).to include(org1_closed)
    expect(result).not_to include(org1_open)
  end

  it "returns tickets for specific region" do
    region1 = Region.create(name: 'Test Region 1')
    region2 = Region.create(name: 'Test Region 2')
    category = ResourceCategory.create(name: 'Test Category')
    region1_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, region_id: region1.id, resource_category_id: category.id)
    region2_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: false, region_id: region2.id, resource_category_id: category.id)
    result = Ticket.region(region1.id)
    expect(result).to include(region1_ticket)
    expect(result).not_to include(region2_ticket)
  end

  it "returns tickets for specific resource category" do
    region = Region.create(name: 'Test Region')
    cat1 = ResourceCategory.create(name: 'Test Cat 1')
    cat2 = ResourceCategory.create(name: 'Test Cat 2')
    cat1_ticket = Ticket.create!(name: 'Test', phone: '+1 541 541 5415', closed: false, region_id: region.id, resource_category_id: cat1.id)
    cat2_ticket = Ticket.create!(name: 'Test2', phone: '+1 541 541 5415', closed: false, region_id: region.id, resource_category_id: cat2.id)
    result = Ticket.resource_category(cat1.id)
    expect(result).to include(cat1_ticket)
    expect(result).not_to include(cat2_ticket)
  end
end

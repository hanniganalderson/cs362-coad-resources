require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:org) {
    Organization.new
  }

  it "responds to name" do
    expect(org).to respond_to(:name)
  end

  it "responds to email" do
    expect(org).to respond_to(:email)
  end

  it "responds to phone" do
    expect(org).to respond_to(:phone)
  end

  it "responds to description" do
    expect(org).to respond_to(:description)
  end

  it "responds to status" do
    expect(org).to respond_to(:status)
  end

  it "responds to rejection_reason" do
    expect(org).to respond_to(:rejection_reason)
  end

  it "responds to liability_insurance" do
    expect(org).to respond_to(:liability_insurance)
  end

  it "responds to primary_name" do
    expect(org).to respond_to(:primary_name)
  end

  it "responds to secondary_name" do
    expect(org).to respond_to(:secondary_name)
  end

  it "responds to secondary_phone" do
    expect(org).to respond_to(:secondary_phone)
  end

  it "responds to title" do
    expect(org).to respond_to(:title)
  end

  it "responds to transportation" do
    expect(org).to respond_to(:transportation)
  end

  it "responds to agreement_one" do
    expect(org).to respond_to(:agreement_one)
  end

  it "responds to agreement_two" do
    expect(org).to respond_to(:agreement_two)
  end

  it "responds to agreement_three" do
    expect(org).to respond_to(:agreement_three)
  end

  it "responds to agreement_four" do
    expect(org).to respond_to(:agreement_four)
  end

  it "responds to agreement_five" do
    expect(org).to respond_to(:agreement_five)
  end

  it "responds to agreement_six" do
    expect(org).to respond_to(:agreement_six)
  end

  it "responds to agreement_seven" do
    expect(org).to respond_to(:agreement_seven)
  end

  it "responds to agreement_eight" do
    expect(org).to respond_to(:agreement_eight)
  end

  it "has many users" do
    should have_many(:users)
  end

  it "has many tickets" do
    should have_many(:tickets)
  end

  it "has and belongs to many resource_categories" do
    should have_and_belong_to_many(:resource_categories)
  end

  it "validates presence of email" do
    should validate_presence_of(:email)
  end

  it "validates presence of name" do
    should validate_presence_of(:name)
  end

  it "validates presence of phone" do
    should validate_presence_of(:phone)
  end

  it "validates presence of status" do
    should validate_presence_of(:status)
  end

  it "validates presence of primary_name" do
    should validate_presence_of(:primary_name)
  end

  it "validates presence of secondary_name" do
    should validate_presence_of(:secondary_name)
  end

  it "validates presence of secondary_phone" do
    should validate_presence_of(:secondary_phone)
  end

  it "validates length of email" do
    should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
  end

  it "validates email format" do
    should allow_value('user@example.com').for(:email)
    should_not allow_value('invalid').for(:email)
  end

  it "validates uniqueness of email" do
    should validate_uniqueness_of(:email).case_insensitive
  end

  it "validates length of name" do
    should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
  end

  it "validates uniqueness of name" do
    should validate_uniqueness_of(:name).case_insensitive
  end

  it "validates length of description" do
    should validate_length_of(:description).is_at_most(1020).on(:create)
  end

  it "approves organization" do
    org = Organization.new
    org.approve
    expect(org.status).to eq('approved')
  end

  it "rejects organization" do
    org = Organization.new
    org.reject
    expect(org.status).to eq('rejected')
  end

  it "sets default status on new record" do
    org = Organization.new
    org.set_default_status
    expect(org.status).to eq('submitted')
  end

  it "returns name as string representation" do
    org = Organization.new(name: 'Test Org')
    expect(org.to_s).to eq('Test Org')
  end

end

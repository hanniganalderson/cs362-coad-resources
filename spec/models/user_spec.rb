require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.new
  }

  it "responds to email" do
    expect(user).to respond_to(:email)
  end

  it "responds to role" do
    expect(user).to respond_to(:role)
  end

  it "belongs to organization" do
    should belong_to(:organization).optional
  end

  it "validates presence of email" do
    should validate_presence_of(:email)
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

  it "validates presence of password" do
    should validate_presence_of(:password).on(:create)
  end

  it "validates length of password" do
    should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create)
  end

  it "sets default role on new record" do
    user = User.new
    user.set_default_role
    expect(user.role).to eq('organization')
  end

  it "returns email as string representation" do
    user = User.new(email: 'test@test.com')
    expect(user.to_s).to eq('test@test.com')
  end

end

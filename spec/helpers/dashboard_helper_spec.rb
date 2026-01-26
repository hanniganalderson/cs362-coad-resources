require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  it "returns admin dashboard for admin user" do
    user = User.new(role: :admin)
    expect(helper.dashboard_for(user)).to eq('admin_dashboard')
  end

  it "returns create application dashboard when user has no organization" do
    user = User.new(role: :organization)
    expect(helper.dashboard_for(user)).to eq('create_application_dashboard')
  end

  it "returns submitted dashboard when organization is submitted" do
    org = Organization.new(status: :submitted)
    user = User.new(role: :organization)
    user.organization = org
    expect(helper.dashboard_for(user)).to eq('organization_submitted_dashboard')
  end

  it "returns approved dashboard when organization is approved" do
    org = Organization.new(status: :approved)
    user = User.new(role: :organization)
    user.organization = org
    expect(helper.dashboard_for(user)).to eq('organization_approved_dashboard')
  end

end

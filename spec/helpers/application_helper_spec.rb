require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  it "returns base title when page title is empty" do
    expect(helper.full_title('')).to eq('Disaster Resource Network')
  end

  it "returns page title with base title when page title is provided" do
    expect(helper.full_title('About')).to eq('About | Disaster Resource Network')
  end

end

require 'rails_helper'

RSpec.describe Team, type: :model do
  it "is valid with a name" do
    team = Team.new(name: "Engineering")

    expect(team).to be_valid
  end

  it "is invalid without a name" do
    team = Team.new

    expect(team).not_to be_valid
  end
end
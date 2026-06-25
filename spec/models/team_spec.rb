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

  it "can be saved to the database" do
    team = Team.create(name: "Marketing")

    expect(team.persisted?).to eq(true)
  end

  it "has a name after creation" do
    team = Team.create(name: "Sales")

    expect(team.name).to eq("Sales")
  end

  it "can have multiple members" do
    team = Team.create!(name: "Engineering")

    Member.create!(
      first_name: "John",
      last_name: "Doe",
      team: team
    )

    Member.create!(
      first_name: "Jane",
      last_name: "Smith",
      team: team
    )

    expect(team.members.count).to eq(2)
  end
end
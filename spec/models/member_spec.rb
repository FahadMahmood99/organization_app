require 'rails_helper'

RSpec.describe Member, type: :model do
  it "is valid with first_name, last_name and team" do
    team = Team.create!(name: "Engineering")

    member = Member.new(
      first_name: "John",
      last_name: "Doe",
      team: team
    )

    expect(member.valid?).to eq(true)
  end

  it "is invalid without first_name" do
    team = Team.create!(name: "Engineering")

    member = Member.new(
      last_name: "Doe",
      team: team
    )

    expect(member.valid?).to eq(false)
  end

  it "belongs to a team" do
    team = Team.create!(name: "Engineering")

    member = Member.create!(
      first_name: "John",
      last_name: "Doe",
      team: team
    )

    expect(member.team).to eq(team)
  end
end
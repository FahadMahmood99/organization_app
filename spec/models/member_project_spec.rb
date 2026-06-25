require 'rails_helper'

RSpec.describe MemberProject, type: :model do
  it "connects a member and a project" do
    team = Team.create!(name: "Engineering")

    member = Member.create!(
      first_name: "John",
      last_name: "Doe",
      team: team
    )

    project = Project.create!(name: "Website")

    member_project = MemberProject.create!(
      member: member,
      project: project
    )

    expect(member_project.member).to eq(member)
    expect(member_project.project).to eq(project)
  end
end
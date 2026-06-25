require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is valid with a name" do
    project = Project.new(name: "Website")

    expect(project.valid?).to eq(true)
  end

  it "is invalid without a name" do
    project = Project.new

    expect(project.valid?).to eq(false)
  end
end
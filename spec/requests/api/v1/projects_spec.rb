require "rails_helper"

RSpec.describe "Projects API", type: :request do
  describe "GET /api/v1/projects" do
    it "returns all projects" do
      Project.create!(name: "Project Alpha")
      Project.create!(name: "Project Beta")

      get "/api/v1/projects", as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(2)
    end
  end

  describe "GET /api/v1/projects/:id" do
    it "returns a project" do
      project = Project.create!(name: "Project Alpha")

      get "/api/v1/projects/#{project.id}", as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["name"]).to eq("Project Alpha")
    end

    it "returns 404 when project does not exist" do
      get "/api/v1/projects/999999", as: :json

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/projects" do
    it "creates a project" do
      expect do
        post "/api/v1/projects",
             params: {
               name: "Project Alpha"
             }, as: :json
      end.to change(Project, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/projects/:id" do
    it "updates a project" do
      project = Project.create!(name: "Project Alpha")

      patch "/api/v1/projects/#{project.id}",
            params: {
              name: "Project Gamma"
            }, as: :json

      expect(response).to have_http_status(:ok)

      expect(project.reload.name).to eq("Project Gamma")
    end
  end

  describe "DELETE /api/v1/projects/:id" do
    it "deletes a project" do
      project = Project.create!(name: "Project Alpha")

      expect do
        delete "/api/v1/projects/#{project.id}", as: :json
      end.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/projects/:id/members" do
    it "returns project members" do
      team = Team.create!(name: "Engineering")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: team
      )

      project = Project.create!(name: "Project Alpha")
      project.members << member

      get "/api/v1/projects/#{project.id}/members", as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(1)
      expect(body.first["first_name"]).to eq("John")
    end
  end

  describe "POST /api/v1/projects/:id/add_member" do
    it "adds a member to a project" do
      team = Team.create!(name: "Engineering")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: team
      )

      project = Project.create!(name: "Project Alpha")

      post "/api/v1/projects/#{project.id}/add_member",
           params: {
             member_id: member.id
           }, as: :json

      expect(response).to have_http_status(:ok)

      expect(project.reload.members).to include(member)
    end
  end
end
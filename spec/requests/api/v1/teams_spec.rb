require "rails_helper"

RSpec.describe "Teams API", type: :request do
  describe "GET /api/v1/teams" do
    it "returns all teams" do
      Team.create!(name: "Engineering")
      Team.create!(name: "Marketing")

      get "/api/v1/teams"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(2)
    end
  end

  describe "GET /api/v1/teams/:id" do
    it "returns a team" do
      team = Team.create!(name: "Engineering")

      get "/api/v1/teams/#{team.id}"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["name"]).to eq("Engineering")
    end

    it "returns 404 when team does not exist" do
      get "/api/v1/teams/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/teams" do
    it "creates a team" do
      expect do
        post "/api/v1/teams",
             params: {
               name: "Engineering"
             }
      end.to change(Team, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/teams/:id" do
    it "updates a team" do
      team = Team.create!(name: "Engineering")

      patch "/api/v1/teams/#{team.id}",
            params: {
              name: "Marketing"
            }

      expect(response).to have_http_status(:ok)

      expect(team.reload.name).to eq("Marketing")
    end
  end

  describe "DELETE /api/v1/teams/:id" do
    it "deletes a team" do
      team = Team.create!(name: "Engineering")

      expect do
        delete "/api/v1/teams/#{team.id}"
      end.to change(Team, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/teams/:id/members" do
    it "returns all team members" do
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

      get "/api/v1/teams/#{team.id}/members"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(2)
    end
  end
end
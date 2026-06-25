require "rails_helper"

RSpec.describe "Members API", type: :request do
  describe "GET /api/v1/members" do
    it "returns all members" do
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

      get "/api/v1/members"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(2)
    end
  end

  describe "GET /api/v1/members/:id" do
    it "returns a member" do
      team = Team.create!(name: "Engineering")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: team
      )

      get "/api/v1/members/#{member.id}"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["first_name"]).to eq("John")
    end

    it "returns 404 when member does not exist" do
      get "/api/v1/members/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/members" do
    it "creates a member" do
      team = Team.create!(name: "Engineering")

      expect do
        post "/api/v1/members",
             params: {
               member: {
                 first_name: "John",
                 last_name: "Doe",
                 team_id: team.id
               }
             }
      end.to change(Member, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/members/:id" do
    it "updates a member" do
      team = Team.create!(name: "Engineering")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: team
      )

      patch "/api/v1/members/#{member.id}",
            params: {
              member: {
                first_name: "Johnny"
              }
            }

      expect(response).to have_http_status(:ok)

      expect(member.reload.first_name).to eq("Johnny")
    end
  end

  describe "DELETE /api/v1/members/:id" do
    it "deletes a member" do
      team = Team.create!(name: "Engineering")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: team
      )

      expect do
        delete "/api/v1/members/#{member.id}"
      end.to change(Member, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /api/v1/members/:id/update_team" do
    it "updates a member's team" do
      old_team = Team.create!(name: "Engineering")
      new_team = Team.create!(name: "Marketing")

      member = Member.create!(
        first_name: "John",
        last_name: "Doe",
        team: old_team
      )

      patch "/api/v1/members/#{member.id}/update_team",
            params: {
              team_id: new_team.id
            }

      expect(response).to have_http_status(:ok)

      expect(member.reload.team).to eq(new_team)
    end
  end
end
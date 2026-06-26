module Api
  module V1
    class MembersController < ApplicationController

      def index
        members = Member.all

        json = Jbuilder.new do |json|
          json.array! members do |member|
            member_json(json, member)
          end
        end

        render json: json.target!
      end

      def show
        member = Member.find(params[:id])

        render json: build_member_json(member)
      end

      def create
        member = Member.new(member_params)

        if member.save
          render json: build_member_json(member), status: :created
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        member = Member.find(params[:id])

        if member.update(member_params)
          render json: build_member_json(member)
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        member = Member.find(params[:id])
        member.destroy

        render json: { message: "Deleted successfully" }, status: :ok
      end

      def update_team
        member = Member.find(params[:id])
        team = Team.find(params[:team_id])

        member.update(team: team)

        render json: build_member_json(member)
      end

      private

      def member_params
        params.require(:member).permit(
          :first_name,
          :last_name,
          :city,
          :state,
          :country,
          :team_id
        )
      end

      def build_member_json(member)
        Jbuilder.new do |json|
          member_json(json, member)
        end.target!
      end

      def member_json(json, member)
        json.id member.id
        json.first_name member.first_name
        json.last_name member.last_name
        json.city member.city
        json.state member.state
        json.country member.country

        if member.team
          json.team do
            json.id member.team.id
            json.name member.team.name
          end
        else
          json.team nil
        end
      end
    end
  end
end
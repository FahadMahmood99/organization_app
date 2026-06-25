module Api
  module V1
    class MembersController < ApplicationController

      def index
        members = Member.all
        render json: members
      end

      def show
        member = Member.find(params[:id])
        render json: member
      end

      def create
        member = Member.new(member_params)

        if member.save
          render json: member, status: :created
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        member = Member.find(params[:id])

        if member.update(member_params)
          render json: member
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

        render json: member
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
    end
  end
end
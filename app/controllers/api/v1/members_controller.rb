module Api
  module V1
    class MembersController < ApplicationController

      def index
        @members = Member.all
      end

      def show
        @member = Member.find(params[:id])
      end

      def create
        @member = Member.new(member_params)

        if @member.save
          render :show, status: :created
        else
          render json: {
            errors: @member.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        @member = Member.find(params[:id])

        if @member.update(member_params)
          render :show
        else
          render json: {
            errors: @member.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        member = Member.find(params[:id])
        member.destroy

        render json: {
          message: "Deleted successfully"
        }, status: :ok
      end

      def update_team
        @member = Member.find(params[:id])
        team = Team.find(params[:team_id])

        @member.update(team: team)

        render :show
      end

      private

      def member_params
        params.require(:member).permit(
          :first_name,
          :last_name,
          :city,
          :state,
          :country,
          :status,
          :team_id
        )
      end
    end
  end
end
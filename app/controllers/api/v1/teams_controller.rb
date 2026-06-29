module Api
  module V1
    class TeamsController < ApplicationController

      def index
        @teams = Team.includes(:members)
      end

      def show
        @team = Team.find(params[:id])
      end

      def create
        @team = Team.new(name: params[:name])

        if @team.save
          render :show, status: :created
        else
          render json: {
            errors: @team.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        @team = Team.find(params[:id])

        if @team.update(name: params[:name])
          render :show
        else
          render json: {
            errors: @team.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @team = Team.find(params[:id])
        @team.destroy

        render json: {
          message: "Deleted successfully"
        }, status: :ok
      end

    end
  end
end
module Api
  module V1
    class TeamsController < ApplicationController

      def index
        teams = Team.all

        json = Jbuilder.new do |json|
          json.array! teams do |team|
            json.id team.id
            json.name team.name
          end
        end

        render json: json.target!
      end

      def show
        team = Team.find(params[:id])

        json = Jbuilder.new do |json|
          json.id team.id
          json.name team.name
        end

        render json: json.target!
      end

      def create
        team = Team.new(name: params[:name])

        if team.save
          json = Jbuilder.new do |json|
            json.id team.id
            json.name team.name
          end

          render json: json.target!, status: :created
        else
          render json: {
            errors: team.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        team = Team.find(params[:id])

        if team.update(name: params[:name])
          json = Jbuilder.new do |json|
            json.id team.id
            json.name team.name
          end

          render json: json.target!
        else
          render json: {
            errors: team.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        team = Team.find(params[:id])
        team.destroy

        render json: {
          message: "Deleted successfully"
        }, status: :ok
      end

      def members
        team = Team.find(params[:id])

        json = Jbuilder.new do |json|
          json.array! team.members do |member|
            json.id member.id
            json.first_name member.first_name
            json.last_name member.last_name
            json.city member.city
            json.state member.state
            json.country member.country
            json.team_id member.team_id
          end
        end

        render json: json.target!
      end

    end
  end
end
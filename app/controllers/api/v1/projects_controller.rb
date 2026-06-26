module Api
  module V1
    class ProjectsController < ApplicationController

      def index
        projects = Project.all

        json = Jbuilder.new do |json|
          json.array! projects do |project|
            json.id project.id
            json.name project.name
          end
        end

        render json: json.target!
      end

      def show
        project = Project.find(params[:id])

        json = Jbuilder.new do |json|
          json.id project.id
          json.name project.name
        end

        render json: json.target!
      end

      def create
        project = Project.new(name: params[:name])

        if project.save
          json = Jbuilder.new do |json|
            json.id project.id
            json.name project.name
          end

          render json: json.target!, status: :created
        else
          render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        project = Project.find(params[:id])

        if project.update(name: params[:name])
          json = Jbuilder.new do |json|
            json.id project.id
            json.name project.name
          end

          render json: json.target!
        else
          render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        project = Project.find(params[:id])
        project.destroy

        render json: { message: "Deleted successfully" }, status: :ok
      end

      def members
        project = Project.find(params[:id])

        json = Jbuilder.new do |json|
          json.array! project.members do |member|
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

      def add_member
        project = Project.find(params[:id])
        member = Member.find(params[:member_id])

        project.members << member

        json = Jbuilder.new do |json|
          json.array! project.members do |member|
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
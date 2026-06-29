module Api
  module V1
    class ProjectsController < ApplicationController

      def index
        @projects = Project.all
      end

      def show
        @project = Project.find(params[:id])
      end

      def create
        @project = Project.new(name: params[:name])

        if @project.save
          render :show, status: :created
        else
          render json: {
            errors: @project.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        @project = Project.find(params[:id])

        if @project.update(name: params[:name])
          render :show
        else
          render json: {
            errors: @project.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @project = Project.find(params[:id])
        @project.destroy

        render json: {
          message: "Deleted successfully"
        }, status: :ok
      end

      def members
        @project = Project.find(params[:id])
      end

      def add_member
        @project = Project.find(params[:id])
        member = Member.find(params[:member_id])

        @project.members << member

        render :members
      end

    end
  end
end
class ProjectsController < ApplicationController

  def index
    projects = Project.all
    render json: projects
  end

  def show
    project = Project.find(params[:id])
    render json: project
  end

  def create
    project = Project.new(name: params[:name])

    if project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    project = Project.find(params[:id])

    if project.update(name: params[:name])
      render json: project
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    render json: { message: "Deleted successfully" }, status: :ok
  end

  def members
    project = Project.find(params[:id])
    render json: project.members
  end

  def add_member
    project = Project.find(params[:id])
    member = Member.find(params[:member_id])

    project.members << member

    render json: project.members
  end

end
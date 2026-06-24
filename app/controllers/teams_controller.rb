class TeamsController < ApplicationController

  def index
    teams = Team.all
    render json: teams
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def create
    team = Team.new(name: params[:name])

    if team.save
      render json: team, status: :created
    else
      render json: team.errors, status: :unprocessable_entity
    end
  end

  def update
    team = Team.find(params[:id])

    if team.update(name: params[:name])
      render json: team
    else
      render json: team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    render json: { message: "Deleted successfully" }, status: :ok
  end

  def members
    team = Team.find(params[:id])
    render json: team.members
  end

end

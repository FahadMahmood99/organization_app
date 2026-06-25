class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def handle_not_found(error)
    render json: {
      error: error.message
    }, status: :not_found
  end

  def handle_parameter_missing(error)
    render json: {
      error: error.message
    }, status: :bad_request
  end
end
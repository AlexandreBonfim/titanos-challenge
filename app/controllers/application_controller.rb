class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_parameter_missing(exception)
    render json: {
      error: {
        code: "missing_parameter",
        message: exception.message
      }
    }, status: :bad_request
  end

  def render_not_found
    render json: {
      error: {
        code: "not_found",
        message: "Record not found"
      }
    }, status: :not_found
  end
end

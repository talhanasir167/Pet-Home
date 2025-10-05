class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [])
    devise_parameter_sanitizer.permit(:account_update, keys: [])
  end
end

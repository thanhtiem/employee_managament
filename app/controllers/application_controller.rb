class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_validation_error(resource)
    render(json: {
             resourceErrors: resource.errors
           }, status: :bad_request)
  end

  def render_not_found
    render json: { errors: :record_not_found }, status: 404
  end

  protected

  def configure_permitted_parameters
    added_attrs = [
      :email, :password, :password_confirmation
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::TextHelper

  # based on https://stackoverflow.com/questions/53869028/how-to-add-404-error-page-in-ruby-on-rails-app
  # rescue_from Exception, with: :render_404
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404

  # private

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404
    render file: 'public/404.html', layout: false, status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end
end

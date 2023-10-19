class Api::V1::ApiController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:notice] = "You are not authorized for this resource"
    render status: :forbidden, json: exception.message
  end

  before_action :authenticate_user!  # setup with devise
  authorize_resource  # setup with cancan
end

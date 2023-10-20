class Api::V1::ApiController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render status: :forbidden, json: exception.message }
      format.html { render :not_authorize }
    end
  end

  before_action :authenticate_user!  # setup with devise
  authorize_resource  # setup with cancan

  # def not_found
  # end

  # def not_authorize
  # end
end

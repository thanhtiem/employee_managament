class Api::V1::Profile < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    users = User.all
  end

end
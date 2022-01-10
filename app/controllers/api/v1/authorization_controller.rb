require 'httparty'
require 'json'

class Api::V1::AuthorizationCOntroller < ApplicationController
  include HTTParty

  def get_authorization
    provider = params[:provider]
    @user = send("#{provider}_authorization")

    @token = @user.create_token
    @user.save!

    auth_params = {
      'access-token': @token.token,
      client:  @token.client,
      uid: @user.uid,
      expiry: @token.expiry,
      # role: @user.role
    }

    render json: auth_params
  end

  private ##

  def google_authorization
    User.find_for_google_oauth(params)
  end

  def facebook_authorization
    facebook_data = HTTParty.get("https://graph.facebook.com/me", query: {
      access_token: params[:access_token]
    }).parsed_response

    User.find_for_facebook_oauth(facebook_data)
  end
end
Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      post 'auth/:provider/request', to:'authorization#get_authorization'

    end
  end
end

OmniAuth::Identity::Engine.routes.draw do
  # Confirmation routes for Confirmable
  resource :confirmation, :only => [:new, :create, :show],
           :path => "confirmation", :controller => "confirmations", :as => "user_confirmation"

  # Password routes for Recoverable
  resource :password, :only => [:new, :create, :edit, :update],
           :path => "password", :controller => "passwords", :as => "user_password"
end
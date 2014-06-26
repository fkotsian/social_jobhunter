Rails.application.routes.draw do

  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  resources :jobs, only: [:index], as: 'all_jobs'
  scope :user do
    resources :jobs, except: [:index]
  end
  
  
  root to: 'static_pages#home'
  # devise_scope :user do
  #   root to: 'devise/sessions#new'
  # end
end
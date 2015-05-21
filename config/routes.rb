Rails.application.routes.draw do


  devise_for :users, 
              :path => '', 
              :path_names => { 
                :sign_in => "login", 
                :sign_out => "logout", 
                :sign_up => "register" 
              }

  get '/feed', 
      to: 'job_applications#all_apps', 
      as: 'feed'
  
  resources :companies, only: [:index]
  
  scope :user do
    get '/applications', 
        to: 'job_applications#index', 
        as: 'my_applications'
        
    resources :job_applications, only: [:create]
              
    resources :jobs, except: [:index] do
      resources :job_applications, 
                except: [:index, :create], 
                as: 'applications'
    end
    
    # get 'applications/:company_id',
    #       to: 'job_applications#company_applications',
    #       as: 'company_applications'
    get 'applications/:category_id',
          to: 'job_applications#category_applications',
          as: 'category_applications'
    get 'applications/:area_id', 
          to: 'job_applications#area_applications', 
          as: 'area_applications'      
  end
  resources :jobs, only: [:index], as: 'all_jobs'
  get 'jobs/:category_id', to: 'jobs#category_jobs', as: 'category_jobs'
  get 'jobs/:company_id', to: 'jobs#company_jobs', as: 'company_jobs'
  get 'jobs/:area_id', to: 'jobs#area_jobs', as: 'area_jobs'  
  
  devise_scope :user do
    root to: 'static_pages#home'
    # root to: 'devise/sessions#new'
    # get 'user_root_path', to: 'jobs#index'
  end
end
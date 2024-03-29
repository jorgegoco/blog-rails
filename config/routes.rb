Rails.application.routes.draw do
  resources :projects
  resources :categories
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_post/:id', to: 'admin#show_post', as: 'admin_post'
    get 'admin/show_comment/:id', to: 'admin#show_comment', as: 'admin_comment'
  end
  get 'search', to: 'search#index'
  
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'u/:id', to: 'users#profile', as: 'user'
  resources :after_signup
  resources :posts do
    resources :comments
  end
  
  get 'about', to: 'pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end

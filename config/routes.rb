Rails.application.routes.draw do

  devise_for :users
  resources :posts do
  	resources :comments		#nested routes so comments are only visible through posts
  end

  root 'posts#index'

end

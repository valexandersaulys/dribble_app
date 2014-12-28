Rails.application.routes.draw do

  devise_for :users
  resources :posts do
  	member do
  		get "like", to: "posts#upvote"
  		get "dislike", to: "posts#downvote"
  	end
  	resources :comments		#nested routes so comments are only visible through posts
  end

  root 'posts#index'

end

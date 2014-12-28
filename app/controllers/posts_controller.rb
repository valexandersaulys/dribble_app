class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def show
	end

	def new
		@post = current_user.posts.build		# I assume this comes from Devise(?)
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		# Calls from before_action
	end

	def update
		# We are already finding the posts from the before_action

		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end


	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		# Need to permit the bits creates in the db:migrate file
		params.require(:post).permit(:title, :link, :description)
	end

end

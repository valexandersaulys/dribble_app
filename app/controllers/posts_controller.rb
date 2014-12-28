class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def show
		# Instead of looping through all comments, this will find 
		# just the comments associated with the post id
		@comments = Comment.where(post_id: @post)
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

	def upvote
		@post.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@post.downvote_by current_user
		redirect_to :back
	end


	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		# Need to permit the bits creates in the db:migrate file
		params.require(:post).permit(:title, :link, :description, :image)
	end

end

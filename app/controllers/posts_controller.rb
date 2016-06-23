class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    current_user.posts.create(post_params)

    redirect_to post_path(@post)
  end

  def show
  end

  def edit
    if @post.user != current_user
      return render text: 'Not Allowed'
    end
  end

  def update
    if @post.user != current_user
      return render text: 'Not Allowed'
    end

    @post.update_attributes(post_params)

    redirect_to post_path(@post)
  end

  def destroy
    if @post.user != current_user
      return render text: 'Not Allowed'
    end

    @post.delete

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end

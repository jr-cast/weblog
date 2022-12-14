class PostsController < ApplicationController
  # load_and_authorize_resource
  def new
    new_post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { new_post: new_post } }
    end
  end

  def create
    new_post = Post.new(params.require(:post).permit(:title, :text))
    new_post.user_id = current_user.id

    respond_to do |format|
      format.html do
        if new_post.save
          flash[:success] = 'Post saved successfully!'
          redirect_to users_url
        else
          flash.now[:error] = 'Error: Post could not be saved...'
          render :new, locals: { new_post: new_post }
        end
      end
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @posts }
      format.json do
        tokenized
        render json: @posts
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to user_path(params[:user_id])
  end
end

class BlogsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :current_user_check, only: [:new, :edit, :show, :destroy]

  def top
    redirect_to blogs_path
  end

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      CreateBlogMailer.create_blog(@blog).deliver
      redirect_to blogs_path, notice: "投稿しました"
    else
      render "new"
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました"
  end

  def favorite
    @favorites = current_user.favorite_blogs
  end

  private
  def blog_params
    params.require(:blog).permit(:content, :image)
  end

  def set_board
    @blog = Blog.find(params[:id])
  end

  def current_user_check
    current_user
    if !logged_in?
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end

end

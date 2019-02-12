# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :authenticate, only: %i[new create edit update destroy]

  def index
    @blogs ||= Blog.where(public: true)
                   .or(Blog.where(user_id: current_user&.id))
  end

  def index_by_user
    @user = User.find_by(id: params[:user_id].downcase)
    # @blogs ||= Blog.where(user: @user).where(public: true).or(Blog.where(user: current_user))
    @blogs ||= Blog.where(
      'user_id = :user_id AND (user_id = :current_user_id OR public=true)',
      user_id: @user.id, current_user_id: current_user&.id
    )
  end

  def index_by_category
    @category = params[:category].downcase
    # @blogs = Blog.where(category: @category).and(Blog.where())
    @blogs ||= Blog.where(
      'category = :category AND (user_id = :current_user_id OR public=true)',
      category: @category, current_user_id: current_user&.id
    )
  end

  def show
    @blog = Blog.find_by(id: params[:id])
    if @blog.nil?
      flash[:warning] = "Sorry! That blog doesn't exist"
      redirect_to blogs_path
    elsif !@blog.public && current_user != @blog.user
      flash[:warning] = 'Not authorized to view non-public blog'
      redirect_to blogs_path
    end
  end

  def new
    @blog = current_user.blogs.new
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    if @blog.save
      redirect_to @blog
    else
      flash.now[:danger] = @blog.errors.full_messages.first
    end
  end

  def edit
    @blog = current_user.blogs.find_by(id: params[:id])
    return unless blog_exists?(@blog)
  end

  def update
    @blog = current_user.blogs.find_by(id: params[:id])
    if blog_exists?(@blog)
      params[:blog].each do |attribute, value|
        @blog[attribute] = value
      end
      if @blog.save
        redirect_to blog_path(@blog)
      else
        flash.now[:danger] = @blog.errors.full_messages.first
      end
    end
  end

  def destroy
    blog = current_user.blogs.find_by(id: params[:id])
    blog&.destroy
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :category, :public)
  end

  def authenticate
    unless logged_in?
      flash[:warning] = 'You must be logged in'
      redirect_to login_path
    end
  end
end

class BlogsController < ApplicationController
  def index
    if logged_in?
      @blogs = Blog.where(public: true).or(Blog.where(user: current_user))
    else
      @blogs = Blog.where(public: true)
    end
  end
  def indexByUser
    @user = User.find_by(id: params[:user_id].downcase)
    @blogs = Blog.where(user: @user)
  end
  def indexByCategory
    @category = params[:category].downcase
    @blogs = Blog.where(category: @category)
  end
  def show
    @blog = Blog.find_by(id: params[:id])
    if @blog.nil?
      flash["warning"] = "Sorry! That blog doesn't exist"
      redirect_to blogs_path
    end
  end
  def new
    return unless authenticated?
    @blog = current_user.blogs.new
  end
  def create
    return unless authenticated?
    @blog = current_user.blogs.new(blog_params)
    if @blog.save
      redirect_to @blog
    else
      flash.now["danger"] = @blog.errors.full_messages.first
      render 'new'
    end
  end
  def edit
    return unless authenticated?
    @blog = current_user.blogs.find_by(id: params[:id])
    if @blog.nil?
      flash["warning"] = "Sorry! That blog doesn't exist"
      redirect_to blogs_path
    end
  end
  def update
    return unless authenticated?
    @blog = current_user.blogs.find_by(id: params[:id])
    if @blog.nil?
      flash["warning"] = "Sorry! That blog doesn't exist"
      redirect_to blogs_path
    else
      params[:blog].each do |attribute, value|
        @blog[attribute] = value
      end
      if @blog.save
        redirect_to blog_path(@blog)
      else
        flash.now["danger"] = @blog.errors.full_messages.first
        render 'edit'
      end
    end
  end
  def destroy
    return unless authenticated?
    blog = current_user.blogs.find_by(id: params[:id])
    if not blog.nil?
      blog.destroy
    end
    redirect_to blogs_path
  end
  private
    def blog_params
      params.require(:blog).permit(:title, :content, :category, :public)
    end
end

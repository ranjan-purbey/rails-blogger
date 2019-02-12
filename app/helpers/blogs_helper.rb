# frozen_string_literal: true

module BlogsHelper
  def blog_exists?(blog)
    return true unless blog.nil?

    flash[:warning] = "Sorry! That blog doesn't exist"
    redirect_to blogs_path
    false
  end
end

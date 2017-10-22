class CreateBlogMailer < ApplicationMailer
  def create_blog(blog)
    @blog = blog

    mail to: @blog.user.email, subject: "確認メール "
  end
end

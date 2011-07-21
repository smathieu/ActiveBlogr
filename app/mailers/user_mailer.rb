class UserMailer < ActionMailer::Base
  default :from => 'no-reply@activeblogr.com'

  def blog_reminder(blog)
    mail(:to => blog.email, :subject => "Don't forget to blog !!!")  
  end
end

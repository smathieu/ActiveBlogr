class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def blog_reminder(blog)
    mail(:to => blog.email, :subject => "Don't forget to blog!!!")  
  end
end

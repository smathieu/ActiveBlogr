
namespace :email do
  task "test_email" => :environment do
    Blog.all.each do |blog|
      UserMailer.blog_reminder(blog).deliver
    end
  end

  task "send mail" do 
    Blog.all.each do |blog|
      blog.maybe_notify
    end
  end
end

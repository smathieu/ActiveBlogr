
namespace :email do
  task "send_mail_notifications" => :environment do 
    Blog.maybe_notify_all
  end
end

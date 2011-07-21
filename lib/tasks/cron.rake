desc "Fetch RSS and send emails"
task :cron => :environment do
  puts "Updating RSS feeds..."

  Blog.update_all_rss

  puts "Sending email..."
  Blog.maybe_notify_all

  puts "done."
end


namespace :rss do
  desc 'Fetch one update'
  task :fetch_test do
    url = 'http://blog.simonmathieu.com/rss'
    rss = RSS::Parser.parse(open(url).read, false)
    rss.items.each { |i| puts "#{i.title} - #{i.date}" }
    item = rss.items.first
    puts "Last updated #{item.date}"
  end

  task :update_all => :environment do
    Blog.all.each do |blog|
      rss = RSS::Parser.parse(open(blog.rss_feed).read, false)
      item = rss.items.first
      last_updated = item.date
      blog.last_post = last_updated
      blog.save
    end
  end
end

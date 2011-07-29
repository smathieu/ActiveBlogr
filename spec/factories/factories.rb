require 'factory_girl'

Factory.define :blog do |f|
  f.email 'test@example.com' 
  f.rss_feed 'http://feed.com/feed.xml'
  f.days_between_posts 1
end

Factory.define :blog_with_invalid_rss_feed, :parent => :blog do |f|
  f.rss_feed 'foobar'
end

Factory.define :deleted_blog, :parent => :blog do |f|
  f.deleted_at DateTime.now
end

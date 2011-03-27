require 'factory_girl'

Factory.define :blog do |f|
  f.email 'test@example.com' 
  f.rss_feed 'http://feed.com/feed.xml'
end

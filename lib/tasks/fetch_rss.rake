namespace :rss do
  desc "Update all rss feeds"
  task :update_all => :environment do
    Blog.update_all_rss
  end
end

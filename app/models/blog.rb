class Blog < ActiveRecord::Base
  validates_presence_of :email, :rss_feed, :days_between_posts
  validates_numericality_of :days_between_posts, :greater_than => 0

  def maybe_notify
    if last_post && days_between_posts
      last_email_sent ||= 1.year.ago
      if last_post + days_between_posts.days < DateTime.now && last_email_sent < last_post
        UserMailer.blog_reminder(self).deliver
      end
    end
  end

  def update_rss
    begin
      rss = RSS::Parser.parse(open(self.rss_feed).read, false)
      item = rss.items.first
      last_updated = item.date
      self.last_post = last_updated
      self.save
    rescue
      # Swallow exception. 
      # TODO after to many errors, delete record
    end
  end

  def self.update_all_rss
    Blog.all.each do |blog|
      blog.update_rss
    end
  end

  def self.maybe_notify_all
    Blog.all.each do |blog|
      blog.maybe_notify
    end
  end
end

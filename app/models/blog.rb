class Blog < ActiveRecord::Base
  validates_presence_of :email, :rss_feed, :days_between_posts
  validates_numericality_of :days_between_posts, :greater_than => 0
  before_create { generate_token(:token) }

  def maybe_notify
    if last_post && days_between_posts
      last_email_sent = self.last_email_sent || 1.year.ago
      if last_post + days_between_posts.days < DateTime.now && last_email_sent < last_post
        UserMailer.blog_reminder(self).deliver
        update_attribute :last_email_sent, Time.now
      end
    end
  end

  def update_rss
    begin
      rss = RSS::Parser.parse(open(self.rss_feed).read, false)
    rescue
      return false
    end

    item = rss.items.first
    self.last_post = item.date.to_s
    self.save!
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

  private
  def generate_token(column)
    begin
      self[column] = SecureRandom.base64
    end while self.class.exists?(column => self[column])
  end
end

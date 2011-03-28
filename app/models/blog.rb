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
end

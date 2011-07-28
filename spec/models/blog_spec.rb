require 'spec_helper'

describe Blog do
  let(:blog) { Factory(:blog) }

  it "should generate unique token" do
    blog.token.should_not be_nil
  end

  it "notify by email when the last post if older than the time between required post" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago

    UserMailer.expects(:blog_reminder).with(blog).returns(stub('mailer', :deliver => nil))
    blog.maybe_notify
    blog.reload.last_email_sent.should_not be_nil
  end

  it "does not notify by email when the last post if older than the time between required post" do
    blog.days_between_posts = 7
    blog.last_post = 6.days.ago

    UserMailer.expects(:blog_reminder).never
    blog.maybe_notify
  end

  it "does not notify by email when the last post if younger than the time between required post but an email has already been sent" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago
    blog.last_email_sent = 1.day.ago

    UserMailer.expects(:blog_reminder).never
    blog.maybe_notify
  end

  it "notify by email when the last post if older than the time between required post and last email sent is older than post" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago
    blog.last_email_sent = 9.day.ago

    UserMailer.expects(:blog_reminder).with(blog).returns(stub('mailer', :deliver => nil))
    blog.maybe_notify
    blog.reload.last_email_sent.should_not be_nil
  end

  it "should update all rss feeds" do
    blog.update_rss
  end
end

describe 'Blog with valid RSS feed', :type => Blog do
  let(:blog) { Factory(:blog, :rss_feed => 'http://blog.simonmathieu.com/rss') }

  it "should update rss" do
    blog.last_post.should be_nil 
    blog.update_rss.should be_true
    blog.reload.last_post.should_not be_nil 
  end
end

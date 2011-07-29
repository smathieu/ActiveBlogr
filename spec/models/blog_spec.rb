require 'spec_helper'

RSpec::Matchers.define :send_email do |expected|
  match do |blog|
    deliveries = UserMailer.deliveries
    lambda { blog.maybe_notify }.should change(deliveries, :size).by(1)
    blog.reload.last_email_sent.present?
  end
end

describe Blog do
  let(:blog) { Factory(:blog) }

  it "should generate unique token" do
    blog.token.should_not be_nil
  end

  it "notify by email when the last post if older than the time between required post" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago

    blog.should send_email
  end

  it "does not notify by email when the last post if older than the time between required post" do
    blog.days_between_posts = 7
    blog.last_post = 6.days.ago

    blog.should_not send_email
  end

  it "does not notify by email when the last post if younger than the time between required post but an email has already been sent" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago
    blog.last_email_sent = 1.day.ago

    blog.should_not send_email
  end

  it "notify by email when the last post if older than the time between required post and last email sent is older than post" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago
    blog.last_email_sent = 9.day.ago
    blog.should send_email
  end

  it "should update all rss feeds" do
    blog.update_rss
  end

  it "should be soft deletable" do
    blog.destroy 
    blog.deleted_at.should_not be_nil
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

describe "Deleted blog" do
  let(:blog) { Factory(:deleted_blog) }

  it "should not notify by email" do
    blog.days_between_posts = 7
    blog.last_post = 8.days.ago

    blog.should_not send_email
  end
end

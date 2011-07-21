require 'spec_helper'

describe Blog do
  before do
    @blog = Factory(:blog)
  end

  it "notify by email when the last post if older than the time between required post" do
    @blog.days_between_posts = 7
    @blog.last_post = 8.days.ago

    UserMailer.expects(:blog_reminder).with(@blog).returns(stub('mailer', :deliver => nil))
    @blog.maybe_notify
  end

  it "does not notify by email when the last post if older than the time between required post" do
    @blog.days_between_posts = 7
    @blog.last_post = 6.days.ago

    UserMailer.expects(:blog_reminder).never
    @blog.maybe_notify
  end

  it "should update all rss feeds" do
    @blog.update_rss
  end
end

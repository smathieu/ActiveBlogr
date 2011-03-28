class CreateTableBlog < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :email
      t.string :rss_feed
      t.datetime :last_email_sent
      t.datetime :last_post
      t.integer :days_between_posts
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end

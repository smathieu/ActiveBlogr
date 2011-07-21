class AddTokenToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :token, :string
  end

  def self.down
    remove_column :blogs, :token
  end
end

class RemoveTimestampFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :created_at
    remove_column :users, :updated_at
  end

  def down
    add_column :users, :updated_at, :datetime
    add_column :users, :created_at, :datetime
  end
end

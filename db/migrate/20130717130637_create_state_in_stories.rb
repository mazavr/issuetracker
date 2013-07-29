class CreateStateInStories < ActiveRecord::Migration
  def up
    add_column :stories, :state, :string
  end

  def down
    remove_column :stories, :state
  end
end

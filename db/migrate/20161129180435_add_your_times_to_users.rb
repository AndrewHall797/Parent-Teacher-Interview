class AddYourTimesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :your_times, :text
  end
end

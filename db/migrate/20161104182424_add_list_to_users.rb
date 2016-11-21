class AddListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :list, :string
  end
end

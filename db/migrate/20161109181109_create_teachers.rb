class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :last
      t.string :email
      t.string :password
      t.text :times
      t.text :reserved

      t.timestamps null: false
    end
  end
end

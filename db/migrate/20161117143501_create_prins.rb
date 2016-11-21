class CreatePrins < ActiveRecord::Migration
  def change
    create_table :prins do |t|
      t.string :name
      t.string :last_name
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.string :email

      t.timestamps null: false
    end
  end
end

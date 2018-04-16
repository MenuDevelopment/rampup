class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password
      t.float :weight
      t.integer :age
      t.integer :height

      t.timestamps
    end
  end
end

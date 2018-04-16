class ChangeHeightToString < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :height, :string
  end
end

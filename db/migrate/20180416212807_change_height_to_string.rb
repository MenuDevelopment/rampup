class ChangeHeightToString < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :height, :string
    change_column :users, :weight, :integer
  end
end

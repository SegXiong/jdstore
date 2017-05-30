class FixColumnTitle < ActiveRecord::Migration[5.0]
  def change
    rename_column :river_pics, :avatar, :rvatar
  end
end

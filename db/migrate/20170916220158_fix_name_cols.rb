class FixNameCols < ActiveRecord::Migration[5.1]
  def change
  rename_column :genres, :gname, :name
  rename_column :subgenres, :subgname, :name
  end
end

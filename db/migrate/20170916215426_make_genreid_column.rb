class MakeGenreidColumn < ActiveRecord::Migration[5.1]
  def change
  add_column :subgenres, :genre_id, :integer
  end
end

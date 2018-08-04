class AddGenreToCompleted < ActiveRecord::Migration[5.1]
  def change
  add_column :completeds, :genre_id, :integer
  end
end

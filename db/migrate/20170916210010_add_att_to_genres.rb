class AddAttToGenres < ActiveRecord::Migration[5.1]
  def change
    add_column :genres, :gname, :string
  end
end

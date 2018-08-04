class AddAttToSubgenres < ActiveRecord::Migration[5.1]
  def change
    add_column :subgenres, :gid, :integer
    add_column :subgenres, :subgname, :string
  end
end

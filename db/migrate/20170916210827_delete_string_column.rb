class DeleteStringColumn < ActiveRecord::Migration[5.1]
  def change
  remove_column :genres, :string
  end
end

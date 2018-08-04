class DeleteGidColumn < ActiveRecord::Migration[5.1]
  def change
  remove_column :subgenres, :gid
  end
end

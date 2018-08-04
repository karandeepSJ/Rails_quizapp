class AddLifeline < ActiveRecord::Migration[5.1]
  def change
  add_column :states, :slused, :boolean
  add_column :states, :smused, :boolean
  end
end

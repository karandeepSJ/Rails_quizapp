class ModifyLifeline < ActiveRecord::Migration[5.1]
  def change
   remove_column :states, :slused, :boolean
   remove_column :states, :smused, :boolean
   add_column :states, :slused, :boolean, :default => false
   add_column :states, :smused, :boolean, :default => false
     
  end
end

class AddStateAttr < ActiveRecord::Migration[5.1]
  def change
  	add_column :states, :user_id, :integer
  	add_column :states, :subgenre_id, :integer
  	add_column :states, :qno, :integer
  	add_column :states, :score, :integer
  end
end

class MakeCompleted < ActiveRecord::Migration[5.1]
  def change
  add_column :completeds, :user_id, :integer
  add_column :completeds, :subgenre_id, :integer
  add_column :completeds, :score, :integer

  end
end

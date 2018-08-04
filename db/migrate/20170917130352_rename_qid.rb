class RenameQid < ActiveRecord::Migration[5.1]
  def change
  rename_column :states, :question_id, :q_no
  end
end

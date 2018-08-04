class RemoveQno < ActiveRecord::Migration[5.1]
  def change
  remove_column :questions, :qno
  rename_column :states, :qno, :question_id
  end
end

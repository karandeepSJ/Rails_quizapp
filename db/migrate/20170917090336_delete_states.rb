class DeleteStates < ActiveRecord::Migration[5.1]
  def change
  	drop_table :states
  end
end

class RenameType < ActiveRecord::Migration[5.1]
  def change
  rename_column :questions, :type, :qtype
  end
end

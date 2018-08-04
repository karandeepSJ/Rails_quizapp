class AddQType < ActiveRecord::Migration[5.1]
  def change
  add_column :questions, :qno, :integer
  add_column :questions, :type, :string
  end
end

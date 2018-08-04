class CreateSubgenres < ActiveRecord::Migration[5.1]
  def change
    create_table :subgenres do |t|

      t.timestamps
    end
  end
end

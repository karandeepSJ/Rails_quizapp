class AddQuestionAttr < ActiveRecord::Migration[5.1]
  def change
  	add_column :questions, :subgenre_id, :integer
  	add_column :questions, :q, :string
  	add_column :questions, :option1, :string
  	add_column :questions, :option2, :string
  	add_column :questions, :option3, :string
  	add_column :questions, :option4, :string
  	add_column :questions, :answer, :string

  end
end

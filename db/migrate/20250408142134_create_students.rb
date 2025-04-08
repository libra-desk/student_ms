class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :branch
      t.string :email
      t.string :phone_number
      t.string :year_of_study

      t.timestamps
    end
  end
end

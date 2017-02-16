class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :category, index: true, foreign_key: true
      t.references :user, index:true, foreign_key: true
      t.boolean :is_completed

      t.timestamps
    end
  end
end

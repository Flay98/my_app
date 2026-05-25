class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end

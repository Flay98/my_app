class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.references :task, null: false, foreign_key: true
      t.string :file_name, null: false
      t.text :description

      t.timestamps
    end
  end
end

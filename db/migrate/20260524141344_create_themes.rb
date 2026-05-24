class CreateThemes < ActiveRecord::Migration[7.2]
  def change
    create_table :themes do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
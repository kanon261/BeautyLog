class CreateTreatments < ActiveRecord::Migration[8.1]
  def change
    create_table :treatments do |t|
      t.integer :category
      t.date :treatment_date
      t.date :next_due_date
      t.integer :price
      t.text :memo
      t.references :salon, null: false, foreign_key: true

      t.timestamps
    end
  end
end

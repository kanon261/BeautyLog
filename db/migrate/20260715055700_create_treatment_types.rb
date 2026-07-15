class CreateTreatmentTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :treatment_types do |t|
      t.integer :category
      t.integer :standard_cycle_days

      t.timestamps
    end
  end
end

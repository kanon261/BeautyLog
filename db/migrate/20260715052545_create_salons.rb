class CreateSalons < ActiveRecord::Migration[8.1]
  def change
    create_table :salons do |t|
      t.string :name
      t.string :area
      t.string :phone_number

      t.timestamps
    end
  end
end

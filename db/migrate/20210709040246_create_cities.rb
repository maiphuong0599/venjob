class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :regions, null: false, foreign_key: true
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end

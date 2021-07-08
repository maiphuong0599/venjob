class CreateCitiesCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :cities_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end

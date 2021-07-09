class CreateCompaniesCities < ActiveRecord::Migration[6.1]
  def change
    create_table :companies_cities do |t|
      t.references :companies, null: false, foreign_key: true
      t.references :cities, null: false, foreign_key: true

      t.timestamps
    end
  end
end

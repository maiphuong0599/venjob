class CreateCitiesJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :cities_jobs do |t|
      t.references :cities, null: false, foreign_key: true
      t.references :jobs, null: false, foreign_key: true

      t.timestamps
    end
  end
end

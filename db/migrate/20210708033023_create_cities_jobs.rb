class CreateCitiesJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :cities_jobs do |t|
      t.references :job, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end

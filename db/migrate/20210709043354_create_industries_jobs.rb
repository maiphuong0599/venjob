class CreateIndustriesJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :industries_jobs do |t|
      t.references :jobs, null: false, foreign_key: true
      t.references :industries, null: false, foreign_key: true

      t.timestamps
    end
  end
end

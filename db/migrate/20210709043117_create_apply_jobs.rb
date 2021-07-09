class CreateApplyJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :apply_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.binary :cv

      t.timestamps
    end
  end
end

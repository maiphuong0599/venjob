class CreateFavoriteJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :jobs, null: false, foreign_key: true

      t.timestamps
    end
  end
end

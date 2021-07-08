class CreateFavouritesJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end

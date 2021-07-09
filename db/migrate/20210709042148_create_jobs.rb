class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.references :companies, null: false, foreign_key: true
      t.string :title
      t.text :overview
      t.text :requirement
      t.text :other_requirement
      t.integer :salary
      t.string :type
      t.string :level
      t.integer :experience
      t.string :degree
      t.string :benefits
      t.datetime :expired_at
      t.timestamps
    end
  end
end

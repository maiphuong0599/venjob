class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :overview
      t.text :requirement
      t.text :other_requirement
      t.integer :salary
      t.string :type
      t.string :level
      t.integer :experience
      t.string :benefits
      t.string :degree
      t.datetime :expired_at
      t.timestamps
    end
  end
end

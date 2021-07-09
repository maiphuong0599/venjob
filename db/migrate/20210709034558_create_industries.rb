class CreateIndustries < ActiveRecord::Migration[6.1]
  def change
    create_table :industries do |t|
      t.string :name
      t.timestamps
    end
  end
end

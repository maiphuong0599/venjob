class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.integer :total_employee
      t.string :type
      t.string :benefits
      t.text :message
      t.timestamps
    end
  end
end

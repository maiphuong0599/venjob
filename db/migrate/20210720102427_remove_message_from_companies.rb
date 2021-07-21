class RemoveMessageFromCompanies < ActiveRecord::Migration[6.1]
  def change
    remove_column :companies, :message, :text
    remove_column :companies, :benefits, :string
    remove_column :companies, :type, :string
    remove_column :companies, :total_employee, :integer
  end
end

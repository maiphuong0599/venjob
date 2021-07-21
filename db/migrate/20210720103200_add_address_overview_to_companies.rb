class AddAddressOverviewToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :address, :string
    add_column :companies, :overview, :text
  end
end

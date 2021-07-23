class ChangeCompanies < ActiveRecord::Migration[6.1]
  def change
    change_column :companies, :address, :text
  end
end

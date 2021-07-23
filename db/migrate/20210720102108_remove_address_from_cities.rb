class RemoveAddressFromCities < ActiveRecord::Migration[6.1]
  def change
    remove_column :cities, :address, :string
  end
end

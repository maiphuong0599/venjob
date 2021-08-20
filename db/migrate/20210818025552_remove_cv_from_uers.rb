class RemoveCvFromUers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :cv
  end
end

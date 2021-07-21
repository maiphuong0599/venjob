class ChangeJobs < ActiveRecord::Migration[6.1]
  def up
    change_column :jobs, :salary, :string
    remove_column :jobs, :industries_type, :text
    remove_column :jobs, :location, :text
  end

  def down
    change_column :jobs, :salary, :integer
    change_column :jobs, :industries_type, :text
    change_column :jobs, :location, :text
  end
end

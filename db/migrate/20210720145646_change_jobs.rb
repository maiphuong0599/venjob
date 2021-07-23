class ChangeJobs < ActiveRecord::Migration[6.1]
  def up
    change_column :jobs, :experience, :string
  end

  def down
    change_column :jobs, :experience, :integer
  end
end

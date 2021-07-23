class ChangeJobs < ActiveRecord::Migration[6.1]
  def up
    change_column :jobs, :experience, :string
    change_column :jobs, :salary, :string
    rename_column :jobs, :type, :job_type
  end

  def down
    change_column :jobs, :experience, :integer
    change_column :jobs, :salary, :integer
  end
end

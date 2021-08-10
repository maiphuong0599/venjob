class RemoveCvFromApplyJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :apply_jobs, :cv, :binary
  end
end

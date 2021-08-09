class AddNameEmailToApplyJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :apply_jobs, :name, :string
    add_column :apply_jobs, :email, :string
  end
end

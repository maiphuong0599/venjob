class RemoveDegreeFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :degree, :string
  end
end

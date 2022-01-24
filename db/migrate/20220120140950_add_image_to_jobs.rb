class AddImageToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :image_url, :string
  end
end

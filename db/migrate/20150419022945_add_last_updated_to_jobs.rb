class AddLastUpdatedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :last_updated, :timestamp
  end
end

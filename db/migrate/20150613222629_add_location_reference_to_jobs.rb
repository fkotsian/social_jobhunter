class AddLocationReferenceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :location_id, :integer
    
    add_index :jobs, :location_id
  end
end

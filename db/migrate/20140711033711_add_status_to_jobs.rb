class AddStatusToJobs < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
      t.string :status, default: "Open"
    end
    
    add_index :jobs, :status
  end
end

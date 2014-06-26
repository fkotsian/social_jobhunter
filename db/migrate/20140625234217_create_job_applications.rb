class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :job, index: true, null: false
      t.references :applicant, index: true, null: false
      t.string :status, default: 'Applied'

      t.timestamps
    end
    
    add_index :job_applications, :status
  end
end

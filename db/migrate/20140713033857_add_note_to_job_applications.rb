class AddNoteToJobApplications < ActiveRecord::Migration
  def change
    add_column :job_applications, :note, :string
  end
end

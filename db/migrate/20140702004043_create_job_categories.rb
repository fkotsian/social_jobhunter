class CreateJobCategories < ActiveRecord::Migration
  def change
    create_table :job_categories do |t|
      t.string :name, null: false
      t.timestamps
    end
    
    add_index :job_categories, :name
  end
end

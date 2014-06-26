class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.references :company, index: true, null: false
      t.string :category
      t.string :url
      t.integer :salary_bottom
      t.integer :salary_top

      t.timestamps
    end
    
    add_index :jobs, :title
    add_index :jobs, :url, unique: true
    add_index :jobs, :category
    add_index :jobs, :salary_bottom
    add_index :jobs, :salary_top
  end
end

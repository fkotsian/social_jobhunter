class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.references :company, index: true, null: false
      t.integer :category_id
      t.string :url
      t.integer :salary_bottom
      t.integer :salary_top

      t.timestamps
    end
    
    add_index :jobs, :title
    add_index :jobs, :url, unique: true
    add_index :jobs, :category_id
    add_index :jobs, :salary_bottom
    add_index :jobs, :salary_top
  end
end

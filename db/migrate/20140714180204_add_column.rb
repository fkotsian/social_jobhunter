class AddColumn < ActiveRecord::Migration
  def change
    add_column :companies, :company_url, :string
  end
end

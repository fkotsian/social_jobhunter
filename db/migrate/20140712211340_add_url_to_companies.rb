class AddUrlToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :url, :string
    add_index  :companies, :url, unique: true
  end
end

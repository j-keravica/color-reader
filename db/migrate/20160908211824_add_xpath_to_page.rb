class AddXpathToPage < ActiveRecord::Migration
  def change
    add_column :pages, :xpath, :string
  end
end

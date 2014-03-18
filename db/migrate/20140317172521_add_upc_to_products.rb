class AddUpcToProducts < ActiveRecord::Migration
  def change
    add_column :products, :upc, :string
  end
end

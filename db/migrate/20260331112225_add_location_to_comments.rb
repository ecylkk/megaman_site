class AddLocationToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :location, :string
  end
end

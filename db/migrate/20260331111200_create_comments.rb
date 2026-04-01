class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :stage_id
      t.string :nickname
      t.text :body
      t.string :ip_address
      t.string :device_info

      t.timestamps
    end
  end
end

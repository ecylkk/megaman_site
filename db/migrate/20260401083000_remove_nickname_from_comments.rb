class RemoveNicknameFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :nickname, :string
  end
end

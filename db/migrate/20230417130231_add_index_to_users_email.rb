class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    # usersテーブルのemailカラムにインデックスを追加
    add_index :users, :email, unique: true
  end
end

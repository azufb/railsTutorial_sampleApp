class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    # defaultはfalseにして、デフォルトでは管理者になれないようにする
    add_column :users, :admin, :boolean, default: false
  end
end

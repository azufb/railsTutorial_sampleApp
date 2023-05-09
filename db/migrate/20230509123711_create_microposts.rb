class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # インデックスを付与することで、マイクとポストを作成時刻の逆順で取り出しやすくなる
    # 2つを1つの配列にまとめて、複合キーインデックスを作成している
    add_index :microposts, [:user_id, :created_at]
  end
end

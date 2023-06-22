class AddIndexToUsersEmail < ActiveRecord::Migration[5.1] # データーベース上でのメールアドレスの一意性を確立するためのマイグレーション。メールにインデックスを作成し、それぞれの一意性を保つ。
  def change
    add_index :users, :email, unique: true
  end
end

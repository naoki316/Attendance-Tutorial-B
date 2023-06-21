class CreateUsers < ActiveRecord::Migration[5.1] #モデル名は単数形、テーブル名は複数形。
  def change
    create_table :users do |t| #ブロック変数|t|の中でnameとemailカラムをデータベースに作成します。
      t.string :name
      t.string :email

      t.timestamps #自動的に生成される特別なコード(created_at（datetime型）,updated_at（datetime型）)という2つのマジックカラムを生成します。データ型はどちらも日時を取り扱うdatetime型です
    end
  end
end

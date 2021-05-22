### テックキャンプで最終課題として作成したアプリケーションです。

[本番環境はこちらへお進みください。](https://furima-35207.herokuapp.com/)  
BASIC認証  
ID: admin  
Pass: 2222    
購入者用アカウント  
メールアドレス: abc@123  
パスワード: abc123  
出品者用アカウント  
メールアドレス名: abc@234  
パスワード: abc234  
購入用カード情報  
番号：4242424242424242  
期限：2月 / 22年  
セキュリティコード：123  

### 工夫した点
一人で開発ができるようになることを心がけました。

オリジナルアプリの開発やエンジニアとして働くことを見据え、自分の中での問題解決の手順の確立を目指しました。まずはカリキュラムのヒントを見ずに作業工程を考えて実装し、それから模範を確認し自分の方法と比較しています。

また、定期的にフィードバックを行い、ライブラリを利用しもっと簡潔明瞭に実装する方法がないか考えることができるようになるよう意識しました。

### 苦労した点
工数の見積もりに苦労しました。

計画が上手く立てられず、作業が効率化されるどころか焦りを生み、それによってさらに実装が遅れていくという悪循環に陥りました。その経験から時間の見積もりの難しさと大切さを身を持って知りました。

オリジナルアプリの開発では十分余裕ある工数見積もりを行い、また、機能の優先順位を意識し時間内に一つのアプリとして成立させました。APIの仕様上、一部理想とする動作を実現できないことが分かった際は利用する機能の取捨選択を行い別のAPIと組み合わせることで問題を回避し、なんとか完成させました。

# テーブル設計

## users ユーザーテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| phonetic_last      | string | null: false               |
| phonetic_first     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items 商品テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| text          | text       | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| postage_id    | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| day_id        | integer    | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders 購入テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses 配送先テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone         | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order

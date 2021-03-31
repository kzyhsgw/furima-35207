# テーブル設計

## users テーブル

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| email          | string  | null: false |
| password       | string  | null: false |
| nickname       | string  | null: false |
| last_name      | string  | null: false |
| first_name     | string  | null: false |
| phonetic_last  | string  | null: false |
| phonetic_first | string  | null: false |
| birthday_year  | integer | null: false |
| birthday_month | integer | null: false |
| birthday_day   | integer | null: false |

### Association

- has_many :items

## items テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| name       | string     | null: false                    |
| text       | text       | null: false                    |
| category   | integer    | null: false                    |
| condition  | integer    | null: false                    |
| postage    | integer    | null: false                    |
| prefecture | integer    | null: false                    |
| days       | integer    | null: false                    |
| price      | string     | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| postal_code | string     | null: false                    |
| prefecture  | integer    | null: false                    |
| city        | string     | null: false                    |
| address_1   | string     | null: false                    |
| address_2   | string     |                                |
| phone       | string     | null: false                    |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :item

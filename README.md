## users テーブル

| Column                | Type       | Options     |
| ----------------------| -----------| ----------- |
| nickname              | string     | null: false |
| email                 | string     | null: false |
| encrypted_password    | string     | null: false |
| family_name_kanji     | string     | null: false |
| first_name_kanji      | string     | null: false |
| family_name_kana      | string     | null: false |
| first_name_kana       | string     | null: false |
| birthday              | date       | null: false |
| profile               | text       |             |

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :follows
- has_many :user_follows
- has_many :friends

## posts テーブル

| Column                | Type       | Options     |
| ----------------------| -----------| ----------- |
|               | string     | null: false |
|                  | string     | null: false |
| encrypted_password    | string     | null: false |
| family_name_kanji     | string     | null: false |
| first_name_kanji      | string     | null: false |
| family_name_kana      | string     | null: false |
| first_name_kana       | string     | null: false |
| birthday              | date       | null: false |
| profile               | text       |             |

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :follows
- has_many :user_follows
- has_many :friends
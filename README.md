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
- has_many :relationships
- has_many :friend_requests

## posts テーブル

| Column                | Type       | Options           |
| ----------------------| -----------| ----------------- |
| text                  | text       | null: false       |
| user                  | references | foreign_key: true |

### Association

- has_many :comments
- has_many :likes
- belongs_to :user

## comments テーブル

| Column                | Type       | Options           |
| ----------------------| -----------| ----------------- |
| comment               | text       | null: false       |
| user                  | references | foreign_key: true |
| post                  | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## likes テーブル

| Column                | Type       | Options           |
| ----------------------| -----------| ----------------- |
| user                  | references | foreign_key: true |
| post                  | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## follows テーブル

| Column                | Type       | Options           |
| ----------------------| -----------| ----------------- |
| user                  | references | foreign_key: true |

### Association

- has_many :users
- has_many :user_follows

## user_follows テーブル

| Column                | Type       | Options           |
| ----------------------| -----------| ----------------- |
| user                  | references | foreign_key: true |
| follower              | references | foreign_key: true |
| followered            | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :follow

## friends テーブル

| Column         | Type       | Options           |
| ---------------| -----------| ----------------- |
| user_id        | references | foreign_key: true |
| friends        | references | foreign_key: true |

### Association

- has_many :users
- has_many :relationships

## relationships テーブル

| Column         | Type       | Options           |
| ---------------| -----------| ----------------- |
| user_id        | references | foreign_key: true |
| friend_user_id | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :friend

## friend_requests テーブル

| Column         | Type       | Options           |
| ---------------| -----------| ----------------- |
| from_user_id   | references | foreign_key: true |
| to_user_id     | references | foreign_key: true |

### Association

- belongs_to :user
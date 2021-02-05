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
| request_status        | integer    |             |

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :follows
- has_many :user_follows
- has_many :friend_requests
- has_many :messages
- has_many :chats
- has_many :chat_users
- has_many :footprints

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

## friend_requests テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
| from_user_id      | integer    | null: false       |
| to_user_id        | integer    | null: false       |
| requesting_status | integer    | null: false       |

### Association

- belongs_to :user

## messages テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
| content           | text       | null: false       |
| sent_user_id      | integer    | null: false       |
| received_user_id  | integer    | null: false       |
| chat_id           | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :chat
- has_one    :read

## chats テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
|                   |            |                   |

### Association

- has_many :users
- has_many :messages
- has_many :chat_users

## chat_users テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
| created_user_id   | integer    | null: false       |
| invited_user_id   | integer    | null: false       |
| chat_id           | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :chat

## reads テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
| received_user_id  | references | foreign_key: true |
| message_id        | references | foreign_key: true |
| complete          | boolean    | null: false       |

### Association

- belongs_to :message

## footprints テーブル

| Column            | Type       | Options     |
| ----------------- | -----------| ----------- |
| visitor_user_id   | integer    | null: false |
| visited_user_id   | integer    | null: false |

### Association

- belongs_to :user
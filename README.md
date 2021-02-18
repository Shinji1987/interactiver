![Rails](https://img.shields.io/badge/Ruby-2.6.5-blue)
![Rails](https://img.shields.io/badge/Rails-6.0.3.4-blue)
![Rails](https://img.shields.io/badge/MySQL2-0.5.3-blue)

# Interactiver

### アプリの概要説明
海外で飲食店を経営するのは、国内でやる以上にたくさんの問題に直面することが多いと思います。
Interactiverは、そんな海外で飲食店を経営している方々、これからやってみたいと考えている方々が
「過去の経験談」や「ホットな情報」などを共有するコミュニティスペースになります。
海外で事業をしていく上での悩みや問題等、情報等を共有し、相互に助け合えるような場所になることを目指しております。

### アプリのイメージ
![トップページ](https://user-images.githubusercontent.com/76105302/108201171-cde4f500-7162-11eb-9451-93c1f8d2ba95.png)

### アプリのURL
http://35.72.111.10/

### テスト用アカウント
メールアドレス：　admin@sample.com
パスワード：　717ninyuus

### 利用方法
1. 「新規登録」でアカウントを作成します
2. ログインします(新規登録が完了したら自動的にログイン状態に移行します)
3. ヘッダーの検索バーに文字を入力して、ニックネームからユーザーを検索します
4. 検索結果の中から、ユーザーアイコンをクリックし、詳細ページへ移行して、友達申請アイコンをクリックします
5. 自分の詳細ページを確認し、友達申請がある場合は、友達アイコンをクリックして、友達申請を処理します
6. 「思ったことを書きましょう！」から発信したい情報を発信します
7. 必要に応じて各投稿に「いいね」や「コメント」をします
8. ヘッダーの「メッセンジャー」アイコンをクリックし、友達リスト、又は検索バーからチャットしたいユーザーを見つけます
9. 見つけたユーザーの詳細ページへ移行し、「チャット」アイコンをクリックし、メッセージを送ります
10. ヘッダーの「グラフ」アイコンをクリックし、各投稿の「いいね」数をグラフで確認します
11. ヘッダーの「足跡」アイコンをクリックし、自分の詳細ページを閲覧したユーザーを確認します
12. ヘッダーの「セキュリティ」アイコンをクリックし、コミュニケーションを取りたくないユーザーは検索バーから検索してブロックします
13. トップページのサイドバー左下の「知り合いかも」から気になるユーザーをクリックし、友達申請アイコンをクリックして、友達申請をします
14. トップページのサイドバー左上の「為替情報」からUSD→JPYの為替情報を確認します
15. トップページのサイドバー右の「ビジネスニュース」から最新のニュースを確認します
16. ヘッダーの自分のニックネームのアイコンをクリックし、詳細ページの右下にある地図に住所を入力し、お店の場所を確認します
17. 自分の詳細画面から必要なら「編集」アイコンをクリックして、プロフィールを更新します

### テスト方法
- テストツール： RSpec
- テストの種類： 正常系、異常系
- 実施テスト： 単体テスト、結合テスト

### デプロイ方法(手順①〜⑤)
<img src="https://user-images.githubusercontent.com/76105302/108294319-fe677600-71d8-11eb-8e2a-8efa9ba2cd88.png" width="500">

### ライセンス情報
MIT License

Copyright (c) [2021] [Shinji Kato]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



### 目指した課題解決
本アプリを通じて、海外で飲食店事業に関わる人の下記課題を解決しようと試みました。

  1. 海外での飲食店事業に関する情報が日本国内のそれと比べると少ない
  2. 同じ飲食店事業に関わる人と緩く繋がれる専用のコミュニティースペースがない
  3. 事業に関する情報を気軽に共有できるスペースがない
  
海外で飲食店事業に関わる人のコミュニティースペースは、FacebookやMixiなどでもありますが、
多くの場合、下記の課題があると感じました。

  1. 内輪のコミュニティーが多く、拡張性、公共性が低い
  2. 加入者が多くなるほど、投稿する敷居が上がり、多くのユーザーが情報を見るだけの受け身になってしまう
  3. ユーザーを探す時に、同業者なのかどうか判断しずらい
  4. 特に不特定多数の人のコミュニティーの場合、気軽にお店の情報交換などをしづらい
 
上記の課題を解決する為に、「海外で飲食店事業に関わりを持つ人」というニッチなコミュニティー専用の
コミュニティースペースを作ろうと思いました。

### 洗い出した要件
1. 友達関係にあるユーザー間でのみ投稿を共有できること
2. 関わりたくないユーザーの事はブロックできること
3. 友達関係は、いつでも解消できること
4. ダイレクトメッセージが送れること
5. ダイレクトメッセージを見てくれているか確認できること
6. 「知り合いかも」機能などで友達の和が広がる工夫がされていること
7. 自分の投稿に関する他のユーザーのリアクションが集計できること
8. どんなユーザーが自分のプロフィールをみてくれているのか確認できること
9. お店の場所がマップで確認できること
10. ユーザープロフィールはいつでも編集できること
11. 一覧で自分や他ユーザーの友達を確認できること

### 使用言語
<img src="https://user-images.githubusercontent.com/76105302/108214158-2f14c480-7173-11eb-948d-d0e91366acf0.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108214302-5bc8dc00-7173-11eb-9da3-338fdcd3f4d1.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108215013-2cff3580-7174-11eb-83a1-ee5fc395a797.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108215553-cf1f1d80-7174-11eb-880a-d4ffec600fa4.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108215177-60da5b00-7174-11eb-9795-db88dbc8c5c5.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108215250-75b6ee80-7174-11eb-87dd-3095f2aa579d.png" width="60">

### 環境
<img src="https://user-images.githubusercontent.com/76105302/108216440-d266d900-7175-11eb-9bb7-d758b8e07cad.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108216542-f32f2e80-7175-11eb-8375-f0d435e54a1d.png" width="70"> <img src="https://user-images.githubusercontent.com/76105302/108216634-08a45880-7176-11eb-82ec-1f19a7cd44fe.png" width="60">

### テクノロジー
<img src="https://user-images.githubusercontent.com/76105302/108219319-f5df5300-7178-11eb-8201-939a708e1f83.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108219391-0abbe680-7179-11eb-98d4-da34fb42c446.png" width="80"> <img src="https://user-images.githubusercontent.com/76105302/108219500-23c49780-7179-11eb-9b7c-a3a34cc86cfc.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108219582-38a12b00-7179-11eb-90c0-0b4d3bd283a9.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108219671-4d7dbe80-7179-11eb-93f2-4c46754664ad.png" width="60"> <img src="https://user-images.githubusercontent.com/76105302/108219782-638b7f00-7179-11eb-9a81-d7955ea651a2.png" width="60">

### システム構成図
<img src="https://user-images.githubusercontent.com/76105302/108286166-f1905580-71cb-11eb-82a4-f87613ee5edd.png" width="500">




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
| shop_address          | string     | null: false |


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
- has_many :securitys

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

## securitys テーブル

| Column            | Type       | Options     |
| ----------------- | -----------| ----------- |
| block_user_id     | integer    | null: false |
| blocked_user_id   | integer    | null: false |

### Association

- belongs_to :user

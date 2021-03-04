![Ruby](https://img.shields.io/badge/Ruby-2.6.5-blue)
![Rails](https://img.shields.io/badge/Rails-6.0.3.4-blue)
![MySQL](https://img.shields.io/badge/MySQL2-0.5.3-blue)
![Devise](https://img.shields.io/badge/Devise-4.7.3-blue)
![RSpec](https://img.shields.io/badge/RSpec-3.10-blue)
![Capistrano](https://img.shields.io/badge/Capistrano-3.15.0-blue)
![Docker Desctop](https://img.shields.io/badge/Docker%20Desktop-Preview%207-blue)
![Docker-Compose](https://img.shields.io/badge/Docker--Compose-1.27.4-blue)

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

### テスト用ログイン情報
- Basic認証情報<br>
ユーザー名： admin<br>
パスワード： 12345678<br>
- テスト用アカウント情報<br>
メールアドレス：　admin@sample.com<br>
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

### デプロイ方法(Capistranoによる自動デプロイ)
<img src="https://user-images.githubusercontent.com/76105302/109930747-56d76100-7d0b-11eb-8f39-f980fed0a342.png" width="500">





### 目指した課題解決
本アプリを通じて、海外で飲食店事業に関わる人の下記課題を解決しようと試みました。

  1. 海外での飲食店事業に関する情報が日本国内のそれと比べると少ない
  2. 同じ飲食店事業に関わる人と緩く繋がれる専用のコミュニティースペースがない
  3. 事業に関する情報を気軽に共有できるスペースがない
  
海外で飲食店事業に関わる人のコミュニティースペースは、FacebookやMixiなどでもありますが、
多くの場合、下記の課題があると感じました。

  1. 内輪のコミュニティーが多く、拡張性、公共性が低い
  2. 加入者が多くなるほど、投稿する敷居が上がり、多くのユーザーが情報を見るだけの受け身になってしまう
  3. ユーザーを探す時に、同業者なのかどうか判断しづらい
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

### こだわりポイント
1. 友達機能<br>
こだわりポイントは以下5点になります。
    - 友達関係を築くために下記の５つのプロセスを実装した点。<1>友達申請送信(申請者)、<2>友達申請受信(承認者)、<3>友達申請承認・拒否(承認者)、<4>友達関係確立(申請者、承認者)、<5>友達関係解除(申請者、承認者)<br>
    -> 友達関係を築くために５つのプロセスを実装し、お互いが合意の下でのみ友達関係を築けるようにしています。<br>
    - 相手ユーザーと現在どのプロセスの状態にあるのか一目で分かるようにプロセス毎に表示が切り替わる点<br>
    -> 各プロセスに合わせて詳細ページ上にある友達アイコン、検索結果の表示が切り替わるようにしています。<br>
    - 友達関係にあるユーザー同士しか投稿を見れない点<br>
    -> 外部の人の目を気にしなくて良いクローズドな空間を実現するため、友達関係にあるユーザーの投稿しか見れない仕様にしています。<br>
    - 友達リストで一目でどのユーザーと友達関係にあるのか分かるようにした点<br>
    -> 各ユーザーのユーザー詳細ページ上で友達関係にある全ユーザーを確認することができます。<br>
    - 友達機能を元に「知り合いかも」機能を実装し、知り合いを探しやすくした点<br>
    ->「知り合いかも」機能では、自分の友達の友達の中で、自身が友達関係に無いユーザーを表示させる機能になります。
2. ブロック機能<br>
こだわりポイントは以下3点になります。
    - 各ユーザーのブロック状態と友達関係の有無を一覧で確認できる点<br>
    -> ブロック機能用の検索バーで検索すると検索結果として、そのユーザーがブロックされているかの有無、友達関係の有無を確認できるようにしています。<br>
    - ブロックされたユーザーは、ブロックしたユーザーを検索で見つけることができなくなる点<br>
    -> ブロックすると「ブロックしたユーザー」は「ブロックされたユーザー」を検索できるが、「ブロックされたユーザー」は「ブロックしたユーザー」を検索で見つけることができなくなるため、望まないユーザーとは、関係を持たないようにすることができます。<br>
    - ブロックをボタン一つで簡単に解除できる点<br>
    -> ブロック機能のindexページ上でブロックしているユーザーの一覧が表示され、ボタン一つ押すだけでブロックを解除することができます。
3. メッセンジャー機能<br>
こだわりポイントは以下3点になります。
    - 送信・受信メッセージを視覚的に区別できるようにしている点<br>
    -> 送信メッセージは青色のバックグラウンドで右側に表示させ、受信メッセージは白色のバックグラウンドカラーで左側に表示させて、送信・受信メッセージを一目で区別できるようにしています。<br>
    - 既読機能を実装した点<br>
    -> 既読機能により受信者がメッセージを読んだかどうかを、送信者が分かるようにしています。<br>
    - チャット履歴表示機能を実装した点<br>
    -> メッセンジャー機能のindex画面上で過去にチャットをした事があるユーザーの一覧とその時の最後のメッセージを表示させています。
    
### 機能
1. ユーザー機能
    - ユーザー登録
    - ユーザーログイン
    - ユーザー情報編集
![20a68397b3c31e86b5e0a95a229bfa7e](https://user-images.githubusercontent.com/76105302/108310174-41841200-71f6-11eb-8bf1-407cc4215a46.gif)
2. マイページ機能(ユーザー詳細ページ)
    - ユーザーのプロフィール表示
![マイページ](https://user-images.githubusercontent.com/76105302/108311562-988ae680-71f8-11eb-81e6-9f0e57c17494.gif)
3. 投稿機能
    - テキストと画像投稿
![投稿](https://user-images.githubusercontent.com/76105302/108314516-5dd77d00-71fd-11eb-8746-23af17100fba.gif)
4. コメント機能
    - テキストのみのコメント
![コメント](https://user-images.githubusercontent.com/76105302/108314721-b4dd5200-71fd-11eb-91be-2bb72e7c839c.gif)
5. いいね機能
    - 投稿に対する非同期「いいね」
    - 「いいね」数を非同期で表示
    - 「いいね」の非同期解除
![いいね](https://user-images.githubusercontent.com/76105302/108314938-08e83680-71fe-11eb-9b10-2b4d9fc7dba0.gif)
6. 友達機能
    - 友達申請(非同期)
    - 友達申請承認(非同期)
    - 友達申請拒否
    - 友達キャンセル(非同期)
    - 友達リスト
![友達申請](https://user-images.githubusercontent.com/76105302/108315266-83b15180-71fe-11eb-9b64-db3851497b31.gif)
![友達承認](https://user-images.githubusercontent.com/76105302/108315753-41d4db00-71ff-11eb-9eef-f6e6423cb252.gif)
7. ユーザー検索機能
    - ニックネームで曖昧検索
    - 友達申請状態を表示(友達です・友達ではありません・友達申請承認待ちです・友達申請受信済み・ブロック中のユーザーです)
![ユーザー検索](https://user-images.githubusercontent.com/76105302/108317441-a2fdae00-7201-11eb-8cbf-f4882ebaa9a4.gif)
8. ニュース機能
    - NEWS APIによるビジネスニュースの表示
![ニュース](https://user-images.githubusercontent.com/76105302/108317625-e821e000-7201-11eb-869f-13582086979a.gif)
9. メッセンジャー機能
    - テキストと画像のチャット機能
    - 既読機能
    - チャット履歴表示
![メッセンジャー](https://user-images.githubusercontent.com/76105302/108318151-ae050e00-7202-11eb-96bb-d745fd7001ba.gif)
10. 足跡機能
    - 自身のユーザー詳細ページへアクセスしたユーザーを表示
![足跡](https://user-images.githubusercontent.com/76105302/108320313-0093f980-7206-11eb-999e-ea8b18624488.gif)
11. 為替表示機能
    - USD→JPYの為替情報を表示
![為替情報](https://user-images.githubusercontent.com/76105302/108320537-4650c200-7206-11eb-9647-87ad5379abda.gif)
12. いいね数グラフ化機能
    - 自身の投稿に対する「いいね」数を棒グラフで表示
![いいね集計](https://user-images.githubusercontent.com/76105302/108321067-fde5d400-7206-11eb-8765-e2a460325bc0.gif)
13. 地図表示機能
    - Google Map APIで住所を入力すると場所を表示
    - 検索した場所の緯度・経度を表示
![地図](https://user-images.githubusercontent.com/76105302/108321766-f3780a00-7207-11eb-81c6-11ab3cca9086.gif)
14. 知り合いかも機能
    - 自分の友達の友達で自分が友達出ないユーザーを表示
![知り合いかも](https://user-images.githubusercontent.com/76105302/108325506-7a2ee600-720c-11eb-96de-29a3876cea47.gif)
15. ブロック機能
    - ブロックするユーザーの検索機能
    - 各ユーザーのブロック状態表示機能
    - ブロック状態にすると「した側」はそのユーザーを検索できるが、「された側」は「した側」を検索しても表示されなくなる
    - ブロック解除
![ブロック](https://user-images.githubusercontent.com/76105302/108331499-29ba8700-7212-11eb-95f4-0e395a21c405.gif)
![ブロック解除](https://user-images.githubusercontent.com/76105302/108332057-bb29f900-7212-11eb-887a-e5b04c783684.gif)
16. 店舗機能
    - 店舗情報登録
    - 店舗情報編集
17. Basic認証
    - ユーザー名とパスワードによる認証

### 実装予定の機能
1. CI/CD環境の構築
-> 自動テスト、自動デプロイ機能実装
2. ブロック機能の追加実装
-> ブロック時に、検索できないだけでなく、友達関係にある場合、「友達リスト」や「知り合いかも」でも表示されないようにする
3. ユーザーアカウント・投稿・コメント機能の削除機能追加
-> 上記３機能に削除機能を追加し、ユーザービリティを改善する

## データベース設計

### ER図
<img src="https://user-images.githubusercontent.com/76105302/108664536-4f97a280-7516-11eb-858d-dc4eab1d43dc.png" width="800">

### テーブル設計
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
- has_many :friend_requests
- has_many :messages
- has_many :chats
- has_many :chat_users
- has_many :footprints
- has_many :securitys
- has_one  :shop

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

## shops テーブル

| Column            | Type       | Options           |
| ----------------- | -----------| ----------------- |
| shop_name         | string     |                   |
| shop_category_id  | integer    |                   |
| shop_description  | text       |                   |
| shop_address      | string     |                   |
| user_id           | references | foreign_key: true |

### Association

- belongs_to :user

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

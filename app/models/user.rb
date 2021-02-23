class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
        #  :validatable
  
  has_one_attached :image
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :friend_requests, dependent: :destroy
  has_many :chats, through: :chat_users
  has_many :messages, dependent: :destroy
  has_many :chat_users, dependent: :destroy
  has_many :footprints, dependent: :destroy
  has_many :securitys, dependent: :destroy
  has_one  :shop

  validates :nickname, presence: true
                       
  VALID_EMAIL_REGEX = /@/.freeze
  validates :email,              presence: true,
                                 uniqueness: true,
                                 format: { with: VALID_EMAIL_REGEX,
                                 message: 'に@を含めてください' }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password,           on: :create,
                                 presence: true,
                                 length: { minimum: 6 },
                                 confirmation: true,
                                 format: { with: VALID_PASSWORD_REGEX,
                                 message: 'は半角6文字以上、英字・数字それぞれ１文字以上含む必要があります' }

  VALID_FAMILY_NAME_KANJI = /\A[ぁ-んァ-ン一-龥]/.freeze
  validates :family_name_kanji, presence: true,
                                format: { with: VALID_FAMILY_NAME_KANJI,
                                          message: 'は全角ひらがな、カタカナ、漢字を入力する必要がります' }

  VALID_FIRST_NAME_KANJI = /\A[ぁ-んァ-ン一-龥]/.freeze
  validates :first_name_kanji, presence: true,
                               format: { with: VALID_FIRST_NAME_KANJI,
                                         message: 'は全角ひらがな、カタカナ、漢字を入力する必要がります' }

  VALID_FAMILY_NAME_KANA = /\A[ァ-ヶー－]+\z/.freeze
  validates :family_name_kana, presence: true,
                               format: { with: VALID_FAMILY_NAME_KANA,
                                         message: 'は全角カタカナを入力する必要がります' }

  VALID_FIRST_NAME_KANA = /\A[ァ-ヶー－]+\z/.freeze
  validates :first_name_kana, presence: true,
                              format: { with: VALID_FIRST_NAME_KANA,
                                        message: 'は全角カタカナを入力する必要がります' }
  
  validates :birthday, presence: true

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def self.search(search)
    if search != ""
      User.where('nickname LIKE(?)', "%#{search}%")
    end
  end
end
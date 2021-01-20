class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX,
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
end

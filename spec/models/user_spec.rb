require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規登録/ユーザー情報' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it 'emailが重複していたら登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'emailが、@を含んでいなかったら登録できない' do
      @user.email = 'sample'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールに@を含めてください')
    end
    it 'paswordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'passwordは、6文字以上でないと登録できない' do
      @user.password = '717oo'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordは,半角英数字混合でないと登録できない' do
      @user.password = '11111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角6文字以上、英字・数字それぞれ１文字以上含む必要があります')
    end
    it 'passwordは,確認用を含めて2回入力しないと登録できない' do
      @user.password = '1111oooo'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'passwordとpassword confirmationの値が一致しないと登録できない' do
      @user.password = '1111oooo'
      @user.password_confirmation = '7777pppp'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'password：半角英語のみは登録できない' do
      @user.password = 'aaaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角6文字以上、英字・数字それぞれ１文字以上含む必要があります')
    end
    it 'password：全角英数混合は登録できない' do
      @user.password = 'pklj９９９９'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角6文字以上、英字・数字それぞれ１文字以上含む必要があります')
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は,名字がないと登録できない' do
      @user.family_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(全角)の名字を入力してください")
    end
    it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
      @user.family_name_kanji = 'sato'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(全角)の名字は全角ひらがな、カタカナ、漢字を入力する必要がります')
    end
    it 'ユーザー本名は,名前がないと登録できない' do
      @user.first_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(全角)の名前を入力してください")
    end
    it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
      @user.first_name_kanji = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(全角)の名前は全角ひらがな、カタカナ、漢字を入力する必要がります')
    end
    it 'ユーザー本名のフリガナは,名字がないと登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(全角)の名字を入力してください")
    end
    it 'ユーザー本名のフリガナの名字は、全角（カタカナ）で入力しないと登録できない' do
      @user.family_name_kana = '佐藤'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(全角)の名字は全角カタカナを入力する必要がります')
    end
    it 'ユーザー本名のフリガナは,名前がないと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(全角)の名前を入力してください")
    end
    it 'ユーザー本名のフリガナの名前は、全角（カタカナ）で入力しないと登録できない' do
      @user.first_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(全角)の名前は全角カタカナを入力する必要がります')
    end
    it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
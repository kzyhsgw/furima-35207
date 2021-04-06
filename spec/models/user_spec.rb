require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '内容に問題ない場合' do
      it '全ての入力が存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上かつ英字と数字が含まれていれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '＠を含まないemailでは登録できないこと' do
        @user.email = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが全角では登録できないこと' do
        @user.password = '１２３あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが5文字以下では登録できないこと' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが英字だけでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが数字だけでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが半角では登録できないこと' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが半角では登録できないこと' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'phonetic_lastが空では登録できないこと' do
        @user.phonetic_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Phonetic last can't be blank")
      end

      it 'phonetic_lastが半角では登録できないこと' do
        @user.phonetic_last = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic last is invalid')
      end

      it 'phonetic_lastが全角漢字では登録できないこと' do
        @user.phonetic_last = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic last is invalid')
      end

      it 'phonetic_lastが全角ひらがなでは登録できないこと' do
        @user.phonetic_last = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic last is invalid')
      end

      it 'phonetic_firstが空では登録できないこと' do
        @user.phonetic_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Phonetic first can't be blank")
      end

      it 'phonetic_firstが半角では登録できないこと' do
        @user.phonetic_first = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic first is invalid')
      end

      it 'phonetic_firstが全角漢字では登録できないこと' do
        @user.phonetic_first = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic first is invalid')
      end

      it 'phonetic_firstが全角ひらがなでは登録できないこと' do
        @user.phonetic_first = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Phonetic first is invalid')
      end

      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

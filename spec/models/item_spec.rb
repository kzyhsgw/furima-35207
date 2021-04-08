require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '内容に問題ない場合' do
      it '全ての入力が適切であれば登録できること' do
        expect(@item).to be_valid
      end

      it '販売価格が半角数字かつ300~9999999であれば登録できること' do
        @item.price = '123456'
        expect(@item).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '出品写真が空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image を選択してください')
      end

      it '商品名が空では登録できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では登録できないこと' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'カテゴリーを選択しなければ登録できないこと' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end

      it '商品の状態を選択しなければ登録できないこと' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition を選択してください')
      end

      it '配送料の負担を選択しなければ登録できないこと' do
        @item.postage_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage を選択してください')
      end

      it '配送元の地域を選択しなければ登録できないこと' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end

      it '発送までの日数を選択しなければ登録できないこと' do
        @item.day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Day を選択してください')
      end

      it '販売価格が空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が半角数字でなければ登録できないこと' do
        @item.price = '１２３４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
      end

      it '販売価格が300~9999999でなければ登録できないこと' do
        @item.price = '123'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300〜9,999,999で入力してください')
      end
    end
  end
end

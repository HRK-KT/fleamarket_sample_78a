require 'rails_helper'

describe Product do
  describe '#create' do
    # 必須満たしていれば登録できる
    it "is invalid with required items" do
      product = build(:product)
      product.valid?
      expect(product).to be_valid
    end

    # 画像がないと登録できない
    it "is invalid without a images" do
      product = build(:product)
      product.images=[]
      product.valid?
      expect(product.errors.full_messages).to include("画像は1つ以上登録してください")
    end

    # 商品名が登録されていないと登録できない
    it "is invalid without a product_name" do
      product = build(:product, product_name: nil)
      product.valid?
      expect(product.errors[:product_name]).to include("を入力してください")
    end

    # 発送元の地域が選択されていないと登録できない
    it "is invalid without a delivery_area" do
      product = build(:product, delivery_area: nil)
      product.valid?
      expect(product.errors[:delivery_area]).to include("を選択してください")
    end

    # 販売価格が入力されていないと登録できない
    it "is invalid without a price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    # 販売価格が300円未満だと登録できない
    it "is invalid price under 300" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は300~9,999,999の範囲で入力してください")
    end

    # 販売価格が9,999,999円超えだと登録できない
    it "is invalid price over 10000000" do
      product = build(:product, price: 10000000)
      product.valid?
      expect(product.errors[:price]).to include("は300~9,999,999の範囲で入力してください")
    end
  
    # サイズが選択されていないと登録できない
    it "is invalid without a size_id" do
      product = build(:product, size_id: nil)
      product.valid?
      expect(product.errors[:size_id]).to include("を選択してください")
    end

    # 商品の状態が選択されていないと登録できない
    it "is invalid without a product_status_id" do
      product = build(:product, product_status_id: nil)
      product.valid?
      expect(product.errors[:product_status_id]).to include("を選択してください")
    end

    # 配送料の負担が選択されていないと登録できない
    it "is invalid without a delivery_fee_id" do
      product = build(:product, delivery_fee_id: nil)
      product.valid?
      expect(product.errors[:delivery_fee_id]).to include("を選択してください")
    end

    # 発送までの日数が選択されていないと登録できない
    it "is invalid without a delivery_time_id" do
      product = build(:product, delivery_time_id: nil)
      product.valid?
      expect(product.errors[:delivery_time_id]).to include("を選択してください")
    end

    # カテゴリーが選択されていないと登録できない
    it "is invalid without a category" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("を選択してください")
    end

    # 商品説明が登録されていないと登録できない
    it "is invalid without a product_detail" do
      product = build(:product, product_detail: nil)
      product.valid?
      expect(product.errors[:product_detail]).to include("を入力してください")
    end
  end

end


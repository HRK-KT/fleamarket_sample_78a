FactoryBot.define do
  factory :product do
    transient do
      address {Gimei.address}
    end
    product_name { "テスト商品" }
    brand { "test" }
    delivery_area { address.city.kanji}
    price { 40000 }
    size_id { 1 }
    product_status_id { 1 }
    delivery_fee_id { 1 }
    delivery_time_id { 1 }
    category { 1 }
    trading_status { 1 }
    user_id {FactoryBot.create(:user).id}
    product_detail {"商品説明文章"}

    after(:build) do |product|
      product.images <<  FactoryBot.build(:image, product: product)
    end
  end

  factory :image do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.png"), 'image/png') }
  end

end
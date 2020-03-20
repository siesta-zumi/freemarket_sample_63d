include ActionDispatch::TestProcess
FactoryBot.define do

  factory :item do
    name                  {"ハリネズミ"}
    description           {"とってもおいしい"}
    status                {"1"}
    is_bear_shipping_cost {"1"}
    region                {"1"}
    period                {"1"}
    price                 {"35000"}
    selling_status        {"0"}
    user_id               {""}
    category_id           {"1"}
    brand_id              {"1"}

    # ActiveStrageの画像をアタッチ
    after(:build) do |item|

      # 画像をアタッチ 1枚目
      item.item_images.attach(io: File.open(Rails.root.join('spec', 'images', 'test.jpg')), filename: 'test.jpg')

      # 画像をアタッチ 2枚目
      item.item_images.attach(io: File.open(Rails.root.join('spec', 'images', 'test2.jpg')), filename: 'test2.jpg')

    end
  end

end

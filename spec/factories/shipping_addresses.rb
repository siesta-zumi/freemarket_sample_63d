FactoryBot.define do

  factory :shipping_address do
    user_id                         {""}
    postal_code                     {"1500043"}
    prefecture                      {"13"}
    municipalities                  {"渋谷区"}
    block                           {"道玄坂２丁目２３−１２"}
    building_name_room_number       {"フォンティスビル ７F"}
    phone_number                    {"05031873522"}
  end

end

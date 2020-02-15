# DB設計

https://gyazo.com/36c01b70f99c1fb20a9625157a2ae8a5

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_one : identity-information
- has_one : shipping-address
- has_one : card
- has_many : orders
- has_many : items
- has_many : messages

## identity-informationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_furigana|string|null: false|
|last_name_furigana|string|null: false|
|birthday|date|null: false|

### Association
- has_one : users

## shipping-addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|municipalities|string|null: false|
|block|string|null: false|
|building_name_room_number|string||
|phone_number|integer||

### Association
- has_one : users

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|

### Association
- has_one : users

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to : users
- has_one : items

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|desription|text|null: false|
|status|string|null: false|
|is_bear_shipping_cost|integer|null: false|
|region|string|null: false|
|period|string|null: false|
|price|integer|null: false|
|selling_status|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brans_id|integer|null: false, foreign_key: true|

### Association
- has_one : order
- has_many : item-images
- has_one : categoriy
- has_one : brand
- has_many : messages

## item-imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to : item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
has_one : items
has_many : second_categories


## second_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|categories_id|integer|null: false, foreign_key: true|
|name|string|null: false|

### Association
belongs_to : categories
has_many : third_categories


## third_categorieテーブル
|Column|Type|Options|
|------|----|-------|
|second_categories_id|integer|null: false, foreign_key: true|
|name|string|null: false|
### Association
belongs_to : second_category


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
has_one : item


## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|message|text||
|purchase_phase|integer|null: false|

### Association
belongs_to : user
belongs_to : item

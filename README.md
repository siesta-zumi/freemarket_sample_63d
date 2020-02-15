# DB設計

https://gyazo.com/970dd57fbe06cce4f99ea652132acf4e

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
- belongs_tio : user

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
- belongs_to : user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|

### Association
- belongs_to : user

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to : user
- belongs_to : item

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
- belongs_to : categoriy
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
|ancestry|varchar(255)|null: false|

### Association
has_many : items
has_ancestry


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

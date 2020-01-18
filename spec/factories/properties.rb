FactoryBot.define do
  factory :property do
    offer_type { 'sell' }
    property_type { 'apartment' }
    zip_code { '10781' }
    city { 'Berlin' }
    street { 'Boyenstraße' }
    house_number { '50' }
    lng { 13.38815072 }
    lat { 52.53177508 }
    construction_year { 1994 }
    number_of_rooms { 3 }
    currency { 'eur' }
    price { 550_000.0 }
  end
end

class Property < ActiveRecord::Base
  PROPERTY_TYPES =
    %w[
      apartment
      apartment_roof_storey
      apartment_maisonette
      penthouse
      villa
      multi_family_house
      single_family_house
      mid_terrace_house
      semi_detached_house
      end_terrace_house
    ].freeze

  OFFER_TYPES = %w[sell rent].freeze

  RADIUS_FOR_SEARCH = 5000.0.freeze

  validates :zip_code, :city, presence: true
  validates :property_type, inclusion: { in: PROPERTY_TYPES }
  validates :offer_type, inclusion: { in: OFFER_TYPES }

  class << self
    def property_type_valid?(type)
      PROPERTY_TYPES.include?(type)
    end

    def offer_type_valid?(type)
      OFFER_TYPES.include?(type)
    end
  end
end

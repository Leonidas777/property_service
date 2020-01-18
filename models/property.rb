class Property < ActiveRecord::Base
  validates :zip_code, :city, presence: true
end

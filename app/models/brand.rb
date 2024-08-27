class Brand < ApplicationRecord
  has_many :models, dependent: :destroy
end

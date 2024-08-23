class Model < ApplicationRecord
  attr_accessor :brand_name
  belongs_to :brand
end

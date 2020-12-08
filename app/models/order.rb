class Order < ApplicationRecord
  belongs_to :proposal
  has_many :reviews
  has_one :payment
end
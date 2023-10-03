class User < ApplicationRecord
    has_many :check_ins
    has_many :breaks
    has_many :checkouts
  end
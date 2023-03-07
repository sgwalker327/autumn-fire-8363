class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plants, through: :plot_plants
end

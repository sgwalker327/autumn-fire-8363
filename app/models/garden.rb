class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants
end

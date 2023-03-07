class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def plant_list
    plants
    .select('plants.*, count(plants.id) as plant_count')
    .where('days_to_harvest < 100')
    .group(:id)
    .order('plant_count desc')
    .distinct
  end
end

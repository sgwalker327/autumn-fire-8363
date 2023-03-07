require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) } 
    it { should have_many(:plants).through(:plot_plants) } 
  end

  let!(:garden) { Garden.create!(name: 'Turing Community Garden', organic: true) }
  
  let!(:plot_1) { garden.plots.create!(number: 25, size: 'Large', direction: 'East') }
  let!(:plot_2) { garden.plots.create!(number: 19, size: 'Medium', direction: 'West') }
  
  let!(:plant_1) { Plant.create!(name: 'Lavender', description: 'Purple', days_to_harvest: 90) }
  let!(:plant_2) { Plant.create!(name: 'Rosemary', description: 'Green', days_to_harvest: 50) }
  let!(:plant_3) { Plant.create!(name: 'Thyme', description: 'Green', days_to_harvest: 60) }
  let!(:plant_4) { Plant.create!(name: 'Lemon', description: 'Yellow', days_to_harvest: 120) }

  before do
    plant_1.plot_plants.create!(plot: plot_1)
    plant_2.plot_plants.create!(plot: plot_1)
    plant_3.plot_plants.create!(plot: plot_1)
    plant_1.plot_plants.create!(plot: plot_2)
    plant_4.plot_plants.create!(plot: plot_2)
  end
  describe '#instance_methods' do
    describe '#unique_long_harvest_plants' do
      it 'returns a list of unique plants from the garden that take less than 100 days to harvest' do
        expect(garden.unique_long_harvest_plants).to eq([plant_1, plant_2, plant_3])
        expect(garden.unique_long_harvest_plants).to_not eq([plant_1, plant_1, plant_2, plant_3])
        expect(garden.unique_long_harvest_plants).to_not include([plant_4])
      end
    end
  end
end

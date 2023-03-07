require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) } 
    it { should have_many(:plants).through(:plot_plants) } 
  end

  let!(:garden) { Garden.create!(name: 'Turing Community Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Avon Community Garden', organic: true) }
  
  let!(:plot_1) { garden.plots.create!(number: 25, size: 'Large', direction: 'East') }
  let!(:plot_2) { garden.plots.create!(number: 19, size: 'Medium', direction: 'West') }
  let!(:plot_3) { garden2.plots.create!(number: 8, size: 'Small', direction: 'South') }
  
  let!(:plant_1) { Plant.create!(name: 'Lavender', description: 'Purple', days_to_harvest: 90) }
  let!(:plant_2) { Plant.create!(name: 'Rosemary', description: 'Green', days_to_harvest: 50) }
  let!(:plant_3) { Plant.create!(name: 'Thyme', description: 'Green', days_to_harvest: 60) }
  let!(:plant_4) { Plant.create!(name: 'Lemon', description: 'Yellow', days_to_harvest: 120) }
  let!(:plant_5) { Plant.create!(name: 'Huckleberry', description: 'Purple', days_to_harvest: 70) }
  let!(:plant_6) { Plant.create!(name: 'Kale', description: 'Green', days_to_harvest: 110) }
  let!(:plant_7) { Plant.create!(name: 'Cilantro', description: 'Green', days_to_harvest: 30) }

  before do
    plant_1.plot_plants.create!(plot: plot_1)
    plant_2.plot_plants.create!(plot: plot_1)
    plant_3.plot_plants.create!(plot: plot_1)
    plant_1.plot_plants.create!(plot: plot_2)
    plant_4.plot_plants.create!(plot: plot_2)
    plant_5.plot_plants.create!(plot: plot_3)
    plant_6.plot_plants.create!(plot: plot_3)
    plant_7.plot_plants.create!(plot: plot_2)
  end
  describe '#instance_methods' do
    describe '#plant_list' do
      it 'returns a list of unique plants from the garden that take less than 100 days to harvest in order of number of appearances in garden, most to least' do
        
        expect(garden.plant_list).to eq([plant_1, plant_2, plant_3, plant_7])
        expect(garden.plant_list).to_not eq([plant_1, plant_1, plant_2, plant_3, plant_7])
        expect(garden.plant_list).to_not eq([plant_1, plant_1, plant_2, plant_3, plant_5, plant_7])
        expect(garden.plant_list).to_not include([plant_4])
        expect(garden.plant_list).to_not include([plant_6])
        expect(garden.plant_list).to_not include([plant_5])
      end
    end
  end
end

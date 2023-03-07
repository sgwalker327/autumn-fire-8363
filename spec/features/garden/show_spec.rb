require 'rails_helper'

RSpec.describe '/gardens/:id', type: :feature do
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
  
  before do
    plant_1.plot_plants.create!(plot: plot_1)
    plant_2.plot_plants.create!(plot: plot_1)
    plant_3.plot_plants.create!(plot: plot_1)
    plant_1.plot_plants.create!(plot: plot_2)
    plant_4.plot_plants.create!(plot: plot_2)
    plant_5.plot_plants.create!(plot: plot_3)
    plant_6.plot_plants.create!(plot: plot_3)
    
    visit garden_path(garden)
  end

  describe 'As a visitor' do
    context 'When I visit a garden show page' do
      it "Then I see a list of unique plants from the garden that take less than 100 days to harvest" do
        expect(page).to have_content('Turing Community Garden')
        expect(page).to_not have_content('Avon Community Garden')
        expect(page).to have_content("Plants:")
        expect(page).to have_content("Lavender - Days to Harvest: 90 days")
        expect(page).to have_content("Rosemary - Days to Harvest: 50 days")
        expect(page).to have_content("Thyme - Days to Harvest: 60 days")
        expect(page).to_not have_content("Lemon - Days to Harvest: 120 days")
        expect(page).to_not have_content("Kale - Days to Harvest: 110 days")
        expect(page).to_not have_content("Huckleberry - Days to Harvest: 70 days")
        expect("Lavender - Days to Harvest: 90 days").to appear_before("Rosemary - Days to Harvest: 50 days")
        expect("Thyme - Days to Harvest: 60 days").to_not appear_before("Lavender - Days to Harvest: 90 days")
      end
    end
  end
end
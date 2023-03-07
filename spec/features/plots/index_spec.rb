require 'rails_helper'

RSpec.describe '/plots', type: :feature do
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
    
    visit '/plots'
  end
  
  describe 'As a visitor' do
    context 'When I visit the plots index page' do
      it 'I see a list of all plot numbers and their plants listed underneath' do

        
        within "#plot-#{plot_1.id}" do
        expect(page).to have_content(plot_1.number)
        expect(page).to have_content(plant_1.name)
        expect(page).to have_content(plant_2.name)
        expect(page).to have_content(plant_3.name)
        end

        within "#plot-#{plot_2.id}" do
        expect(page).to have_content(plot_2.number)
        expect(page).to have_content(plant_1.name)
        expect(page).to have_content(plant_4.name)
        end
        
      end
    end
  end
end
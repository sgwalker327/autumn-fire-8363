require 'rails_helper'

RSpec.describe '/plots', type: :feature do
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
    plant_2.plot_plants.create!(plot: plot_2)
    plant_5.plot_plants.create!(plot: plot_3)
    plant_6.plot_plants.create!(plot: plot_3)
    plant_7.plot_plants.create!(plot: plot_2)

    visit plots_path
  end
  
  describe 'As a visitor' do
    context 'When I visit the plots index page' do
      it 'I see a list of all plot numbers and their plants listed underneath' do

        within "#plot-#{plot_1.id}" do
          expect(page).to have_content("Plot Number: 25")
          expect(page).to have_content("Lavender")
          expect(page).to have_content("Rosemary")
          expect(page).to have_content("Thyme")
          expect(page).to_not have_content("Lemon")
          expect(page).to_not have_content("Huckleberry")
          expect(page).to_not have_content("Kale")
        end

        within "#plot-#{plot_2.id}" do
          expect(page).to have_content("Plot Number: 19")
          expect(page).to have_content("Lavender")
          expect(page).to have_content("Rosemary")
          expect(page).to have_content("Lemon")
          expect(page).to have_content("Cilantro")
          expect(page).to_not have_content("Thyme")
          expect(page).to_not have_content("Huckleberry")
          expect(page).to_not have_content("Kale")
        end

        within "#plot-#{plot_3.id}" do
          expect(page).to have_content("Plot Number: 8")
          expect(page).to have_content("Huckleberry")
          expect(page).to have_content("Kale")
          expect(page).to_not have_content("Lemon")
        end
      end

      it 'I see a link to remove a plant next to each plant name' do
        within "#plot-#{plot_1.id}" do
          expect(page).to have_link("Remove Lavender")
          expect(page).to have_link("Remove Rosemary")
          expect(page).to have_link("Remove Thyme")
        end
      end

      it 'When I click to remove the plant, I am dedirected to the plot index and no longer see that plant in the plot' do
        
        within "#plot-#{plot_1.id}" do
          click_link("Remove Lavender")
        end

        expect(current_path).to eq(plots_path)

        within "#plot-#{plot_1.id}" do
          expect(page).to_not have_content("Lavender")
          expect(page).to have_content("Rosemary")
          expect(page).to have_content("Thyme")
        end

        within "#plot-#{plot_2.id}" do
          expect(page).to have_content("Lavender")
          expect(page).to have_content("Lemon")
          expect(page).to have_content("Cilantro")
          expect(page).to have_content("Rosemary")
          click_link("Remove Rosemary")
        end

        expect(current_path).to eq(plots_path)

        within "#plot-#{plot_2.id}" do
          expect(page).to have_content("Lavender")
          expect(page).to have_content("Lemon")
          expect(page).to have_content("Cilantro")
          expect(page).to_not have_content("Rosemary")
        end

        within "#plot-#{plot_1.id}" do
          expect(page).to_not have_content("Lavender")
          expect(page).to have_content("Rosemary")
          expect(page).to have_content("Thyme")
        end
      end
    end
  end
end
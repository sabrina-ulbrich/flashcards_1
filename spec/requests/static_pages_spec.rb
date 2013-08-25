require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "should have the content 'Flashcards'" do
      visit '/static_pages/home'
      expect(page).to have_content('Flashcards')
    end

    it "should have the title 'Flashcards'" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Flashcards")
    end
  end
end

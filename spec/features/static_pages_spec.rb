require 'rails_helper'

describe "StaticPages" do

	subject { page }

  describe "Home page" do
  	# visit the root path before each example
  	before { visit root_path }

    it { should have_content('Flashcards') }
		# don't know full_title
    # it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end
end

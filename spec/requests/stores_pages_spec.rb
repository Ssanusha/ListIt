require 'spec_helper'

describe "StoresPages" do
  
  
  
  subject { page }
  
describe "add_item" do

    before { visit add_item_path }
    let(:list_item) { FactoryGirl.create(:list_item) }
    let(:submit) { "foo" }

    describe "with invalid information" do
      it "should not create an item" do
        expect { click_button submit }.not_to change(ListItem, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example item"
        fill_in "Quantity",        with: "2"
       
      end

      it "should create a item" do
        expect { click_button submit }.to change(ListItem, :count).by(1)
      end
    end
  end
end

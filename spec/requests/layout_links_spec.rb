require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
  it "should have a Support page at '/support'" do
    get '/support'
    response.should have_selector('title', :content => "Support")
  end

  it "should have a Store page at '/store'" do
    get '/store'
    response.should have_selector('title', :content => "Store")
  end

  it "should have a Download page at '/download'" do
    get '/download'
    response.should have_selector('title', :content => "Download")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Support"
    response.should have_selector('title', :content => "Support")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should  have_selector('title', :content => "Home")
    click_link "Store"
    response.should  have_selector('title', :content => "Store")
    click_link "Download"
    response.should  have_selector('title', :content => "Download")
  end


end

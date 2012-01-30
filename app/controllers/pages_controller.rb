class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact Us"
  end
  
  def about
    @title = "About"
  end

  def support
    @title = "Support"
  end

  def store
    @title = "Store"
  end
  
  def download
    @title = "Download"
  end
end

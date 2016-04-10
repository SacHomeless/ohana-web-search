class HomeController < ApplicationController
  include CurrentLanguage

  def index
    if request.user_agent =~ /Mobile|webOS/
      redirect_to "http://m.sacsos.org"
    else
      @current_lang = current_language
    end
  end
end

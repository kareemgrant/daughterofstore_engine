class StaticPagesController < ApplicationController
  layout 'static_layout'

  def index
    @stores = Store.online
  end

end

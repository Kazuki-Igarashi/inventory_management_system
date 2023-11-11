class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.order(create_at: :desc)
  end
  
  def index
    
    
  end
  
end

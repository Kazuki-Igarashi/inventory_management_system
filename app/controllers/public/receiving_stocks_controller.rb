class Public::ReceivingStocksController < ApplicationController
  def index
    @receiving_stocks = ReceivingStock.all
    # @items = Item.all
  end

  def new
    @receiving_stock = ReceivingStock.new
  end

  def show
  end

  def create
    @receiving_stock = ReceivingStock.new(receiving_stock_params)
    if @receiving_stock.save
      redirect_to receiving_stocks_path(@receiving_stock.id)
      flash[:notice] = 'The product has been registered'
    else
      @genres = Genre.all
      flash.now[:alert] = 'Could not register product'
      render :new
    end
  end

  def search
  end
  
  private

  def receiving_stock_params
    params.require(:receiving_stock).permit(:name, :explanation, :cost, :image, :is_sales, :stock, :genre_id, :purchase_price, :conpany_name)
  end
  
end

class Public::ReceivingStocksController < ApplicationController
  def index
    @receiving_stocks = ReceivingStock.all
    # @items = Item.all
  end

  def new
    @receiving_stock = ReceivingStock.new
  end

  def show
    @receiving_stock = ReceivingStock.find(params[:id])
    @receiving_stock_sum = ReceivingStock.where(name: @receiving_stock.name).sum(:stock)
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

  def edit
    @receiving_stock = ReceivingStock.find(params[:id])
  end
  
  def update
    @receiving_stock = ReceivingStock.find(params[:id])
      if @receiving_stock.update(receiving_stock_params)
       redirect_to  receiving_stock_path(@receiving_stock.id)
       flash[:notice] = 'Product updated'
      else
        @genres = Genre.all
        flash.now[:alert] = 'Could not update product'
        render  :edit
      end
  end

  def search
  end
  
  def reduce_stock(amount)
    if @receiving_stock >= amount
      @receiving_stock -= amount
    end
  end
  
  private

  def receiving_stock_params
    params.require(:receiving_stock).permit(:name, :explanation, :cost, :image, :is_sales, :stock, :genre_id, :purchase_price, :conpany_name)
  end
  
end

class Public::ReceivingStocksController < ApplicationController
  
  # before_action :authenticate_customer!
  def index
    # @receiving_stocks = ReceivingStock.all
    #ソート機能 
     if params[:latest]
        @receiving_stocks = ReceivingStock.latest
     elsif params[:old]
       @receiving_stocks = ReceivingStock.old
     elsif params[:name]
       @receiving_stocks = ReceivingStock.order_name
     else
       @receiving_stocks = ReceivingStock.all
     end
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
      flash[:notice] = '登録が成功しました。'
    else
      @genres = Genre.all
      flash.now[:alert] = '登録に失敗しました。'
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
       flash[:notice] = '更新が成功しました。'
      else
        @genres = Genre.all
        flash.now[:alert] = '更新が失敗しました。'
        render  :edit
      end
  end

  def search
  end
  
  # 在庫数を減らすメソッド
  def reduce_stock(stock)
    if @receiving_stock >= stock
      @receiving_stock -= stock
    end
  end
  
  private

  def receiving_stock_params
    params.require(:receiving_stock).permit(:name, :explanation, :cost, :image, :is_sales, :stock, :genre_id, :purchase_price, :conpany_name)
  end
  
end

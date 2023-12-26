class Public::IssuesController < ApplicationController
  before_action :authenticate_customer!
  # before_action :is_matching_login_user
  
  def index
    # 検索機能
     search_word = params[:word]
     if search_word
      @receiving_stocks = ReceivingStock.where("name LIKE ?", "%#{search_word}%" )
      # pp "receiving_data--------------#{@receiving_stocks.inspect}"
     else
      @receiving_stocks = ReceivingStock.all
     end
    # ソート機能
     if params[:latest]
       @receiving_stocks = @receiving_stocks.where(is_sales: true).latest.page(params[:page])
     elsif params[:old]
       @receiving_stocks = @receiving_stocks.where(is_sales: true).old.page(params[:page])
     elsif params[:name]
       @receiving_stocks = @receiving_stocks.order_name.page(params[:page])
     else
       @receiving_stocks = @receiving_stocks.where(is_sales: true).page(params[:page])
     end
    #else
       #@receiving_stocks = ReceivingStock.where(is_sales: true)
  end

  def new
    @receiving_stock = ReceivingStock.new
  end

  def show
    @receiving_stock = ReceivingStock.find(params[:id])
    @receiving_stock_sum = ReceivingStock.where(name: @receiving_stock.name).sum(:stock)
    @issue = @receiving_stock.issues.build
  end

  def create
    @issue = current_customer.issues.build(issue_params)
    if @issue.save
      redirect_to shipping_informations_path
      flash[:notice] = '商品を追加しました。'
    else
      @receiving_stock = @issue.receiving_stock
      @receiving_stock_sum = ReceivingStock.where(name: @receiving_stock.name).sum(:stock)
      flash.now[:alert] = 'Could not register product'
      render :show
    end
  end

  # def edit
  #   @receiving_stock = ReceivingStock.find(params[:id])
  # end
  
  def update
    @issue = Issue.find(params[:id])
      if @issue.update(issue_params)
       redirect_to  shipping_informations_path(@issue.id)
       flash[:notice] = 'Product updated'
      else
        @genres = Genre.all
        flash.now[:alert] = 'Could not update product'
        render  :edit
      end
  end
  
  

  def destroy
    issue = Issue.find(params[:id])
    receiving_stock = issue.receiving_stock
    receiving_stock.update(stock: receiving_stock.stock + issue.stock)
    issue.destroy
    redirect_to shipping_informations_path
    flash[:notice] = "商品を削除しました。"
  end
  
  def destroy_all
    issues = current_customer.issues.all
    issues.each do |issue|
      receiving_stock = issue.receiving_stock
      receiving_stock.update(stock: receiving_stock.stock + issue.stock)
    end
    
    issues.destroy_all
    flash[:notice] =  "商品を全て削除しました。"
    redirect_to issues_path
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

  def issue_params
    params.require(:issue).permit(:selling_price, :sales_company_name, :name, :explanation, :cost, :image, :is_sales, :stock, :genre_id, :receiving_stock_id )
  end
end

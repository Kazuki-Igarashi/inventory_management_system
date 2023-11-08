class Public::IssuesController < ApplicationController
  def index
    if params[:latest]
        @receiving_stocks = ReceivingStock.latest
    elsif params[:old]
       @receiving_stocks = ReceivingStock.old
    elsif params[:name]
       @receiving_stocks = ReceivingStock.name
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
    @issue = @receiving_stock.issues.build
  end

  def create
    @issue = current_customer.issues.build(issue_params)
    if @issue.save
      redirect_to shipping_informations_path
      flash[:notice] = 'The product has been registered'
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

  def destroy
    issue = Issue.find(params[:id])
    issue.destroy
    redirect_to shipping_informations_path
    flash[:notice] = "Cart item was successfully destroyed."
  end
  
  def destroy_all
    issues = current_customer.issues.all
    issues.destroy_all
    flash[:notice] =  "Cart item was successfully all destroyed"
    redirect_back fallback_location: root_path
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

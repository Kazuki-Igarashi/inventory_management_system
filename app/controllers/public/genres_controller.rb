class Public::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def new
    @genre = Genre.new(genre_params)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash.now[notice] = "新規登録しました"
      redirect_to genres_path
    else
      flash.now[alert] = "ジャンルが重複していないか確認してください"
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if  @genre.update(genre_params)
      flash.now[notice] = "編集に成功しました"
      redirect_to genres_path
    else
      flash.now[alert] = "編集に失敗しました"
      @genres = Genre.all
      render :index
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end

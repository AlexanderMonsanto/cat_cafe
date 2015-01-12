class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to @cat
    else
      render 'new'
    end
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new

    @search = params[:search]
    list = flickr.photos.search :text => @search, :sort => "relevance"

    @results = list.map do |photo|
      FlickRaw.url_b(photo)
    end

    @photo = @results.sample
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to @cat
    else
      render 'edit'
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :desc, :img)
  end


end

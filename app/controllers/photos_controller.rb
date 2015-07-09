class PhotosController < ApplicationController
  def index
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)

  end
 
  def new
    @photo = Photo.new
  end
 
  def create
    #return render:text => photo_params.inspect
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = "Photo saved!"
      redirect_to photos_path
    else
      render 'new'
    end
  end
 
  private
 
  def photo_params
    params.require(:photo).permit(:image, :title)
  end
end
class Api::PhotosController < ApplicationController

  before_action :require_signed_in, only: [:new, :create]

  def index
    @photos = current_user.photos
    render json: @photos
  end
  
  def show
    @photo = Photo.find(params[:id])
    require_permission_for(@photo.album)
    
    # this is very inacurate b/c we refresh with every like and comment
    # - even now this may not work
    @photo.view_count += 1
    @photo.save!
    
    render json: @photo
  end
  
  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @photo = Photo.find(params[:id]).destroy
    render json: @photo
  end
  
  
  # will only handle one image
  def create
    @photo = Photo.new(image: image_params[:image], album_id: params[:album_id])


    if @album.save
      render json: @photo
    else
      render json: @photo.errors.full_messages, status: :unprocessable_entity
    end
  end

  


#   multiple images API'd YET!
#   def create
#
#     @album = Album.find(params[:album_id])
#
#     @album.photos.new(image_params)
#
#
#     if @album.save
#       flash[:notice] = "Uploaded photos successfully!"
#       redirect_to album_url(params[:album_id])
#     else
#       flash[:error] = @album.errors.full_messages
#       redirect_to album_url(params[:album_id])
#     end
#
#     # photo_params[:images].each do |image|
# #       photo = Photo.new(image: image, album_id: params[:album_id])
# #
# #       if photo.save
# #         num_pics += 1
# #       else
# #         flash[:error] = "One or more of your files failed to upload"
# #         redirect_to album_url(params[:album_id])
# #       end
# #     end
# #
# #     flash[:notice] = "Uploaded #{num_pics} photos successfully!"
# #     redirect_to album_url(params[:album_id])
#
#
#     #for single photo:
#     # @photo = Photo.new(photo_params.merge!(album_id: params[:album_id]))
# #
# #     if @photo.save
# #       flash[:notice] = "Photo uploaded!"
# #       redirect_to photo_url(@photo)
# #     else
# #       flash[:error] = @photo.errors.full_messages
# #       render :new
# #     end
#   end

  

  

  private
  def image_params
    params.require(:photo).permit(:image)
  end
  
  # for multiple
  # def image_params
#     p = params.require(:photo).permit(images:[])
#     p[:images].map do |file|
#       {image: file}
#     end
#   end

  def photo_params
    params.require(:photo).permit(:caption, :tag_list)
  end

end

module Base
  module Resources
    class PhotosController < Resources::BaseController
      before_action :set_photo, only: [:crop, :destroy]

      def create
        @photo = Photo.new(photo_params) do |photo|
          photo.uploader = current_user
        end
        @photo.save!
        @photo = @photo.decorate
      end

      def crop
        authorize @photo
        @photo.update(crop_photo_params)
        @preset = params[:preset].to_sym
      end

      def destroy
        authorize @photo
        @photo.destroy
        render nothing: true
      end

      private

      def set_photo
        @photo = Photo.find(params[:id]).decorate
      end

      def photo_params
        params.require(:photo).permit(:attachment)
      end

      def crop_photo_params
        params.require(:photo).permit(:crop_x, :crop_y, :crop_w, :crop_h)
      end
    end
  end
end

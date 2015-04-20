module Base
  class ProfilesController < Base::BaseController
    include LocationProcessing

    before_action :authorize_profile
    before_action :set_location_for_js, only: [:index, :show]

    def index
      @profile = @profile.decorate
    end

    def show
      @profile = Profile.find(params[:id])
    end

    def update
      create_location(@profile)
      @profile.update(profile_params)
      respond_with(@profile, location: base_profile_path)
    end

    def update_photo
      set_profile
      @profile.update(profile_photo_params)
      head :ok
    end

    private

    def authorize_profile
      authorize @profile
    end

    def profile_params
      params.require(:profile).permit(*policy(@profile).permitted_attributes)
    end

    def profile_photo_params
      params.require(:profile).permit(:photo_id, :wallpaper_id)
    end
  end
end

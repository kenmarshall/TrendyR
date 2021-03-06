module Base
  module Private
    class GigsController < Private::BaseController
      include LocationProcessing

      before_action :set_gig, only: [:edit, :update]
      before_action :authorize_gig, only: [:index, :new, :create, :destroy]

      def index
        @gigs = policy_scope(Gig).with_status(params[:filter]).page(params[:page])
      end

      def new
        @gig = Gig.new
        @gig_categories = Category.where(category_type: "gigs")
      end

      def create
        @gig = Gig.new(gig_params) do |gig|
          gig.owner_profile = @profile
          gig.location = find_or_create_location
        end
        @gig.save
        if session[:redirect_to_booking].present?
          redirect_to public_profile_bookings_path(session[:redirect_to_booking])
          session[:redirect_to_booking] = nil
        else
          respond_with @gig, location: private_gigs_path
        end
      end

      def edit
        @gig_categories = Category.where(category_type: "gigs")
      end

      def update
        @gig.attributes = gig_params
        @gig.location = find_or_create_location
        @gig.save
        respond_with @gig, location: private_gigs_path
      end

      def destroy
        @profile.delete_gigs(destroy_gigs_params)
        redirect_to action: :index
      end

      private

      def authorize_gig
        authorize Gig
      end

      def gig_params
        params.require(:gig).permit(policy(Gig).permitted_attributes)
      end

      def set_gig
        @gig = Gig.find(params[:id])
        authorize @gig
      end

      def destroy_gigs_params
        params.require(:gig_ids)
      end
    end
  end
end

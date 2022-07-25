class LeasesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # Added read action for testing purposes only
    # def index
    #     leases = Lease.all
    #     render json: leases
    # end

    def create
        lease = Lease.create!(params.permit(:rent, :apartment_id, :tenant_id))
        render json: lease
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private    
    def render_not_found_response
        render json: { message: "Lease not found" }, status: :not_found
    end
 
    def render_unprocessable_entity_response
        render json: { message: "Lease could not be created"}, status: :unprocessable_entity
    end
end

class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
    def index
        campers = Camper.all
        render json: campers, each_serializer: CamperSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    def show
        camper = find_camper
        render json: camper, serializer: CamperActivitySerializer
    end

    private

    def invalid_response(invalid)
        render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
    end

    def render_response_not_found
        render json: {"error": "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

    def find_camper
        Camper.find(params[:id])
    end

end

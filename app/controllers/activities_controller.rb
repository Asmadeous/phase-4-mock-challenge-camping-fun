class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
    def index
        activities = Activity.all
        render json: activities
    end

    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private

    def render_response_not_found
        render json: {"error": "Activity not found"}, status: :not_found
    end

    def find_activity
        Activity.find(params[:id])
    end
end

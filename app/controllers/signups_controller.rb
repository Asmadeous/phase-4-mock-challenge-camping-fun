class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
    def create
        signup = Signup.create!(signup_params)
        render json: signup_activity(signup), status: :created
    end

        private
        
        def signup_params
            params.permit(:time, :camper_id, :activity_id)
        end

        def invalid_response(invalid)
            render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
        end

        def signup_activity(signup)
            activity = signup.activity
            {
              id: activity.id,
              name: activity.name,
              difficulty: activity.difficulty
            }
          end
end

class ExerciseTypesController < AuthenticatedController
  before_action :set_exercise_type, only: %i[ show ]

  # GET /exercise_types
  def index
    @pagy, @exercise_types  = pagy ExerciseType.all
  end

  # GET /exercise_types/1
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_type
      @exercise_type = ExerciseType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_type_params
      params.expect(exercise_type: [ :name, :description, :enabled ])
    end
end

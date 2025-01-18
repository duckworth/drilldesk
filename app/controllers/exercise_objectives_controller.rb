class ExerciseObjectivesController < BaseTeamController
  before_action :set_exercise_objective, only: %i[ show ]

  # GET /exercise_objectives
  def index
    @pagy, @exercise_objectives  = pagy ExerciseObjective.all
  end

  # GET /exercise_objectives/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_objective
      @exercise_objective = ExerciseObjective.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_objective_params
      params.expect(exercise_objective: [ :name, :description, :enabled ])
    end
end

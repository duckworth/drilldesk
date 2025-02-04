class ExerciseObjectiveAssignmentsController < AuthenticatedController
  before_action :set_exercise_objective_assignment, only: %i[ show edit update destroy ]

  # GET /exercise_objective_assignments
  def index
    @pagy, @exercise_objective_assignments  = pagy ExerciseObjectiveAssignment.all
  end

  # GET /exercise_objective_assignments/1
  def show
  end

  # GET /exercise_objective_assignments/new
  def new
    @exercise_objective_assignment = ExerciseObjectiveAssignment.new
  end

  # GET /exercise_objective_assignments/1/edit
  def edit
  end

  # POST /exercise_objective_assignments
  def create
    @exercise_objective_assignment = ExerciseObjectiveAssignment.new(exercise_objective_assignment_params)

    if @exercise_objective_assignment.save
      redirect_to @exercise_objective_assignment, notice: "Exercise objective assignment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercise_objective_assignments/1
  def update
    if @exercise_objective_assignment.update(exercise_objective_assignment_params)
      redirect_to @exercise_objective_assignment, notice: "Exercise objective assignment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_objective_assignments/1
  def destroy
    @exercise_objective_assignment.destroy!
    redirect_to exercise_objective_assignments_path, notice: "Exercise objective assignment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_objective_assignment
      @exercise_objective_assignment = ExerciseObjectiveAssignment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_objective_assignment_params
      params.expect(exercise_objective_assignment: [ :exercise_id, :exercise_objective_id, :priority ])
    end
end

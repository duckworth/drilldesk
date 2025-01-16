class ExercisesController < BaseTeamController
  before_action :set_exercise, only: %i[ show edit update destroy ]

  # GET /exercises
  def index
    @pagy, @exercises  = pagy Exercise.all
  end

  # GET /exercises/1
  def show
  end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to @exercise, notice: "Exercise was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercises/1
  def update
    if @exercise.update(exercise_params)
      redirect_to @exercise, notice: "Exercise was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /exercises/1
  def destroy
    @exercise.destroy!
    redirect_to exercises_path, notice: "Exercise was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.expect(exercise: [ :team_id, :name, :purpose, :status, :exercise_type_id, :custom_scenario_id, :predefined_scenario_id, :exercise_date, :context_data ])
    end
end

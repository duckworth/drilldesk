class ExerciseArtifactsController < BaseTeamController
  before_action :set_exercise_artifact, only: %i[ show edit update destroy ]

  # GET /exercise_artifacts
  def index
    @pagy, @exercise_artifacts  = pagy ExerciseArtifact.all
  end

  # GET /exercise_artifacts/1
  def show
  end

  # GET /exercise_artifacts/new
  def new
    @exercise_artifact = ExerciseArtifact.new
  end

  # GET /exercise_artifacts/1/edit
  def edit
  end

  # POST /exercise_artifacts
  def create
    @exercise_artifact = ExerciseArtifact.new(exercise_artifact_params)

    if @exercise_artifact.save
      redirect_to @exercise_artifact, notice: "Exercise artifact was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercise_artifacts/1
  def update
    if @exercise_artifact.update(exercise_artifact_params)
      redirect_to @exercise_artifact, notice: "Exercise artifact was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_artifacts/1
  def destroy
    @exercise_artifact.destroy!
    redirect_to exercise_artifacts_path, notice: "Exercise artifact was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_artifact
      @exercise_artifact = ExerciseArtifact.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_artifact_params
      params.expect(exercise_artifact: [ :team_id, :exercise_id, :artifact_type, :file ])
    end
end

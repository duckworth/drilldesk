class ExerciseParticipantsController < BaseTeamController
  before_action :set_exercise_participant, only: %i[ show edit update destroy ]

  # GET /exercise_participants
  def index
    @pagy, @exercise_participants  = pagy ExerciseParticipant.all
  end

  # GET /exercise_participants/1
  def show
  end

  # GET /exercise_participants/new
  def new
    @exercise_participant = ExerciseParticipant.new
  end

  # GET /exercise_participants/1/edit
  def edit
  end

  # POST /exercise_participants
  def create
    @exercise_participant = ExerciseParticipant.new(exercise_participant_params)

    if @exercise_participant.save
      redirect_to @exercise_participant, notice: "Exercise participant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercise_participants/1
  def update
    if @exercise_participant.update(exercise_participant_params)
      redirect_to @exercise_participant, notice: "Exercise participant was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_participants/1
  def destroy
    @exercise_participant.destroy!
    redirect_to exercise_participants_path, notice: "Exercise participant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_participant
      @exercise_participant = ExerciseParticipant.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_participant_params
      params.expect(exercise_participant: [ :team_id, :exercise_id, :name, :user_id, :role ])
    end
end

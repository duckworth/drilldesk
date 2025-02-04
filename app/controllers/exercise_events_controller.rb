class ExerciseEventsController < BaseTeamController
  before_action :set_exercise_event, only: %i[ show edit update destroy ]

  # GET /exercise_events
  def index
    @pagy, @exercise_events  = pagy ExerciseEvent.all
  end

  # GET /exercise_events/1
  def show
  end

  # GET /exercise_events/new
  def new
    @exercise_event = ExerciseEvent.new
  end

  # GET /exercise_events/1/edit
  def edit
  end

  # POST /exercise_events
  def create
    event = if exercise_event_params[:custom_event_id].present?
              CustomEvent.find_by(id: exercise_event_params[:custom_event_id])
    else
              PredefinedEvent.find_by(id: exercise_event_params[:predefined_event_id])
    end

    @exercise_event = ExerciseEvent.new(exercise_event_params.merge(event: event).except(:custom_event_id, :predefined_event_id))

    if @exercise_event.save
      redirect_to @exercise_event, notice: "Exercise event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercise_events/1
  def update
    if @exercise_event.update(exercise_event_params.except(:custom_event_id, :predefined_event_id))
      redirect_to @exercise_event, notice: "Exercise event was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_events/1
  def destroy
    @exercise_event.destroy!
    redirect_to exercise_events_path, notice: "Exercise event was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_event
      @exercise_event = ExerciseEvent.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exercise_event_params
      params.expect(exercise_event: [ :exercise_id, :predefined_event_id, :custom_event_id, :triggered_at, :relative_event_time ])
    end
end

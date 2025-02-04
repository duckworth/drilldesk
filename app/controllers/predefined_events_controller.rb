class PredefinedEventsController < AuthenticatedController
  before_action :set_predefined_event, only: %i[ show edit update destroy ]

  # GET /predefined_events
  def index
    @pagy, @predefined_events  = pagy authorize PredefinedEvent.all
  end

  # GET /predefined_events/1
  def show
    authorize @predefined_event
  end

  # GET /predefined_events/new
  def new
    @predefined_event = PredefinedEvent.new
    authorize @predefined_event
  end

  # GET /predefined_events/1/edit
  def edit
    authorize @predefined_event
  end

  # POST /predefined_events
  def create
    @predefined_event = PredefinedEvent.new(predefined_event_params)
    authorize @predefined_event

    if @predefined_event.save
      redirect_to @predefined_event, notice: "Predefined event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /predefined_events/1
  def update
    authorize @predefined_event
    if @predefined_event.update(predefined_event_params)
      redirect_to @predefined_event, notice: "Predefined event was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /predefined_events/1
  def destroy
    authorize @predefined_event
    @predefined_event.destroy!
    redirect_to predefined_events_path, notice: "Predefined event was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_predefined_event
      @predefined_event = PredefinedEvent.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def predefined_event_params
      params.expect(predefined_event: [ :name, :description, :predefined_scenario_id, :trigger_conditions ])
    end
end

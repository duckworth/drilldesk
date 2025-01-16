class CustomEventsController < BaseTeamController
  before_action :set_custom_event, only: %i[ show edit update destroy ]

  # GET /custom_events
  def index
    @pagy, @custom_events  = pagy CustomEvent.all
  end

  # GET /custom_events/1
  def show
  end

  # GET /custom_events/new
  def new
    @custom_event = CustomEvent.new
  end

  # GET /custom_events/1/edit
  def edit
  end

  # POST /custom_events
  def create
    @custom_event = CustomEvent.new(custom_event_params)

    if @custom_event.save
      redirect_to @custom_event, notice: "Custom event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /custom_events/1
  def update
    if @custom_event.update(custom_event_params)
      redirect_to @custom_event, notice: "Custom event was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /custom_events/1
  def destroy
    @custom_event.destroy!
    redirect_to custom_events_path, notice: "Custom event was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_event
      @custom_event = CustomEvent.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def custom_event_params
      params.expect(custom_event: [ :name, :description, :custom_scenario_id, :name, :trigger_keywords, :sequence_order ])
    end
end

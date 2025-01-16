class PredefinedEventTransitionsController < AuthenticatedController
  before_action :set_predefined_event_transition, only: %i[ show edit update destroy ]

  # GET /predefined_event_transitions
  def index
    @pagy, @predefined_event_transitions  = pagy authorize PredefinedEventTransition.all
  end

  # GET /predefined_event_transitions/1
  def show
    authorize @predefined_event_transition
  end

  # GET /predefined_event_transitions/new
  def new
    @predefined_event_transition = PredefinedEventTransition.new
    authorize @predefined_event_transition
  end

  # GET /predefined_event_transitions/1/edit
  def edit
    authorize @predefined_event_transition
  end

  # POST /predefined_event_transitions
  def create
    @predefined_event_transition = PredefinedEventTransition.new(predefined_event_transition_params)
    authorize @predefined_event_transition

    if @predefined_event_transition.save
      redirect_to @predefined_event_transition, notice: "Predefined event transition was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /predefined_event_transitions/1
  def update
    authorize @predefined_event_transition

    if @predefined_event_transition.update(predefined_event_transition_params)
      redirect_to @predefined_event_transition, notice: "Predefined event transition was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /predefined_event_transitions/1
  def destroy
    authorize @predefined_event_transition

    @predefined_event_transition.destroy!
    redirect_to predefined_event_transitions_path, notice: "Predefined event transition was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_predefined_event_transition
      @predefined_event_transition = PredefinedEventTransition.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def predefined_event_transition_params
      params.expect(predefined_event_transition: [ :from_event_id, :to_event_id, :condition ])
    end
end

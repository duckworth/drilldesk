class PredefinedScenariosController < AuthenticatedController
  before_action :set_predefined_scenario, only: %i[ show edit update destroy ]

  # GET /predefined_scenarios
  def index
    @pagy, @predefined_scenarios = pagy authorize PredefinedScenario.enabled
  end

  # GET /predefined_scenarios/1
  def show
    authorize @predefined_scenario
  end

  # GET /predefined_scenarios/new
  def new
    @predefined_scenario = PredefinedScenario.new
    authorize @predefined_scenario
  end

  # GET /predefined_scenarios/1/edit
  def edit
    authorize @predefined_scenario
  end

  # POST /predefined_scenarios
  def create
    @predefined_scenario = PredefinedScenario.new(predefined_scenario_params)
    authorize @predefined_scenario

    if @predefined_scenario.save
      redirect_to @predefined_scenario, notice: "Predefined scenario was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /predefined_scenarios/1
  def update
    authorize @predefined_scenario
    if @predefined_scenario.update(predefined_scenario_params)
      redirect_to @predefined_scenario, notice: "Predefined scenario was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /predefined_scenarios/1
  def destroy
    authorize @predefined_scenario
    @predefined_scenario.destroy!
    redirect_to predefined_scenarios_path, notice: "Predefined scenario was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_predefined_scenario
    @predefined_scenario = PredefinedScenario.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def predefined_scenario_params
    params.expect(predefined_scenario: [ :name, :description, :exercise_type_id, :starting_scenario_event_id ])
  end
end

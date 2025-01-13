class CustomScenariosController < BaseTeamController
  before_action :set_custom_scenario, only: %i[ show edit update destroy ]

  # GET /custom_scenarios
  def index
    @pagy, @custom_scenarios = pagy CustomScenario.all
  end

  # GET /custom_scenarios/1
  def show
  end

  # GET /custom_scenarios/new
  def new
    @custom_scenario = CustomScenario.new
  end

  # GET /custom_scenarios/1/edit
  def edit
  end

  # POST /custom_scenarios
  def create
    @custom_scenario = CustomScenario.new(custom_scenario_params)

    if @custom_scenario.save
      redirect_to @custom_scenario, notice: "Custom scenario was successfully created."
    else
      puts @custom_scenario.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /custom_scenarios/1
  def update
    if @custom_scenario.update(custom_scenario_params)
      redirect_to @custom_scenario, notice: "Custom scenario was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /custom_scenarios/1
  def destroy
    @custom_scenario.destroy!
    redirect_to custom_scenarios_path, notice: "Custom scenario was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_custom_scenario
    @custom_scenario = CustomScenario.includes(:created_by, :exercise_type).find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def custom_scenario_params
    params.expect(custom_scenario: [ :name, :description, :exercise_type_id, :source_file, :source_text ])
  end
end

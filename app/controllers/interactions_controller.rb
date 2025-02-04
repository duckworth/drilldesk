class InteractionsController < AuthenticatedController
  before_action :set_interaction, only: %i[ show edit update destroy ]

  # GET /interactions
  def index
    @pagy, @interactions  = pagy Interaction.all
  end

  # GET /interactions/1
  def show
  end

  # GET /interactions/new
  def new
    @interaction = Interaction.new
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions
  def create
    @interaction = Interaction.new(interaction_params)

    if @interaction.save
      redirect_to @interaction, notice: "Interaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interactions/1
  def update
    if @interaction.update(interaction_params)
      redirect_to @interaction, notice: "Interaction was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /interactions/1
  def destroy
    @interaction.destroy!
    redirect_to interactions_path, notice: "Interaction was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.expect(interaction: [ :exercise_id, :exercise_event_id, :interaction_type, :user_id, :user_input, :ai_response, :response_confidence ])
    end
end

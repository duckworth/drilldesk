class AddStartingScenarioEventToPredefinedScenarios < ActiveRecord::Migration[8.0]
  def change
    add_reference :predefined_scenarios, :starting_scenario_event, null: true, type: :uuid
    add_foreign_key :predefined_scenarios, :predefined_events, column: :starting_scenario_event_id, deferrable: :deferred
  end
end

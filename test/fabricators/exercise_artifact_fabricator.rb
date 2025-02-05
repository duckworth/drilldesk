Fabricator(:exercise_artifact) do
  team { Current.team || Fabricate(:team) }
  exercise
  artifact_type { ExerciseArtifact.artifact_types.keys.sample }
  file { Rack::Test::UploadedFile.new(Rails.root.join("test", "fixtures", "files", "test.pdf"), "application/pdf") }
end

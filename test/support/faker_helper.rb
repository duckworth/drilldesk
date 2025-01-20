class FakerHelper
  def self.generate_event_name
    verb = Faker::Hacker.ingverb.capitalize
    adjectives = [ Faker::Hacker.adjective, Faker::Hacker.adjective ].uniq.join(" ") # Combine multiple adjectives
    noun = Faker::Hacker.noun
    abbreviation = Faker::Hacker.abbreviation
    postfix = [ "Detected", "Failed", "Disrupted Operations", "Triggered an Alert", "Resulted in Failure", "Caused a Breach", "Corrupted the System" ].sample

    # Randomly pick a structure/template for the name
    templates = [
      "#{verb} the #{adjectives} #{noun} #{postfix}",
      "#{verb} the #{noun} with #{adjectives} #{abbreviation} #{postfix}",
      "#{verb} the #{abbreviation} #{noun}, which #{postfix.downcase}",
      "#{verb} through the #{abbreviation} #{noun}, resulting in #{postfix.downcase}",
      "The #{adjectives.capitalize} #{abbreviation} #{noun} #{postfix.downcase}",
      "Detected #{verb.downcase} the #{adjectives} #{abbreviation} #{noun}"
    ]

    templates.sample # Pick a random format
  end

  # Generates a context-aware event name (additional diversity)
  def self.generate_contextual_event_name(context = nil)
    verb = Faker::Hacker.ingverb.capitalize
    adjectives = [ Faker::Hacker.adjective, Faker::Hacker.adjective ].uniq.join(" ")
    noun = Faker::Hacker.noun
    abbreviation = Faker::Hacker.abbreviation

    context = [ :security, :failure, :performance ].sample if context.nil?
    case context
    when :security
      "#{verb} the #{adjectives} #{abbreviation} #{noun} triggered a security breach"
    when :failure
      "#{verb} the #{adjectives} #{noun} caused a catastrophic system failure"
    when :performance
      "#{verb} the #{adjectives} #{abbreviation} #{noun} hindered performance metrics"
    else
      "#{verb} the #{adjectives} #{noun} resulted in unexpected behavior"
    end
  end
end

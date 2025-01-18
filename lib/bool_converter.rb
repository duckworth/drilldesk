module BoolConverter
  TRUE_VALUES = Set.new([
                          "true", "True", "TRUE", "1", 1, "t", "T", true,
                          "yes", "Yes", "YES", "y", "Y", "on", "On", "ON"
                        ]).freeze

  FALSE_VALUES = Set.new([
                           "false", "False", "FALSE", "0", 0, "f", "F", false,
                           "no", "No", "NO", "n", "N", "off", "Off", "OFF"
                         ]).freeze

  # Module-level method for direct calls
  def self.to_bool(value, default: :no_default)
    return true if TRUE_VALUES.include?(value.to_s.downcase)
    return false if FALSE_VALUES.include?(value.to_s.downcase)
    return false if value.nil? && default == :no_default
    return default unless default == :no_default

    value
  end

  # Instance-level method for objects including this module
  def to_bool(value, default: :no_default)
    BoolConverter.to_bool(value, default: default)
  end
end

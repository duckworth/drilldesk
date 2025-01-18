require_relative "bool_converter"
class Utils
  extend BoolConverter
  def self.env_bool(env_var, default = false)
    to_bool(ENV[env_var], default: default)
  end
end

class TailwindClassBuilder
  include ActionView::Helpers::TagHelper

  def button_classes(options)
    button_type = options.delete(:button_type) { :button }

    class_names(
      # general classes
      "mt-4 px-1 sm:px-3 py-sm sm:py-1 font-semibold bg-transparent border rounded",
      case button_type
      when :button then "enabled:cursor-pointer disabled:cursor-not-allowed"
      when :link then "no-link-style cursor-pointer whitespace-nowrap inline-block h-fit "
      end,
      # color classes
      case options.delete(:variant) { :commit }
      when :success, :commit, :notice
        ["text-success border-success", (button_type == :button) ?
                                          "enabled:hover:bg-success enabled:hover:text-success-background" :
                                          "hover:bg-success hover:text-success-background"]
      when :info
        ["text-info border-info", (button_type == :button) ?
                                    "enabled:hover:bg-info enabled:hover:text-info-background" :
                                    "hover:bg-info hover:text-info-background"]
      when :warn, :alert
        ["text-warn border-warn", (button_type == :button) ?
                                    "enabled:hover:bg-warn enabled:hover:text-warn-background" :
                                    "hover:bg-warn hover:text-warn-background"]
      when :danger, :error
        ["text-danger border-danger", (button_type == :button) ?
                                        "enabled:hover:bg-danger enabled:hover:text-danger-background" :
                                        "hover:bg-danger hover:text-danger-background"]
      when :plain
        ["text-secondary border-secondary", (button_type == :button) ?
                                              "enabled:hover:bg-text-secondary enabled:hover:text-inverted" :
                                              "hover:bg-text-secondary hover:text-inverted"]
      end
    )
  end
end
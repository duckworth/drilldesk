class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include TailwindFormClasses

  def  initialize(object_name, object, template, options)
    @tailwind_class_builder = TailwindClassBuilder.new
    default_classes = "space-y-4 md:space-y-6"

    # Merge default classes with any classes provided in options
    options[:html] ||= {}
    options[:html][:class] = [ default_classes, options[:html][:class] ].compact.join(" ")
    super(object_name, object, template, options)
  end

  # Same list of dynamically-generated field helpers as in Rails:
  #   actionview/lib/action_view/helpers/form_helper.rb
  [ :text_field,
   :password_field,
   :textarea,
   :color_field,
   :search_field,
   :telephone_field,
   :phone_field,
   :date_field,
   :time_field,
   :datetime_field,
   :datetime_local_field,
   :month_field,
   :week_field,
   :url_field,
   :email_field,
   :number_field,
   :range_field,
   :file_field ].each do |field_method|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{field_method}(method, options = {})
            if options.delete(:tailwindified)
              super
            else
              text_like_field(#{field_method.inspect}, method, options)
            end
          end
    RUBY_EVAL
  end

  def button(value = nil, options = {}, &block)
    super(value, { class: button_classes(options) }.merge(options))
  end

  def submit(value = nil, options = {})
    value, options = nil, value if value.is_a?(Hash)
    value ||= submit_default_value

    super(value, { class: button_classes(options) }.merge(options))
  end

  def button_classes(options)
    @tailwind_class_builder.button_classes(options)
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    custom_opts, opts = partition_custom_opts(options)

    field = super(method, {
      class: check_box_classes(method, custom_opts[:field_classes])
    }.merge(opts), checked_value, unchecked_value)

    label = tailwind_label(method, {
      class: "ml-3 text-sm block pt-xs font-medium text-gray-900 dark:text-white"
    }.merge(custom_opts[:label] || {}), opts)

    @template.content_tag("div", field + label, { class: custom_opts[:wrapper_classes] || "mt-2 flex items-center gap-x-1" })
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &)
    extra_html_options = {
      class: check_box_classes(method)
    }.merge(html_options)

    super(method, collection, value_method, text_method, options, extra_html_options, &)
  end

  def label(method, text = nil, options = {}, &)
    super(method, text, options.merge(class: class_names(
      (options[:class] || "block mb-2 text-sm font-medium text-gray-900 dark:text-white"),
      (options.delete(:extra_label_classes) if options.key?(:extra_label_classes))
    )), &)
  end

  def tailwind_label(method, label_options, field_options)
    custom_label_opts, label_opts = partition_custom_label_opts(label_options)
    return if custom_label_opts[:skip]

    label(method, custom_label_opts[:text], {
      class: custom_label_opts[:class],
      extra_label_classes: class_names(
        ("text-disabled" if field_options[:disabled]),
        ("hidden" if custom_label_opts[:hidden]),
        ("!inline-block !w-fit" if custom_label_opts[:inline]),
        (custom_label_opts[:extra_classes])
      )
    }.merge(label_opts))
  end

  def select_or_collection_select(method, *args, html_options, &block)
    custom_opts, html_opts = partition_custom_opts(html_options)

    label = tailwind_label(method, custom_opts[:label], html_options)

    select_classes = class_names(
      select_field_classes,
      { custom_opts[:field_classes] => custom_opts[:field_classes].present? },
      ("block w-full" unless custom_opts[:inline]),
      border_color_classes(method)
    )

    [ label, html_opts.merge(class: select_classes) ]
  end

  def select(method, choices = nil, options = {}, html_options = {}, &)
    label, html_opts = select_or_collection_select(method, choices, options, html_options, &)
    field = super(method, choices, options, html_opts, &)

    if label.present?
      label + field
    else
      field
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    label, html_opts = select_or_collection_select(method, collection, value_method, text_method, options, html_options)
    field = super(method, collection, value_method, text_method, options, html_opts)

    if label.present?
      label + field
    else
      field
    end
  end

  def combobox(method, options_or_src, **kwargs, &)
    custom_opts, html_opts = partition_custom_opts(kwargs)

    # Looking for CSS classes? They're overridden in app/assets/stylesheets/application.tailwind.css

    label = tailwind_label(method, custom_opts[:label], html_opts)
    field = super(method, options_or_src, **html_opts.merge(
      dialog_label: custom_opts.dig(:label, :text) || method.to_s.humanize,
      input: html_opts.without(:include_blank, :render_in),
      include_blank: (html_opts[:include_blank] == true) ? "None" : html_opts[:include_blank]
    ), &)

    if label.present?
      label + field
    else
      field
    end
  end

  private

  def text_like_field(field_method, object_method, options = {})
    custom_opts, opts = partition_custom_opts(options)

    label = tailwind_label(object_method, custom_opts[:label], options)

    field_classes = if field_method == :file_field
                      file_field_classes
    else
                      text_like_field_classes
    end

    field = send(field_method, object_method, {
      class: class_names(
        field_classes,
        { custom_opts[:field_classes] => custom_opts[:field_classes].present? },
        ("mt-1 block w-full" unless custom_opts[:inline]),
        border_color_classes(object_method)
      ),
      title: errors_for(object_method)&.join(" ")
    }.compact.merge(opts).merge({ tailwindified: true }))

    if label.present?
      label + field
    else
      field
    end
  end

  def border_color_classes(object_method)
    if errors_for(object_method).present?
      error_border_color_classes
    else
      success_border_color_classes
    end
  end

  CUSTOM_OPTS = [ :inline, :label, :field_classes, :wrapper_classes ].freeze

  def partition_custom_opts(opts)
    (opts || {}).partition { |k, v| CUSTOM_OPTS.include?(k) }.map(&:to_h)
  end

  CUSTOM_LABEL_OPTS = [ :text, :class, :inline, :extra_classes, :hidden, :skip ]

  def partition_custom_label_opts(opts)
    (opts || {}).partition { |k, v| CUSTOM_LABEL_OPTS.include?(k) }.map(&:to_h)
  end

  def errors_for(object_method)
    return if @object.blank?

    # The story here is that Rails adds association errors onto the
    # association by name, not "_id" So errors may be on :client but the form
    # field has to be :client_id
    if /_id$/.match?(object_method.to_s)
      @object.errors[object_method].presence || @object.errors[object_method.to_s.gsub(/_id$/, "").to_sym]
    else
      @object.errors[object_method]
    end
  end

  def check_box_classes(method, field_classes = nil)
    classes = <<~CLASSES.strip
      block rounded size-3.5 focus:ring focus:ring-success checked:bg-success checked:hover:bg-success/90 cursor-pointer focus:ring-opacity-50
    CLASSES
    "#{classes} #{field_classes} #{border_color_classes(method)}"
  end
end

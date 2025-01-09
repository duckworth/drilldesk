module ApplicationHelper
  include Pagy::Frontend
  def icon(icon_path, **options)
    render "shared/icons/#{icon_path}", **options
  end
  def icon_classes(size: 6, classes: "")
    "w-#{size} h-#{size} base-icon #{classes}"
  end

  def sidebar_icon_classes(active = false)
    icon_classes(classes: active ? "sidebar-icon-active" : "sidebar-icon")
  end
end

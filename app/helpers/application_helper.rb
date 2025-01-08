module ApplicationHelper
  def icon(icon_path, **options)
    render "shared/icons/#{icon_path}", **options
  end
  def icon_classes(size: 6, classes: "")
    "w-#{size} h-#{size} base_icon #{classes}"
  end

  def sidebar_icon_classes(active = false)
    icon_classes(classes: active ? "sidebar_icon_active" : "sidebar_icon")
  end
end

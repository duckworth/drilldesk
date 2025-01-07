module ApplicationHelper
  def icon_classes(size: 6, classes: "")
    "w-#{size} h-#{size} text-gray-500 dark:text-gray-400 #{classes}"
  end

  def nav_icon_classes
    icon_classes(classes: "transition duration-75 group-hover:text-gray-900 dark:group-hover:text-white")
  end
end

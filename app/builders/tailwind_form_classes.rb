# frozen_string_literal: true

module TailwindFormClasses
  def text_like_field_classes
    "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
  end

  def error_border_color_classes
    "border-red-500"
  end

  def success_border_color_classes
    "border-green-500"
  end
end

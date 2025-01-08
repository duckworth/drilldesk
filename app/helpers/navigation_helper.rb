# frozen_string_literal: true

module NavigationHelper
  MenuItem = Struct.new(:name, :path, :icon, :condition)

  def navigation_menu_items
    [
      MenuItem.new("Dashboard", root_path, "flowbite/objects_column_solid", -> { user_signed_in? }),
      MenuItem.new("Admin", admin_root_path, "material_symbols/admin_panel_settings", -> { user_signed_in? && current_user.sys_admin? })
    ]
  end

  def render_navigation_menu_item(menu_item)
    return unless menu_item.condition.call
    Rails.logger.debug "Rendering menu item: #{menu_item.inspect}"
    render partial: "layouts/components/sidebar_item", locals: { name: menu_item.name,
                                                                 path: menu_item.path,
                                                                 icon_path: menu_item.icon,
                                                                 active: current_page?(menu_item.path) }
  end

  def render_navigation_menu
    safe_join(navigation_menu_items.map { |menu_item| render_navigation_menu_item(menu_item) })
  end
end

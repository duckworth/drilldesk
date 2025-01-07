namespace :icon do
  require "net/http"
  require "json"

  desc "Fetch an iconify icon and save it as partial  bin/rails icon:fetch ICON=heroicons:light-bulb-20-solid"
  task fetch: :environment do
    icon_name = ENV["ICON"]

    if icon_name.nil? || icon_name.strip.empty?
      puts "ERROR: Please provide an icon name using the ICON environment variable (e.g., bin/rails icon:fetch ICON=heroicons:light-bulb-20-solid)"
      exit 1
    end

    set_name = icon_name.split(":").first
    icon_name = icon_name.split(":").last
    destination_dir = Rails.root.join("app", "views", "shared", "icons", set_name)
    destination_file = destination_dir.join("_#{icon_name.underscore}.html.erb")

    begin
      # Ensure the vendor/icons directory exists
      unless Dir.exist?(destination_dir)
        puts "Creating directory #{destination_dir}..."
        FileUtils.mkdir_p(destination_dir)
      end

      # https://api.iconify.design/heroicons.json?icons=arrow-turn-right-up
      uri = URI("https://api.iconify.design/#{set_name}.json?icons=#{URI.encode_www_form_component(icon_name)}")
      response = Net::HTTP.get_response(uri)

      unless response.is_a?(Net::HTTPSuccess)
        puts "ERROR: Failed to fetch json metadata for #{URI.decode_www_form_component(uri.to_s) }. Response code: #{response.code}"
        exit 1
      end

      icon_data = JSON.parse(response.body)

      icon = icon_data["icons"][icon_name]
      if icon.nil?
        puts "ERROR: Failed to extract icon #{icon_name} from #{URI.decode_www_form_component(uri.to_s) }. Response code: #{response.code}"
        exit 1
      end

      left = icon["left"] || icon_data["left"] || 0
      right = icon["right"] || icon_data["right"] || 0
      width = icon["width"] || icon_data["width"] || 16
      height = icon["height"] || icon_data["height"] || 16

      viewbox = "#{left} #{right} #{width} #{height}"
      # Build the SVG markup
      svg = <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" class="<%= classes %>" viewBox="<%= viewbox %>" fill="<%= fill %>"<% if attrs.present? %> <%= attrs %><% end %>>
          #{icon["body"]}
        </svg>
      SVG

      # Build the partial content
      partial = <<~ERB
        <%# locals: (classes: icon_classes, viewbox: '#{viewbox}', fill: 'currentColor', attrs: nil ) -%>
        #{svg}
      ERB

      # Save the partial
      File.write(destination_file, partial)
      puts "Icon '#{icon_name}' from #{set_name} saved to #{destination_file}"

    rescue StandardError => e
      puts "ERROR: An error occurred: #{e.message}"
      exit 1
    end
  end
end

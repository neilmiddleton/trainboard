module HomeHelper
  def line(lineId)
    color = case lineId
    when "circle"
      "#FFCE00"
    when "hammersmith-city"
      "#D799AF"
    when "metropolitan"
      "#751056"
    else
      "#FFFFFF"
    end

    "<div class='has-tooltip h-8 w-8' style='background-color: #{color}'>
      <span class='tooltip rounded shadow-lg text-xs p-1 bg-gray-100 b -mt-8'>#{lineId}</span>
    </div>".html_safe
  end

  def format_arrival(time)
    if time < 60
      "Arriving now"
    else
      "#{(time / 60.0).to_i} minutes"
    end
  end

  def format_station(station)
    station.gsub("Underground Station", "")
  end

  def get_platform(platform)
    platform.scan(/\d/).join
  end

  def get_direction(platform)
    platform.split("-").first
  end
end

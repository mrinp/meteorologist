require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/7fc007d5dede10e35e2754a7e49888b0/"+@lat+","@lng
    raw_data = open(url).read

    @current_temperature = parsed_data["currently"][0]["temperature"]

    @current_summary = parsed_data["currently"][0]["Summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"][0]["Summary"]

    @summary_of_next_several_hours = parsed_data["hourly"][0]["Summary"]

    @summary_of_next_several_days = parsed_data["daily"][0]["Summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end

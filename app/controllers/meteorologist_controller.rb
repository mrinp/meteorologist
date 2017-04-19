require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.gsub(" ","+")+"&sensor=false"
    raw_data = open(url).read
    results = parsed_data["results"]

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    url2 = "https://api.darksky.net/forecast/7fc007d5dede10e35e2754a7e49888b0/"+@latitude+","@longitude
    raw_data = open(url2).read


    @current_temperature = parsed_data["currently"][0]["temperature"]

    @current_summary = parsed_data["currently"][0]["Summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"][0]["Summary"]

    @summary_of_next_several_hours = parsed_data["hourly"][0]["Summary"]

    @summary_of_next_several_days = parsed_data["daily"][0]["Summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end

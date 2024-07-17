class HomeController < ApplicationController
  def index
    @arrivals = JSON.parse(Redis.get("arrivals") || "{}")
  end
end

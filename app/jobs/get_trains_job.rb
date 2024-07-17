class GetTrainsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    arrivals = TflClient.new.arrivals(naptanId: Rails.configuration.naptanId, mode: "tube")
    Redis.set("arrivals", arrivals.to_json)
  end
end

require "rails_helper"
require "tfl_client"

RSpec.describe TflClient do
  describe "#arrivals" do
    it "returns an array of arrivals" do
      VCR.use_cassette("arrivals") do
        arrivals = TflClient.new.arrivals(naptanId: "940GZZLUGPS", mode: "tube")
        expect(arrivals.length).to eq(23)
      end
    end

    it "returns an arrivals object" do
      VCR.use_cassette("arrivals") do
        arrivals = TflClient.new.arrivals(naptanId: "940GZZLUGPS", mode: "tube")
        expect(arrivals.first).to be_a(Hash)
        expect(arrivals.first["lineId"]).to eq("circle")
        expect(arrivals.first["destinationName"]).to eq("Edgware Road (Circle Line) Underground Station")
        expect(arrivals.first["towards"]).to eq("Edgware Road (Circle)")
        expect(arrivals.first["timeToStation"]).to eq(672)
        expect(arrivals.first["platformName"]).to eq("Eastbound - Platform 2")
      end
    end
  end
end

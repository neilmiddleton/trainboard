require "net/http"
require "json"

class TflClient
  attr_reader :host, :port

  def initialize(host = "api.tfl.gov.uk", port = 443)
    @host = host
    @port = port
  end

  def self.def_request(name, method, path)
    define_method(name) do |params, body = nil, headers = nil|
      request(method, path, params, body, headers)
    end
  end
  private_class_method :def_request

  def_request :arrivals, :get, "/StopPoint/{naptanId}/Arrivals"

  def request(method, path, params, body = nil, headers = nil)
    path = format_path(path, params)
    Net::HTTP.start(host, port, use_ssl: true) do |http|
      req = Net::HTTP.const_get(method.capitalize).new(path, headers)
      req.body = body if req.request_body_permitted?
      res = http.request(req)
      JSON.parse(res.body)
    end
  end

  private

  def format_path(path, params)
    path = path.dup
    params.reject! do |key, value|
      value = value.join(",") if value.respond_to?(:join)
      path.sub!("{#{key}}", value.to_s)
    end
    path << "?" << params.map { |kv| kv.join("=") }.join("&")
  end
end

# frozen_string_literal: true

%w[ipgeobase/version ipgeobase/query ipgeobase/status].each { |file| require_relative file }
%w[uri net/http].each { |file| require file }

module Ipgeobase
  class Error < StandardError; end

  class << self
    def lookup(ip)
      uri = URI("http://ip-api.com/xml/#{ip}")

      response = Net::HTTP.get_response(uri)

      check_fail(response)
      Query.parse(response.body, single: true)
    end

    private

    def check_fail(response)
      data = Status.parse(response.body, single: true)
      raise data.message if data.status == "fail"
    end
  end
end

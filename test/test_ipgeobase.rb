# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def setup
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8").to_return(body: File.read("test/support/succes.xml"))
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8.8").to_return(body: File.read("test/support/fail.xml"))

    @correct_ip     = "8.8.8.8"
    @incorrect_ip   = "8.8.8.8.8"
    @sample_object  = {
      country: "United States",
      countryCode: "US",
      city: "Ashburn",
      lat: 39.03,
      lon: -77.5
    }
  end

  def test_correct_case
    actual = Ipgeobase.lookup(@correct_ip)

    assert_equal @sample_object[:country], actual.country
    assert_equal @sample_object[:countryCode], actual.countryCode
    assert_equal @sample_object[:city], actual.city
    assert_equal @sample_object[:lat], actual.lat
    assert_equal @sample_object[:lon], actual.lon
  end

  def test_incorrect_case
    assert_raises RuntimeError do
      Ipgeobase.lookup(@incorrect_ip)
    end
  end
end

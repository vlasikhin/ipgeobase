# frozen_string_literal: true

require "happymapper"

class Status
  include HappyMapper

  tag "query"
  element :status, String
  element :message, String
end

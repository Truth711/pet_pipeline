# frozen_string_literal: true

require_relative "restaurantsdbread"
require_relative "restaurantsdbupdate"

def getvotes
  outback = restaurantsdbread("outback")
  ihop = restaurantsdbread("ihop")
  bucadibeppo = restaurantsdbread("bucadibeppo")
  chipotle = restaurantsdbread("chipotle")

  votes = [
    { name: "outback", value: outback },
    { name: "bucadibeppo", value: bucadibeppo },
    { name: "ihop", value: ihop },
    { name: "chipotle", value: chipotle }
  ].to_json

  return votes
end

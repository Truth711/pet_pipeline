# frozen_string_literal: true

require "socket"

def hostname
  hostnamedata = Socket.gethostname
  return hostnamedata
end

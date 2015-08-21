module ClinkCloud
  module Errors
    class ClinkCloudError < StandardError; end
    class AuthenticationError < ClinkCloudError; end
  end
end

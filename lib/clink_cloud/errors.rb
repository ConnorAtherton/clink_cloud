module ClinkCloud
  module Errors
    class ClinkCloudError < StandardError; end
    class AuthenticationError < ClinkCloudError; end
    class ResourceNotFoundError < ClinkCloudError; end
  end
end

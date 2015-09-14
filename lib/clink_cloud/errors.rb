module ClinkCloud
  module Errors
    class ClinkCloudError < StandardError; end
    class AuthenticationError < ClinkCloudError; end
    class ResourceNotFoundError < ClinkCloudError; end
    class InternalError < ClinkCloudError; end
    class InvalidRequestError < ClinkCloudError; end
  end
end

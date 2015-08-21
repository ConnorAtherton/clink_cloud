require 'virtus'

module ClinkCloud
  class Base
    include Virtus.model

    # Shared by all json responses
    # NOTE: disabling for now
    attribute :links
  end
end

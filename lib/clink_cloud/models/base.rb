require 'virtus'

module ClinkCloud
  class Base
    include Virtus.model

    # Shared by all json responses
    attribute :links
  end
end

module ClinkCloud
  class OperationMapping
    include Kartograph::DSL

    kartograph do
      mapping Operation

      property :id, scopes: [:read]
      property :isQueued, scopes: [:read]
      property :links, scopes: [:read]
      property :errorMessage, scopes: [:read]
    end
  end
end

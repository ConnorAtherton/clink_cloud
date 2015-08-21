module ClinkCloud
  class DataCenterMapping
    include Kartograph::DSL

    kartograph do
      mapping DataCenter

      property :id, scopes: [:read]
      property :name, scopes: [:read]
      property :links, scopes: [:read]
    end
  end
end

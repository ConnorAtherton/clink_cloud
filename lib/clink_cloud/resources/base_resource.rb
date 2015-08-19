module ClinkCloud
  class BaseResource < ResourceKit::Resource
    # helpful for century link api because the include
    # account alias in the url itself
    def account_alias
     scope.alias
    end
  end
end

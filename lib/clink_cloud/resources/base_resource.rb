require 'resource_kit'

module ClinkCloud
  class BaseResource < ResourceKit::Resource
    # helpful for century link api because the include
    # account alias in the url itself
    def account_alias
      scope.alias
    end

    def extract_resources_from_links(links, obj, *keys)
      links.each do |link|
        next unless keys.include? link['rel']
        obj.send "#{link['re']}=", link['id']
      end

      obj
    end
  end
end

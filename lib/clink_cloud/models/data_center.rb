module ClinkCloud
  class DataCenter < Base
    attribute :id
    attribute :name

    def group_id
      @group_id ||= links.select { |l| true if l['rel'] == 'group' }.first['id']
    rescue
      # This happends when accessing group_id on an object
      # sculpted from within a collection. Need to use .find to
      # get more links
      nil
    end
  end
end

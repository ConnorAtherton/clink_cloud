module ClinkCloud
  class Operation < Base
    attribute :server
    attribute :isQueued
    attribute :errorMessage
    attribute :links

    def id
      @id ||= links.select { |l| l if l['rel'] == 'status' }
              .map { |s| s['id'] }
              .first
    end
  end
end

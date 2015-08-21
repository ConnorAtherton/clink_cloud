require 'faraday'
require 'faraday_middleware'
require 'pry'

module ClinkCloud
  class Client
    API_VERSION = 'v2'
    API_URL = 'https://api.ctl.io'

    attr_reader :auth_token, :alias, :roles, :primary_location

    def initialize(options)
      @username = options[:username]
      @password = options[:password]

      authenticate unless auth_token
    end

    def connection
      Faraday.new(connection_options) do |faraday|
        # json encode both requests and responses
        faraday.response :json, content_type: 'application/json'
        faraday.request :json
        faraday.adapter :net_http
      end
    end

    # This is used to lazy-load resources.
    # It is stored in the @resources instance
    # variable when a caller requests the resource.
    def self.resources
      {
        servers: ServerResource,
        data_centers: DataCenterResource,
        firewall_policies: FirewallPolicyResource,
        networks: NetworkResource,
        operations: OperationResource,
        statuses: StatusResource,
        groups: GroupResource,
        ip_addresses: IpAddressResource
      }
    end

    def resources
      @resources ||= {}
    end

    # This attaches resources to the client
    # Resources map to a specific model
    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        unless auth_token
          raise 'Authenticate before using these methods'
        end

        resources[name] ||= self.class.resources[name].new(connection: connection,
                                                          scope: self)
        resources[name]
      else
        super
      end
    end

    def authenticate
      res = connection.post(
        "/#{API_VERSION}/authentication/login", username: @username, password: @password
      )

      return unless res.success?

      # also set the alias for later on
      @auth_token = res.body['bearerToken']
      @alias = res.body['accountAlias']
      @roles = res.body['roles']
      @primary_location = res.body['locationAlias']
    end

    private

    def connection_options
      conn = {
        url: API_URL,
        headers: {
          content_type: 'application/json',
          accepts: 'application/json'
        }
      }

      conn[:headers][:authorization] = "Bearer #{auth_token}" if auth_token

      conn
    end
  end
end

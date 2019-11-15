module TeamsIncomingClients
  module Modules
    module ClientConfigure
      VALID_CONFIG_KEYS = {
        today_date: Date.today,
      }

      attr_accessor *VALID_CONFIG_KEYS.keys

      def configure
        yield self
      end
    end
  end
end

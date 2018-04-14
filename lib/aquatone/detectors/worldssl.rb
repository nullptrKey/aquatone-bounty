module Aquatone
  module Detectors
    class Worldssl < Aquatone::Detector
      self.meta = {
        :service         => "WorldSSL",
        :service_website => "https://cdnsun.com/",
        :author          => "Jarmo Puttonen (@putsi)",
        :description     => "Content delivery network"
      }

      CNAME_VALUE          = ".r.worldssl.net".freeze

      def run
        return false unless cname_resource?
        if resource_value.end_with?(CNAME_VALUE)
          begin
            get_request("http://#{host}/")
          rescue SocketError
            return true
          end
        end
        false
      end
    end
  end
end

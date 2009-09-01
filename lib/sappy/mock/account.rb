module Sappy
  module Mock
    class Account
      def initialize(username, password)
        @username, @password = username, password
        @available_monitors = 33
        @setup_monitors = 0
        @sms_alerts = 0
        @monitors = []
      end
      
      attr_reader :setup_monitors, :sms_alerts
      
      def authkey
        "b7kks5mh1l300v5segaksm8gh3"
      end

      def refresh!
        # noop
      end

      ## monitors
      def available_monitors
        @available_monitors - @monitors.size
      end

      def monitors(ids = [])
        if ids.empty?
          @monitors
        else
          @monitors.select{|m| ids.include?(m.id) }
        end
      end

      def add_monitor(attrs)
        m = Monitor.new(self, attrs)
        @monitors << m
        m
      end

      def remove_monitor(id)
        @monitors.delete_if { |m| m.id == id }
      end
    end
  end
end

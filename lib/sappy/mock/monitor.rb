module Sappy
  module Mock
    class Monitor
      ATTRIBUTES = %w[name service location host period].map{|a| a.to_sym }
      ATTRIBUTES.each do |attr|
        attr_reader attr
      end

      def initialize(account, attrs)
        @account = account
        ATTRIBUTES.each do |attr|
          instance_variable_set :"@#{attr}", attrs[attr]
        end
        @active = false
        check_hostname(@host)
      end

      def id
        object_id
      end

      def enable!
        @active = true
      end

      def disable!
        @active = false
      end

      def active?
        @active
      end

      def destroy
        @account.remove_monitor(self.id)
      end

      private
      def check_hostname(str)
        raise ArgumentError.new("Invalid Hostname") unless valid_hostname?(str)
      end

      def valid_hostname?(str)
        # we believe the hostname rules are:
        # is a URI
        # has two parts ( a dot in there somewhere )
        # TLD is at least 2 characters long

        begin
          ::URI.parse(str)
        rescue ::URI::InvalidURIError => e
          return false
        end

        if str !~ /\w\w$/
          false
        elsif str !~ /\w\.\w/
          false
        else
          true
        end
      end
    end
  end
end

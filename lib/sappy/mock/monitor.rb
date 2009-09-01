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
    end
  end
end

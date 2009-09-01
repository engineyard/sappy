require File.dirname(__FILE__) + '/../spec_helper'

module Sappy
  describe Account do
    describe "with incorrect credentials" do
      it "raises an error" do
        lambda { Account.login("invalid@email.com", "password") }.
          should raise_error(Responses::Auth::LoginFailed)
      end
    end

    describe "with correct credentials" do
      before(:all) do
        @account = Account.login(USERNAME, PASSWORD)
      end
      
      before(:each) do
        @account.monitors.each do |m|
          m.destroy
        end
      end

      it "should obtain an auth key" do
        @account.authkey.should be_kind_of(String)
        @account.authkey.should =~ /^\w+$/
      end

      describe "with no monitors" do
        it "has available monitors" do
          @account.available_monitors.should > 0
        end

        it "has no monitors" do
          @account.setup_monitors.should == 0
        end

        it "has no SMS alerts" do
          @account.sms_alerts.should == 0
        end

        it "can create a new monitor" do
          available_monitors = @account.available_monitors
          monitor = @account.add_monitor({:name => "New Monitor", :service => "http", :location => "sf", :host => "engineyard.com", :period => "60"})
          monitor.id.should be_kind_of(Integer)
          @account.refresh!          
          @account.available_monitors.should == available_monitors - 1
          monitors = @account.monitors
          monitors.size.should == 1
          monitors.first.name.should == "New Monitor"
        end

        it "doesn't create invalid monitors" do
          ['e', 'a.b', 'engineyard.c', 'oneword'].each do |hostname|
            lambda do
              @account.add_monitor({
                :host => hostname,
                :name => "Busted Monitor",
                :service => "http",
                :location => "sf",
                :period => "60"
              })
            end.should raise_error(ArgumentError)
          end
        end

        it "lists its monitors" do
          monitor_defaults = {:service => "http", :location => "sf", :period => "60"}
          m1 = @account.add_monitor(monitor_defaults.merge(:name => 'Monitor 1', :host => 'm1.engineyard.com'))
          m2 = @account.add_monitor(monitor_defaults.merge(:name => 'Monitor 2', :host => 'm2.engineyard.com'))

          @account.monitors.size.should == 2

          just_m1 = @account.monitors([m1.id])
          just_m1.size.should == 1
          just_m1.first.id.should == m1.id
        end
      end
    end
  end
end

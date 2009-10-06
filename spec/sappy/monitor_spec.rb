require File.dirname(__FILE__) + '/../spec_helper'

module Sappy
  describe Monitor do
    before do
      @monitor = @account.add_monitor(:name => "New Monitor", :service => "http", :location => "sf", :host => "engineyard.com", :period => "60")
    end

    describe "an active monitor" do
      before do
        @monitor.enable!
      end

      it "can be disabled" do
        @monitor.disable!
        @monitor.should_not be_active
      end
    end

    describe "an inactive monitor" do
      before do
        @monitor.disable!
      end

      it "can be enabled" do
        @monitor.enable!
        @monitor.should be_active
      end
    end

    describe "a monitor" do
      it "can be destroyed" do
        @account.monitors.size.should == 1
        lambda { @monitor.destroy }.should_not raise_error
        @account.monitors.size.should == 0
      end
    end

    it "has a 32-bit unsigned id" do
      # This stub is just for testing the mock, as it bases its #id on
      # #object_id, and in 64-bit mode, that can potentially be bigger
      # than 32 bits. But, rather than force it to have an ID that
      # big, we'll just stub it out with one that's big enough. This
      # shouldn't affect the non-mocked behavior at all.
      @monitor.stub!(:object_id).and_return(2**33)
      @monitor.id.should be_between(0, 2**32 - 1)
    end
  end
end

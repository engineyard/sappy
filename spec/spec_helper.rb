require 'rubygems'
require 'spec'
require 'cgi'

begin
  require File.dirname(__FILE__) + '/credentials.rb'
rescue LoadError
  raise "add a spec/credentials.rb that defines USERNAME and PASSWORD constants"
end
require File.dirname(__FILE__) + '/../lib/sappy'

SPEC_DIR = File.dirname(__FILE__) unless defined? SPEC_DIR
$:<< SPEC_DIR

def cached_page(name)
  SPEC_DIR + "/xml/#{name}.xml"
end

at_exit do
  Sappy::Account.login(USERNAME, PASSWORD).monitors.each do |m|
    m.destroy
  end
end

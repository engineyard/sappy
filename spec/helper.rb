require 'rubygems'
require 'bacon'
require 'fakeweb'
require 'pp'
require 'cgi'

require File.dirname(__FILE__) + '/../lib/sappy'
begin
  require File.dirname(__FILE__) + '/credentials.rb'
rescue LoadError
  raise "add a spec/credentials.rb that defines USERNAME and PASSWORD constants"
end

SPEC_DIR = File.dirname(__FILE__) unless defined? SPEC_DIR
$:<< SPEC_DIR

def cached_page(name)
  SPEC_DIR + "/xml/#{name}.xml"
end

if Sappy.mocked
  # Don't allow real web requests
  FakeWeb.allow_net_connect = false

  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?method=siteuptime.auth&Password=#{PASSWORD}&Email=#{CGI.escape USERNAME}", :response => cached_page('valid_account'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?method=siteuptime.auth&Password=password&Email=invalid%40email.com", :response => cached_page('invalid_account'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.accountinfo", :response => cached_page('accountinfo'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.summarystatistics", :response => cached_page('summarystatistics'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?Name=New+Monitor&AuthKey=b7kks5mh1l300v5segaksm8gh3&Enabled=&HostName=engineyard.com&Login=&AltEmailAlerts=&Content=&Location=sf&EnablePublicStatistics=&Domain=&method=siteuptime.addmonitor&Timeout=&Password=&UpSubject=&AddToStatusPage=&SendAllDownAlerts=&IP=&SendAlertAfter=&DontSendUpAlert=&SendJabberAlert=&CheckPeriod=60&DownSubject=&SendUrlAlert=&SendSms=&PortNumber=&Service=http", :response => cached_page('addmonitor'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.enablemonitor&MonitorId=84043", :response => cached_page('enablemonitor'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.disablemonitor&MonitorId=84043", :response => cached_page('disablemonitor'))
  FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.removemonitor&MonitorId=84043", :response => cached_page('removemonitor'))
end

# TODO: Do in mock mode too
at_exit do
  Sappy::Account.login(USERNAME, PASSWORD).monitors.each do |m|
    m.destroy
  end
end unless Sappy.mocked

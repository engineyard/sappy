require 'rubygems'
require 'xmlsimple'

require File.dirname(__FILE__) + '/core_ext'

$:.unshift File.dirname(__FILE__)

module Sappy
  class Error < StandardError; end

  class << self
    attr_accessor :mocked
  end
  self.mocked = !!ENV['MOCK_SAPPY']
end

require 'sappy/account'
require 'sappy/monitor'
require 'sappy/request'
require 'sappy/response'
require 'sappy/responses'

if Sappy.mocked
  require 'sappy/mock/account'
  require 'sappy/mock/monitor'
end

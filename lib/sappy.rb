require 'rubygems'
require 'xmlsimple'

require File.dirname(__FILE__) + '/core_ext'

$:.unshift File.dirname(__FILE__)

module Sappy
  class Error < StandardError; end

  @@mocked = false
  def self.mocked?
    @@mocked
  end
  
  def self.mock!
    require 'sappy/mock/account'
    require 'sappy/mock/monitor'
    Sappy::Account.mock!
    @@mocked = true
  end
end

require 'sappy/account'
require 'sappy/monitor'
require 'sappy/request'
require 'sappy/response'
require 'sappy/responses'

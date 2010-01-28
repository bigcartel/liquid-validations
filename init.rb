$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'liquid_validations'
ActiveRecord::Base.extend(LiquidValidations)
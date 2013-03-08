require 'spec_helper'

class Mixin < ActiveRecord::Base
  validates_liquid_of :liquid_text, :liquid_string
end

describe LiquidValidations do
  it 'should provide the validates_liquid_of method to ActiveRecord subclasses' do
    Mixin.must_respond_to(:validates_liquid_of)
  end

  it 'should provide the validates_presence_of_liquid_variable method to ActiveRecord subclasses' do
    Mixin.must_respond_to(:validates_presence_of_liquid_variable)
  end

  describe '.validates_liquid_of' do
    before do
      @mixin = Mixin.new
    end

    [ ' {{ Bad liquid ',
      ' {% Bad liquid ',
      '{% for %}{% endfor' ].each do |bad_liquid|
      it "the record should be invalid when there is a liquid parsing error for #{ bad_liquid }" do
        @mixin.liquid_text, @mixin.liquid_string = bad_liquid
        @mixin.valid?.must_equal false
      end
    end

    it 'should include the errors in the errors object' do
      @mixin.liquid_text = '{{ unclosed variable '
      @mixin.valid?
      @mixin.errors.must_include(:liquid_text)
    end
  end

  describe '.validates_presence_of_liquid_variable' do
  end
end

require 'spec_helper'

class Mixin < ActiveRecord::Base
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
      Mixin.instance_eval do
        validates_liquid_of :content
      end

      @mixin = Mixin.new
    end

    [ ' {{ Bad liquid ',
      ' {% Bad liquid ',
      '{% for %}{% endfor' ].each do |bad_liquid|
      it "the record should be invalid when there is a liquid parsing error for #{ bad_liquid }" do
        @mixin.content = bad_liquid
        @mixin.valid?.must_equal false
      end
    end

    it 'should include the errors in the errors object' do
      @mixin.content = '{{ unclosed variable '
      @mixin.valid?
      @mixin.errors.must_include(:content)
    end
  end

  describe '.validates_presence_of_liquid_variable' do
    before do
      Mixin.instance_eval do
        validates_presence_of_liquid_variable :content, variable: 'josh_is_awesome'
      end

      @mixin = Mixin.new
    end

    it 'must be configured properly' do
      proc { Mixin.instance_eval { validates_presence_of_liquid_variable :content } }.must_raise ArgumentError
    end

    it 'the record should be invalid when the specified variable is not present' do
      @mixin.content = '{{ josh_is_not_awesome }}'
      @mixin.valid?.must_equal false
    end

    it 'should include the errors in the errors object' do
      @mixin.content = '{{ josh_is_not_awesome }}'
      @mixin.valid?
      @mixin.errors.must_include(:content)
    end
  end
end

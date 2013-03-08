$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'active_record'
require 'liquid'
require 'liquid_validations'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', dbfile: ':memory:', database: 'liquid_validations_test.db')

ActiveRecord::Migration.verbose = false

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :mixins do |t|
      t.column :liquid_string, :string
      t.column :liquid_text, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class MiniTest::Spec
  before do
    setup_db
  end

  after do
    teardown_db
  end
end


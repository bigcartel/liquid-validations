Liquid Validations [![Build Status](https://travis-ci.org/bigcartel/liquid-validation.png)](https://travis-ci.org/bigcartel/liquid-validation)
=================

ActiveRecord style validations for Liquid content in your ActiveRecord models.

This gem makes 2 class methods available to your models:
  * `validates_liquid_of` - Ensures that the liquid content is valid and has all opening/closing tags.
  * `validates_presence_of_liquid_variable` - Useful to ensure your user content contains the specified Liquid variable(s).

Installation
--------

`gem 'liquid-validations'` in your Gemfile.

Then `bundle install` and you should be all set.


Usage
--------

In it's simplest form:

``` ruby
class Article < ActiveRecord::Base
  validates_liquid_of :content
  validates_presence_of_liquid_variable :content, variable: 'very_important_variable'
end
```

`validates_presence_of_liquid_variable` takes an optional `container` option like this:

``` ruby
validates_presence_of_liquid_variable :content, 
                                      variable: 'head_content', 
                                      container: 'head' # <html><head>{{ head_content }}</head>...
```

Which you may find useful for scoping. Or not.



Each of these methods make use of ActiveModel's underlying [`validates_each`](http://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_each) method so any valid options passed in will be handed off.

A fully tricked out example would be:

``` ruby
validates_liquid_of :content, :on => :create, 
                              :message => 'is invalid liquid.', 
                              :allow_nil => true, 
                              :allow_blank => true, 
                              :if => :needs_validation?,
                              :unless => Proc.new { |record| record.new_record? }
```

Albeit, that's going a little overboard.


Compatibility
--------

Liquid Validations has been tested (used) with the following:

Rails
 * 2.3 and up
 * 3

Ruby
 * 1.8
 * 1.9
 * 2.0

That's not to say it won't work with Rails 1.2 or 4, but we haven't yet tested either of those.

What about Sinatra
--------

This *should* work outside of Rails as long as your models are using ActiveRecord as the database mapper. However, this is just in theory, and hasn't been tested yet.


Contributing
--------

If you do find that something is busted, or think improvements can be made

 * Fork it
 * Create a topic branch - `git checkout -b fix_rails_1-0`
 * Push to your branch - `git push origin fix_rails_1-0`
 * Create a Pull Request from your branch

That's it!

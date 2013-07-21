# Chef Helpers

This gem includes miscellaneous add-on helper methods for Opscode Chef.

## Installation

To use helper methods in your Chef recipes, add `chef_gem
'chef-helpers'` and `require 'chef-helpers'` in your recipes.

To use methods locally in `knife exec` scripts or Knife plugins, add
this line to your application's Gemfile:

    gem 'chef-helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chef-helpers

## Usage

Detailed documentation of the helper methods can be seen at
http://rdoc.info/github/3ofcoins/chef-helpers/

### JSONPath access to attributes

The `Chef::Node` class is monkey-patched to allow easy deep access to
the attributes using the
[JSONPath](http://goessner.net/articles/JsonPath/) syntax:

```
chef > require 'chef-helpers'
 => true 
chef > node['$..name']
 => ["portinari-2.local", "Java(TM) SE Runtime Environment", "Java HotSpot(TM) 64-Bit Server VM", "Darwin"] 
chef > node['$.kernel.name']
 => ["Darwin"] 
```

Regular access to attributes is preserved; JSONPath is used only when
the attribute name starts with `$` character, or if a `JSONPath`
instance is used for indexing.

The [jsonpath gem](https://github.com/joshbuddy/jsonpath) is used for
the implementation. While the original gem allows modification, it's
not straightforward to achieve with Chef's attributes, so only reading
attributes with JSONPath is supported.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

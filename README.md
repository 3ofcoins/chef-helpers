# Chef Helpers

This gem includes miscellaneous add-on helper methods for Opscode Chef.

## Installation

To use helper methods in your Chef recipes, use following code in your
recipe:

```ruby
chef_gem 'chef-helpers'
require 'chef-helpers'
```

To use the helpers locally in `knife exec` scripts or Knife plugins,
just add the `chef-helpers` gem to your dependencies and `require 'chef-helpers'`.

## Usage

Detailed documentation of the helper methods can be seen at
http://rdoc.info/github/3ofcoins/chef-helpers/

### Finding existing templates and cookbook files

The recipe DSL is extended with `ChefHelpers::HasSource` module that
provides methods for checking which templates and cookbook files exist
on the Chef server. Detailed docs are available at
http://rdoc.info/github/3ofcoins/chef-helpers/ChefHelpers/HasSource

### Chef::Node#allies

The `node.allies` method returns an array of node's *allies*.  These
are: all nodes in the same environment (if the environment is not
`_default`), plus nodes specified by `allies` attribute. The `allies`
attribute - if set - should be an array of node names or node search
queries; the named nodes and search results will be added to node's
allies.

This is mostly useful when defining firewall or other access rules, to
easily limit access to insides of a cluster plus a handful of friendly
machines.

### Chef::Node#ip_for

The `node.ip_for(other_node)` method decides, which IP address should
the node use to contact the other node, and returns this IP as a
string. It is particularly useful when your setup spans across cloud
availability zones or different providers. At the moment only EC2 and
nodes with public `ipaddress` are supported; suggestions are welcome.

If both nodes are on EC2 and in the same region, then other node's
`ec2.local_ipv4` attribute is used. Otherwise, if other node is a
cloud instance, its `cloud_public.ipv4` attribute is used. Otherwise,
other node's `ipaddress` is used.

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

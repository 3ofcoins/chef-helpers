# Chef Helpers

This gem includes miscellaneous add-on helper methods for Opscode Chef.

## Installation

Add this line to your application's Gemfile:

    gem 'chef-helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chef-helpers

## Usage

Just add `chef_gem 'chef-helpers'` and `require 'chef-helpers'` in
your recipes.

### Node#allies()

New method `Chef::Node#allies` is defined. It returns an array of Node
objects, which include all Nodes in the current environment if the
environment is not `_default`.

If `node['allies']` attribute is defined, it should be an array of
node names or search terms. These nodes or search results will be
added to list of "allies".

This is used mostly for defining firewall access rules, to easily
select a group of nodes running the same environment, and some
selected nodes that should be able to communicate freely.

### Node#ip_for(other_node)

This method returns IP address that current node should use to
communicate with other node(s). The rules are:

 - If both nodes are on EC2 and in the same availability zone, other
   node's `ec2.local_ipv4` address is returned;
 - Otherwise, if other node is a cloud instance, its
   `cloud.public_ipv4` attribute is returned;
 - Otherwise, other node's `ipaddress` attribute is returned.

This may not work well with clouds other than EC2

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Changes
=======

0.1.0
-----
 - First not 0.0.* release
 - Made Chef a development dependency to avoid embedded gem confusion;
   installing it with a `chef_gem` resource is recommended, and then
   we can assume Chef is already installed.

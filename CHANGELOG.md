Changes
=======

0.1.2
-----
 - Fix problem on calling `has_resource?` multiple times. Authored by @sonots!

0.1.1
-----
 - Fix crucial typo in `has_cookbook_file?`. Authored by @maoueh!

0.1.0
-----
 - First not 0.0.* release
 - Made Chef a development dependency to avoid embedded gem confusion;
   installing it with a `chef_gem` resource is recommended, and then
   we can assume Chef is already installed.

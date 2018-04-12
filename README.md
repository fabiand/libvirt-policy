
Idea:

1. Have a policy-fied domxml.
2. Expand policies to domxml.

Dependencies/questions:
- Libvirt permits to influence how intermediate device tree nodes (i.e. busses)
  are created
- Libvirt does not always add intermediate devices
- Libvirt needs to allow setting default values for leave device attributes

Guiding principles:
- Needs to be living atop libvirtd

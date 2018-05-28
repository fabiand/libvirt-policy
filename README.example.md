# Overview

The idea is simple:

Have a snippet - called `Policy` - which is conditionally applied to a domain,
based on an XPath selector.

In other words: If a certain tag or attribute in a domain xml has a specific
value, merge in a more or less partial domain xml definition.

## Open Issues

- Should the policies be orthorogonal?
- If not: How do we handle conflicts?
- How can we inject dynamic data (i.e. number of cores)?
- Should a policy contain multiple snippets?
- Should there be a way to force a policy to override existing domxml fields?
- …

# Example

## Policy

`Policy` (could be any better name) effectively is a partial domxml.
It has a selector which is getting matched on the domxml the 

In the following example we check for `rhel-8` guests.
The `selector` can be _any_ XPath expression.

```xml
<policy
  selector='domain[policies/guest/@os="rhel-8"]'
  priority=99
  >
<domain>
  <!-- domain ? -->
  <memory unit='KiB'>2097152</memory>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
</domain>
</policy>
```

## Domain

The domain is a regular domain xml. It can be as complete or incomplete as
before.
The impotrant bit is that policies will be applied to it before it is processed
by the core libvirt processing (aka it can be done outside of libvirt or by a
hook).

In the example below a `policies` tag was added to have a _semantical_ place to
name the polcies which should be applied. but in practice a policy (as defined
above) can be applied based on any XPath within the domain xml.

```xml
<domain>
  <policies>
    <guest os="rhel-7"/>
  </policies>
  <name>centos7.0</name>
  <uuid>9fee3a60-4746-45b5-b3db-8d9a70efb94d</uuid>
</domain>
```

Instead of the `policies` tag we could also use the free-form metadata area.

## Result

The processing is pretty straight forward: The policy is taken, and based on the
selector the snippet is then merged into the domain xml.

Fields specified in the domain xml should have a precedence over policy fields.

```xml
<domain>
  <policies>
    <guest os="rhel-7"/>
    <!-- FIXME should we note here if it was applied? -->
    <!-- should this tag (policies) be removed? -->
  </policies>
  <name>centos7.0</name>
  <uuid>9fee3a60-4746-45b5-b3db-8d9a70efb94d</uuid>
  <memory unit='KiB'>2097152</memory>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
</domain>
```

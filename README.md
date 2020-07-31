# vision-hashicorp

[![Build Status](https://travis-ci.org/vision-it/vision-hashicorp.svg?branch=development)](https://travis-ci.org/vision-it/vision-hashicorp)

## Parameter

### Consul Keys

```
consul keygen
```

### Nomad Keys

```
nomad operator keygen
```

## Nomad ACL

```
nomad acl bootstrap
nomad acl policy apply -description "Anonymous" anonymous anonymous.policy.hcl
nomad acl policy apply -description "CI Runner" ci ci.policy.hcl
```


## Usage


Include in the *Puppetfile*:

```
mod 'vision_hashicorp',
    :git => 'https://github.com/vision-it/vision-hashicorp.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_hashicorp
```


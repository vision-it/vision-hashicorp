# vision-hashicorp

[![Build Status](https://travis-ci.com/vision-it/vision-hashicorp.svg?branch=staging)](https://travis-ci.com/vision-it/vision-hashicorp)

## Parameter

### Gossip Encrypt Keys

```
consul keygen
nomad operator keygen
```

# Bootsrap Nomad ACL

```
$server1: nomad acl bootstrap
$server1: nomad acl policy apply -description "Anonymous" anonymous anonymous.policy.hcl
$server1: nomad acl policy apply -description "CI Runner" ci ci.policy.hcl
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
contain ::vision_hashicorp::consul::server
contain ::vision_hashicorp::consul::client
contain ::vision_hashicorp::nomad::server
contain ::vision_hashicorp::nomad::client
```

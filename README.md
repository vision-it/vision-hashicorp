# vision-hashicorp

[![Build Status](https://travis-ci.org/vision-it/vision-hashicorp.svg?branch=development)](https://travis-ci.org/vision-it/vision-hashicorp)

## Parameter

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


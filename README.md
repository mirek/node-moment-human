
## Summary

Support for human readable date and duration parsing for momentjs, ie:

- `1 day ago` -> date, relative to passed now value or implicit current date.
- `1 year` -> duration
- ...

## Installation

    npm install moment-human --save

## Usage

    momentHuman = require 'moment-human'
    console.log momentHuman.parse '1 day ago'

(this will change to standard momentjs plugin)

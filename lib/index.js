(function() {
  var Parser, moment, parse;

  moment = require('moment');

  Parser = require('../lib/parser');

  parse = function(string, now) {
    return Parser.parse(string, {
      now: now
    }).toDate();
  };

  module.exports = {
    parse: parse
  };

}).call(this);

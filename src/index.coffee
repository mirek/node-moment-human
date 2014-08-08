
moment = require 'moment'
Parser = require '../lib/parser'

parse = (string, now) ->
  Parser.parse(string, { now }).toDate()

module.exports = {
  parse
}

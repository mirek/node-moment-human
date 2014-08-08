{
  var moment = require('moment')
  var now = options.now || moment()
}

start
  = date
  / ago
  / in
  / spans
  / span

date
  = components:(ago / in)* {
    return components.reduce(function (accumulator, current) {
      return accumulator.add(current)
    }, now)
  }

in
  = 'in' ws value:(spans / span)
  / value:(spans / span) ws 'from now' {
    return value
  }

ago
  = value:(spans / span) ws 'ago' {
    return -value
  }

spans
  = first:span ws rest:(('and' / ',')* ws value:span { return value }) {
    return rest.reduce(function (accumulator, current) {
      return accumulator.add(first)
    }, first)
  }

span
  = second_span
  / minute_span
  / hour_span
  / day_span
  /*/ week_span*/
  /*/ month_span*/
  /*/ quarter_span*/
  /*/ year_span*/
  /*/ decade_span*/
  /*/ century_span*/
  /*/ millenium_span*/

second_span
  = value:number ws? ('seconds' / 'second' / 'secs' / 'sec' / 's') {
    return moment.duration(value, 'second')
  }

minute_span
  = value:number ws? ('minutes' / 'minute' / 'mins' / 'min' / 'm') {
    return moment.duration(value, 'minute')
  }

hour_span
  = value:number ws? ('hours' / 'hour' / 'hrs' / 'hr' / 'h') {
    return moment.duration(value, 'hour')
  }

day_span
  = value:number ws? ('days' / 'day' / 'd') {
    return moment.duration(value, 'day')
  }

number
  = '-'? int frac? exp? {
    return parseFloat(text())
  }

int
  = value:$(zero / (digit1_9 digit*)) {
    return value
  }

frac
  = '.' digit+

exp
  = [eE] (minus / plus)? digit+

digit1_9
  = [1-9]

digit
  = [0-9]

zero
  = '0'

minus
  = '-'

plus
  = '+'

char
  = unescaped
  / escape sequence:(
      '"'
    / "\\"
    / "/"
    / "b" { return "\b"; }
    / "f" { return "\f"; }
    / "n" { return "\n"; }
    / "r" { return "\r"; }
    / "t" { return "\t"; }
    / "u" digits:$(hex hex) {
      return String.fromCharCode(parseInt(digits, 16))
    }
  ) {
    return sequence
  }

hex
  = $(hexdig hexdig)

hexdig
  = [0-9a-f]i

escape
  = "\\"

unescaped
  = [\x20-\x21\x23-\x5B\x5D-\u10FFFF]

ws
  = [ \t\n\r]*

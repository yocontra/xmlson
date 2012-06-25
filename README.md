![status](https://secure.travis-ci.org/wearefractal/xmlson.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>xmlson</td>
</tr>
<tr>
<td>Description</td>
<td>XML-JSON translation</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Dependencies

xmlson uses ltx which uses libexpat - a super fast native XML parser. You may need to install it if your OS does not have it installed already.

```
$ sudo apt-get install libexpat1 libexpat1-dev
```

## Usage

### Synchronous

```coffee-script
xmlson = require 'xmlson'

myObject = xmlson.toJSON '<cool><whatever name="ya"/></cool>'
# myObject = {cool:{whatever:[{"@name":"ya"}]}

myString = xmlson.toXML {cool:{whatever:[{"@name":"ya"}]}}
# myString = <cool><whatever name="ya"/></cool>
```

### Asynchronous

```coffee-script
xmlson = require 'xmlson'

xmlson.toJSON '<cool><whatever name="ya"/></cool>', (err, myObject) ->
  # myObject = {cool:{whatever:[{"@name":"ya"}]}

xmlson.toXML {cool:{whatever:[{"@name":"ya"}]}}, (err, myString) ->
  # myString = <cool><whatever name="ya"/></cool>
```

## Benchmarks

These were done on a laptop with an i7 - you will probably get much better results on an actual server.

Summary: 

A complex JSON object can be turned into an XML string in 0.052ms (avg)

A complex XML string can be turned into a JSON object in 0.015ms (avg)

```
xmlson.toJSON(tiny) x 36,903 ops/sec ±5.34% (50 runs sampled)
xmlson.toJSON(simple) x 29,429 ops/sec ±3.82% (51 runs sampled)
xmlson.toJSON(standard) x 12,098 ops/sec ±2.30% (53 runs sampled)
xmlson.toJSON(complex) x 12,932 ops/sec ±1.85% (54 runs sampled)
xmlson.toXML(tiny) x 2,034,542 ops/sec ±4.60% (60 runs sampled)
xmlson.toXML(simple) x 230,857 ops/sec ±0.26% (63 runs sampled)
xmlson.toXML(standard) x 62,608 ops/sec ±1.38% (62 runs sampled)
xmlson.toXML(complex) x 36,974 ops/sec ±0.87% (60 runs sampled)
```

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
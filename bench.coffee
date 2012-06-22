xmlson = require './'
Benchmark = require 'benchmark'

tiny = "<foo/>"
simple = "<foo bar='baz'>quux</foo>"
standard = '<animals type="pets" test="yeah"><dog type="dumb"><name>Rufus</name><breed>labrador</breed></dog><dog><name>Marty</name><breed>whippet</breed></dog><dog/><cat name="Matilda"/></animals>'
complex = '<iq id="123456" type="set" to="call57@test.net/1" from="9001@cool.com/1"><say xmlns="urn:xmpp:tropo:say:1" voice="allison"><audio src="http://acme.com/greeting.mp3">Thanks for calling ACME company</audio><audio src="http://acme.com/package-shipped.mp3">Your package was shipped on</audio><say-as interpret-as="date">12/01/2011</say-as></say></iq>'

tinyjs = xmlson.toJSON tiny
simplejs = xmlson.toJSON simple
standardjs = xmlson.toJSON standard
complexjs = xmlson.toJSON complex


suite = new Benchmark.Suite 'xmlson'
suite.on "error", (event, bench) -> throw bench.error
suite.on "cycle", (event, bench) -> console.log String bench

suite.add "xmlson.toJSON(tiny)", -> xmlson.toJSON tiny
suite.add "xmlson.toJSON(simple)", -> xmlson.toJSON simple
suite.add "xmlson.toJSON(standard)", -> xmlson.toJSON standard
suite.add "xmlson.toJSON(complex)", -> xmlson.toJSON complex


suite.add "xmlson.toXML(tiny)", -> xmlson.toXML tinyjs
suite.add "xmlson.toXML(simple)", -> xmlson.toXML simplejs
suite.add "xmlson.toXML(standard)", -> xmlson.toXML standardjs
suite.add "xmlson.toXML(complex)", -> xmlson.toXML complexjs
suite.run()

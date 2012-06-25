xmlson = require '../'
should = require 'should'
require 'mocha'

describe 'toJSON()', ->
  it 'simple', (done) ->
    input = '<animals type="pets" test="yeah"><dog type="dumb"><name>Rufus</name><breed>labrador</breed></dog><dog><name>Marty</name><breed>whippet</breed></dog><dog/><cat name="Matilda"/></animals>'
    expected = 
      animals:
        "@type":"pets"
        "@test":"yeah"
        dog: [
          {
            "@type":"dumb"
            name: [
              text:"Rufus"
            ]
            breed: [
              text:"labrador"
            ]
          }
          {
            name: [
              text:"Marty"
            ]
            breed: [
              text:"whippet"
            ]
          }
          {}
        ],
        cat: [
          {
            "@name":"Matilda"
          }
        ]
    output = xmlson.toJSON input
    should.exist output
    output.should.eql expected

    xmlson.toJSON input, (err, res) ->
      should.not.exist err
      should.exist res
      res.should.eql expected
      done()

  it 'standard', (done) ->
    input = '<iq id="123456" type="set" to="call57@test.net/1" from="9001@cool.com/1"><say xmlns="urn:xmpp:tropo:say:1" voice="allison"><audio src="http://acme.com/greeting.mp3">Thanks for calling ACME company</audio><audio src="http://acme.com/package-shipped.mp3">Your package was shipped on</audio><say-as interpret-as="date">12/01/2011</say-as></say></iq>'
    expected = 
      iq:
        "@id":"123456"
        "@type":"set"
        "@to":"call57@test.net/1"
        "@from":"9001@cool.com/1"
        say: [
          {
            "@xmlns":"urn:xmpp:tropo:say:1"
            "@voice":"allison"
            audio: [
              {
                "@src":"http://acme.com/greeting.mp3"
                text:"Thanks for calling ACME company"
              }
              {
                "@src":"http://acme.com/package-shipped.mp3"
                text:"Your package was shipped on"
              }
            ]
            "say-as": [
              {
                "@interpret-as":"date"
                text:"12/01/2011"
              }
            ]
          }
        ]
    output = xmlson.toJSON input
    should.exist output
    output.should.eql expected
    done()
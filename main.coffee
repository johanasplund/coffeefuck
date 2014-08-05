doc = """
Usage: main.coffee <code> [-i <inputs>...]

-h --help     Show this.
-v --version  Shows the version.
-i --inputs   Specify inputs for each "," in order.
              Number of inputs must match the number of ",".
"""
{docopt} = require 'docopt'

doc = docopt(doc, version: "0.1")

class Tape
  constructor: (@tape, @output, @promptedChars) ->
  addAt: (pos, val) =>
    if val == undefined
      toAdd = 1
    else
      toAdd = val
    if pos of @tape and toAdd == 1
      @tape[pos] += toAdd
    else if @tape[pos] == undefined or toAdd > 1
      @tape[pos] = toAdd
  subAt: (pos) =>
    if pos of @tape and @tape[pos] > 0
      @tape[pos] -= 1
    else
      @tape[pos] = 0
  printAtIndex: (pos) =>
    @output.push(String.fromCharCode(@tape[pos]))

class Pointer
  constructor: (@x) ->
  moveUp: =>
    @x += 1
  moveDown: =>
    @x -= 1

doInstruction = (char, t, p, manualInputIndex, manualInputs) ->
  switch char
    when ">"
      p.moveUp()
      return ">"
    when "<"
      p.moveDown()
      return "<"
    when "+"
      t.addAt(p.x)
      return "+"
    when "-"
      t.subAt(p.x)
      return "-"
    when "."
      t.printAtIndex(p.x)
      return "."
    when ","
      if manualInputIndex != undefined
        try
          t.addAt(p.x, manualInputs[manualInputIndex].charCodeAt(0))
        catch e
          console.log "The number of inputs need to match the number of ,"
          process.exit(1)
      return ","

findMatchingBracket = (code, pos) ->
  counter = 1
  for i in [0..pos]
    currentChar = code[pos-i-1]
    if currentChar == "]"
      counter += 1
    else if currentChar == "["
      counter -= 1
    if counter == 0
      return pos-i
  throw new SyntaxError("Missing starting bracket")
tape = new Tape({0: 0}, [])
pointer = new Pointer(0)
inputCode = doc["<code>"]
currChar = 0
inputcounter = -1
while currChar < inputCode.length
  if inputCode[currChar] == ","
    inputcounter += 1
  doInstruction(inputCode[currChar], tape, pointer, inputcounter, doc["<inputs>"])
  if inputCode[currChar]  == "]" and tape.tape[pointer.x] != 0  and tape.tape[pointer.x] != undefined
    currChar = findMatchingBracket(inputCode, currChar)
  else
    currChar += 1
console.log tape.output.join("")

exports.findMatchingBracket = findMatchingBracket
exports.doInstruction = doInstruction
exports.Tape = Tape
exports.Pointer = Pointer
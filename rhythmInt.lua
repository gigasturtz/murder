--generate rhythms from integers


function init()
  output[1].action = pulse(0.5, 10)
  output[2].slew = .05
  beat = { 235, 205, 215, 175 }
  chords = {{ 0, 3, 7 }, { 4, 8, 11 }, { 5, 9, 12 }}
  chordDegree = 1
  currentChord = 1
  pattern = 1
  beatReset = 0
  clock = metro.init{ event = rhythm_loop(8), time = .1, count = -1 }
  clock:start()
end

function rhythm_loop(beatLength)
  return function(count)
    if math.fmod(bit32.rshift(beat[pattern], beatReset), 2) == 1 then
      output[1](true)
      -- play_melody
      output[2].volts = 2 + (.0833 * (chords[currentChord][chordDegree] + 1))
      print(output[2].volts)
      chordDegree = chordDegree + 1
      if chordDegree == #chords[currentChord] + 1 then
        chordDegree = 1
      end
    end
    beatReset = beatReset + 1
    if beatReset == beatLength + 1 then
      beatReset = 0
      pattern = pattern + 1
      if pattern == #beat + 1 then
        pattern = 1
      end
      currentChord = currentChord + 1
      if currentChord == #chords + 1 then
        currentChord = 1
      end
    end
  end
end

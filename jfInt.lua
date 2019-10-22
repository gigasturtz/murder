--generate rhythms from integers


function init()
  ii.jf.mode(1)
  beat = { 255, 255, 255, 255 }
  chords = {{ 0, 3, 0 }, { 4, 8, 4 }, { 5, 9, 5 }}
  chordDegree = 1
  currentChord = 1
  pattern = 1
  beatReset = 0
  clock = metro.init{ event = rhythm_loop(8), time = .3, count = -1 }
  clock:start()
end

function rhythm_loop(beatLength)
  return function(count)
    if math.fmod(bit32.rshift(beat[pattern], beatReset), 2) == 1 then
      ii.jf.play_note(.0833 * (chords[currentChord][chordDegree]),5)
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

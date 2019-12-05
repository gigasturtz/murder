--generate rhythms from integers


function init()
  ii.pullup(true)
  ii.jf.mode(1)
  beat = { 255, 255, 255, 255 }
  chords = {
    { 15, 15, 19, 15, 15, 19, 15, 15 },
    { 14, 15, 17, 14, 15, 17, 14, 15 },
    { 15, 15, 19, 15, 15, 19, 15, 15 },
    { 12, 15, 15, 12, 15, 15, 12, 15 },
    { 10, 15, 15, 10, 15, 15, 10, 15 },
    { 8, 15, 15, 8, 15, 15, 8, 15 },
    { 10, 14, 20, 10, 14, 20, 10, 14 },
    { 10, 14, 20, 10, 14, 20, 10, 14 },
    { 8, 15, 15, 8, 15, 15, 8, 15 }
  }
  chordDegree = 1
  currentChord = 1
  pattern = 1
  beatReset = 0
  input[1].mode('change', 1.0,0.1,'rising')
end

input[1].change = function(state)
  rhythm_loop(8)
end

function rhythm_loop(beatLength)
    if math.fmod(bit32.rshift(beat[pattern], beatReset), 2) == 1 then
      ii.jf.play_note(.0833 * (chords[currentChord][chordDegree]),5)
      print(chords[currentChord][chordDegree])
      chordDegree = chordDegree + 1
      if chordDegree == #chords[currentChord] + 1 then
        chordDegree = 1
      end
    end
    beatReset = beatReset + 1
    if beatReset == 8 then
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

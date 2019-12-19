--generate rhythms from integers


function init()
  ii.pullup(true)
  ii.jf.mode(1)
  ii.jf.transpose(-1)
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
  chordDegree = {1}
  currentChord = {1}
  pattern = {1}
  beatReset = {0}
  input[1].mode('change', 1.0,0.1,'rising')
end

input[1].change = function(state)
  rhythm_loop(8)
end

function rhythm_loop(beatLength)
    if math.fmod(bit32.rshift(beat[pattern[1]], beatReset[1]), 2) == 1 then
      if chordDegree[1] == 1 then
        ii.jf.play_note(.0833  * (chords[currentChord[1]][chordDegree[1]] - 12),5)
      end
      ii.jf.play_note(.0833 * (chords[currentChord[1]][chordDegree[1]]),5)
      if incrementValue(chordDegree, #chords[currentChord[1]] + 1) then
        chordDegree[1] = 1
      end
    end
    if incrementValue(beatReset, beatLength) then
      beatReset[1] = 0
      if incrementValue(pattern, #beat) then
        pattern[1] = 1
      end
      if incrementValue(currentChord, #chords) then
        currentChord[1] = 1
      end
    end
end

function incrementValue(value, max)
  value[1] = value[1] + 1
  if value[1] == max then
    return true
  end
  return false
end

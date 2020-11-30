local composer = require("composer")
local widget = require("widget")

langtexts = {}
langtexts[1] = {
    'Play!',
    'Options',
    'What to do?\n\nPlay a predator and feed on enough butterflies each round to survive.\n\n\n\nClick on these to get your nutrients',
    'Butterflies reproducing…\n\n…fresh eggs are being laid',
    'You’ve failed to get enough nutrients! Reincarnate as a new predator and start from scratch',
    'You made it!\n\nWhat happened to the prey population over generations?\nAnalyze your results considering the guidelines',
    'Results',
    'Number of generations',
    'Phenotype frequency',
    'What is the goal?\n\nUnderstand how adaptations like camouflage, aposematism, and mimicry can establish in a population under the selective pressure of predation',
    'Tinigua Forest',
    'Paramillo Forest',
    'You ate too many toxic butterflies!\nReincarnate as a new predator and start from scratch',
    'Instructions',
    'Credits\n\nArtwork and design – Rebekka Janke​\nSoftware developer – Eugen Bauer​\nConcept – Laura Flórez​',
    'This project is licensed under the terms of the MIT license.',
    'Environment change'
}
langtexts[2] = {
    'Los!',
    'Optionen',
    'Was tun?\n\nSei der Räuber und friss jede Runde genügend Beutetiere, um zu überleben\n\n\n\nDas ist deine Nahrungsquelle',
    'Schmetterlinge vermehren sich gerade…\n\n…frische Eier werden gelegt',
    'Du hast nicht genügend Nahrung gesichert!\nReinkarniere als ein neues Raubtier und fang von vorne an',
    'Geschafft!\n\nWas ist mit der Beutepopulation über Generationen passiert?\nAnalysiere dein Ergebnis hinsichtlich der Richtlinien',
    'Ergebnis',
    'Anzahl an Generationen',
    'Phenotypfrequenz',
    'Was ist das Ziel?\n\nVerstehen wie sich Merkmale wie Tarnung, Aposematismus und Mimikry in einer Beutepopulation durchsetzen können',
    'Tinigua Wald',
    'Paramillo Wald',
    'Du hast zu viel giftige Beute gefressen!\nReinkarniere als ein neues Raubtier und fang von vorne an',
    'Anleitung',
    'Credits\n\nDesign – Rebekka Janke​\nProgrammierer – Eugen Bauer​\nKonzept – Laura Flórez​',
    'Dieses Projekt besteht unter der MIT Lizenz.',
    'Umweltsveränderung'
}

imgtexts = {}
imgtexts[1] = {
    'Title_en.png',
    'whatsthegoal_text.png',
    'whattodo_text.png',
    'ParamilloForest_text_en.png',
    'TiniguaForest_text_en.png'
}
imgtexts[2] = {
    'Title_de.png',
    'whatsthegoal_text_de.png',
    'whattodo_text_de.png',
    'ParamilloForest_text_de.png',
    'TiniguaForest_text_de.png'
}
tits = 35
bots = 22
texs = 20
rtexs = 18

langset = 1
popsize = 200
bfit = 3
rfac = 30
freq = 0.5
freqapo = 0.5
maxgens = 3
changenv = false

feedtime = 20
gentime = 3

curlvl = 1
lbutton = "gameover"

images = {
  "Camouflage.png",
  "Mimicry.png",
  "Aposematism.png",
  "Obstacle1.png"
}
cwin = 10
awin = 10
toxi = -30

population = {}
bgcol = math.random(0,rfac)/rfac
for i=1,bfit do
    table.insert(population,bgcol)
end
for i=bfit,popsize do
    table.insert(population,math.random(0,rfac)/rfac)
end
stats={}

function swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

function shuffle(array)
    local counter = #array
    while counter > 1 do
        local index = math.random(counter)
        swap(array, index, counter)
        counter = counter - 1
    end
end

function FYShuffle( tInput )
    local tReturn = {}
    for i = #tInput, 1, -1 do
        local j = math.random(i)
        tInput[i], tInput[j] = tInput[j], tInput[i]
        table.insert(tReturn, tInput[i])
    end
    return tReturn
end

function PreShuffle( tInput )
    local quant = math.floor(#tInput/4)
    local randi = math.random(quant,#tInput-quant)
    local tReturn = {}
    for i = randi,#tInput do
      table.insert(tReturn, tInput[i])
    end
    for i = 1,randi do
      table.insert(tReturn, tInput[i])
    end
    return tReturn
end

function stats.mean( t )
  local sum = 0
  local count= 0

  for k,v in pairs(t) do
    if type(v) == 'number' then
      sum = sum + v
      count = count + 1
    end
  end

  return (sum / count)
end
-- Get the median of a table.
function stats.median( t )
  local temp={}

  -- deep copy table so that when we sort it, the original is unchanged
  -- also weed out any non numbers
  for k,v in pairs(t) do
    if type(v) == 'number' then
      table.insert( temp, v )
    end
  end

  table.sort( temp )

  -- If we have an even number of table elements or odd.
  if math.fmod(#temp,2) == 0 then
    -- return mean value of middle two elements
    return ( temp[#temp/2] + temp[(#temp/2)+1] ) / 2
  else
    -- return middle element
    return temp[math.ceil(#temp/2)]
  end
end
-- Get the standard deviation of a table
function stats.standardDeviation( t )
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = stats.mean( t )

  for k,v in pairs(t) do
    if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
    end
  end

  result = math.sqrt(sum / (count-1))

  return result
end

--
-- handle system events
--
local function systemEvents(event)
    if event.type == "applicationStart" then
        composer.gotoScene("menu", {time = 500, effect = "fade"})
    end
    return true
end
Runtime:addEventListener("system", systemEvents)

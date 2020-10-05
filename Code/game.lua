local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require("widget")


strike = 0
barwidth = 200
maxheigth = display.contentHeight*1.2
elements = {}
local myTimers = {}
barxoffset = (display.contentCenterX+display.actualContentWidth/5)

function badbgresult()
    transition.to(badbg, {time=100, alpha=0, alpha=1})
    transition.to(badbg, {time=100, delay=100, alpha=0})
    if(fillBar.width <= 4) then
        strike = strike+1
        if(strike == 1) then
            skull1.alpha=1
        end
        if(strike == 2) then
            skull2.alpha=1
        end
        if(strike > 2) then
            composer.removeScene("game",false)
            composer.gotoScene("gameover2", {effect = "crossFade", time = 500})
        end
    end
end

function addElement(ptype,index,x,y,width)
    local element = display.newImage(images[ptype])
    hescale = width/element.height
    wescale = width/element.width
    
    element:scale(wescale, hescale)
    element.x = x
    element.y = y
    element.type = ptype
    element.index = index
    element.avail = true
    element.rotation = math.random()*360

    local function onTouch(event)
        if(event.phase == "began" and event.target.avail == true) then
            if(event.target.type == 1) then
                event.target.avail=false
                event.target.alpha=0
                val = cwin
            end
            if(event.target.type == 2) then
                event.target.avail=false
                event.target.alpha=0
                val = awin
            end
            if(event.target.type == 3) then
                event.target.avail=false
                event.target.alpha=0
                val = toxi
                badbgresult()
                --badbg.alpha
            end
            if(event.target.type == 4) then
                val = 0
            end
            if(val ~= 0 and fillBar ~= nil) then
                fillBar.alpha=1
                if(fillBar.width+val < barwidth) then
                    if(fillBar.width+val < 0) then
                        fillBar.width = 0
                        fillBar.x = (barxoffset-(barwidth/2))+(fillBar.width/2)
                        fillBar.alpha=0
                    else
                        fillBar.width = fillBar.width+val
                        fillBar.x = (barxoffset-(barwidth/2))+(fillBar.width/2)
                    end
                else
                    fillBar.width = barwidth
                    fillBar.x = (barxoffset-(barwidth/2))+(fillBar.width/2)
                end
            end
        end
        return true
    end
    element:addEventListener("touch", onTouch)
    return element
end
--
-- Start the composer event handlers
--
function scene:create(event)
    math.randomseed(os.time())

	local sceneGroup = self.view
    myInds = {}

    local mbgImage = {type="image", filename="Background_brighter.png"} 
    local mbackground = display.newRect(0,0,display.actualContentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    badbg = display.newRect(display.contentCenterX,display.contentCenterY,
        display.actualContentWidth,display.actualContentHeight)
    badbg:setFillColor(1,0,0)
    badbg.alpha=0

    emptyBar = display.newRoundedRect(barxoffset, display.contentCenterY-display.actualContentHeight/2.5, barwidth, 20, 6)
    emptyBar.strokeWidth = 3
    emptyBar:setFillColor(0.5)
    fillBar = display.newRoundedRect(barxoffset-(barwidth/2), display.contentCenterY-display.actualContentHeight/2.5, 0, 20, 6)
    fillBar.strokeWidth = 3
    fillBar:setFillColor(1,0,0)
    fillBar.alpha=0

    skull1 = display.newImage("Skull.png")
    skull1:scale(0.35,0.35)
    skull1.y = fillBar.y
    skull1.x = display.contentCenterX-display.actualContentWidth/20
    skull1.alpha=0
    skull2 = display.newImage("Skull.png")
    skull2:scale(0.35,0.35)
    skull2.y = fillBar.y
    skull2.x = display.contentCenterX-display.actualContentWidth/10
    skull2.alpha=0

    sceneGroup:insert(skull1)
    sceneGroup:insert(skull2)

    local effpop = abcam+abmim+abapo
    --print("Effective population:",effpop)
    local gridr = 22
    local gridc = 12
    local abob = math.ceil(((gridr*gridc)-effpop)/3)

    local boxsize = 20

    local pop = {}
    for i=1,abcam do
        table.insert(pop,1)
    end
    for i=1,abmim do
        table.insert(pop,2)
    end
    for i=1,abapo do
        table.insert(pop,3)
    end
    for i=1,abob do
        table.insert(pop,4)
    end
    for i=#pop,gridr*gridc do
        table.insert(pop,5)
    end
    --math.randomseed(os.time())
    --pop = PreShuffle(pop)
    pop = FYShuffle(pop)
    --print(math.random(-10.4,0))
    --math.randomseed(os.time())
    --pop = PreShuffle(pop)
    --print(abob)
    --print(#pop)
    --pop = FYShuffle(pop)
    --pop = FYShuffle(pop)
    --pop = FYShuffle(pop)


    xstart = display.contentCenterX-(((gridr+1)*boxsize)*0.5)
    ystart = display.contentCenterY-((gridc*boxsize)*0.45)

    for i = 1,gridr do
        for j = 1,gridc do
            poptype = pop[i*j]
            if(poptype~=5) then
                local rposx = math.random(-boxsize/2,boxsize/2)
                local rposy = math.random(-boxsize/2,boxsize/2)
                obj = addElement(poptype,i+j,xstart+i*boxsize+rposx,ystart+j*boxsize+rposy,boxsize)
                table.insert(elements,obj)
            end
            --if(poptype == 1) then
        end
    end

    secondsLeft = feedtime
    local clockText = display.newText({
        text = secondsLeft,
        x = display.contentCenterX-display.actualContentWidth/5,
        y = display.contentCenterY-display.actualContentHeight/2.5,
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = bots,
        align = "center"
    })
    clockText:setFillColor(1,0,0)
    sceneGroup:insert(clockText)

    local function updateTime()
        if(clockText~=nil) then
            secondsLeft = secondsLeft - 1 
            local timeDisplay = string.format(secondsLeft)
            clockText.text = timeDisplay
            myTimers[#myTimers+1] = timer.performWithDelay(500, function()
                if(clockText~=nil) then
                    clockText:setFillColor(1)
                end
            end,1)
            myTimers[#myTimers+1] = timer.performWithDelay(1000, function()
                if(clockText~=nil) then
                    clockText:setFillColor(1,0,0)
                end
            end,1)
            if(secondsLeft == 0) then
                if(fillBar.width >= barwidth) then
                    if(#gens>maxgens) then
                        composer.removeScene("game",false)
                        composer.gotoScene("win", {effect = "crossFade", time = 500})
                    else
                        composer.removeScene("game",false)
                        composer.gotoScene("go", {effect = "crossFade", time = 500})
                    end
                else
                    composer.removeScene("game",false)
                    composer.gotoScene("gameover", {effect = "crossFade", time = 500})
                end
            end
        end
    end

    myTimers[#myTimers+1] = timer.performWithDelay(500, function()
        clockText:setFillColor(1)
    end,1)
    myTimers[#myTimers+1] = timer.performWithDelay(1000, function()
        clockText:setFillColor(1,0,0)
    end,1)
    myTimers[#myTimers+1] = timer.performWithDelay(1000,updateTime,secondsLeft)

    sceneGroup:insert(badbg)
    
end

function scene:show(event)
    local sceneGroup = self.view
end

function scene:hide(event)
    local sceneGroup = self.view
end

function scene:destroy(event)
    local sceneGroup = self.view
    transition.cancel()
    emptyBar:removeSelf()
    emptyBar = nil
    fillBar:removeSelf()
    fillBar = nil
    camcount = 0
    mimcount = 0
    apocount = 0
    strike = 0
    for i = 1,#elements do
        if(elements[i].avail==true) then
            if(elements[i].type==1) then
                camcount=camcount+1
            end
            if(elements[i].type==2) then
                mimcount=mimcount+1
            end
            if(elements[i].type==3) then
                apocount=apocount+1
            end
        end
        elements[i]:removeSelf()
        elements[i]=nil
    end
    local endpop = camcount+mimcount+apocount
    --print("Population:",endpop)
    --print("Camouflage:",camcount)
    --print("Normal:",mimcount)
    --print("Toxic:",apocount)
    abcam = math.round((camcount/endpop)*popsize)
    if(curlvl == 1) then
        abmim = popsize-abcam
    else
        abmim = math.round((mimcount/endpop)*popsize)
    end
    if(curlvl == 1) then
        abapo = 0
    else
        abapo = popsize-(abcam+abmim)
    end
    gens[#gens+1] = {abcam,abmim,abapo}
    for k, v in pairs(myTimers) do
        timer.cancel(v)
    end
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene

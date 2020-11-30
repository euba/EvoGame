local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("paramillo_options",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

local function handleBackButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("paramillo_options",false)
        composer.gotoScene("paramillo", {effect = "crossFade", time = 500})
    end
end

local function handlePBut50Event(event)
    if ("ended" == event.phase) then
        PBut50.alpha=1
        PBut100.alpha=0.2
        PBut200.alpha=0.2
        --popsize = 50
        maxgens = 3
    end
end
local function handlePBut100Event(event)
    if ("ended" == event.phase) then
        PBut50.alpha=0.2
        PBut100.alpha=1
        PBut200.alpha=0.2
        --popsize = 100
        maxgens = 5
    end
end
local function handlePBut200Event(event)
    if ("ended" == event.phase) then
        PBut50.alpha=0.2
        PBut100.alpha=0.2
        PBut200.alpha=100
        --popsize = 200
        maxgens = 7
    end
end

local function slidePop(event)
    popsize = event.value*2+50
end

local function slideFreq(event)
    freq = event.value/100
    freqcur = freq
    --audio.setVolume(svolume, {channel=2})
end

local function handleBut25Event(event)
    if ("ended" == event.phase) then
        But50.alpha=0.2
        But25.alpha=1
        But75.alpha=0.2
        freq = 0.25
    end
end
local function handleBut50Event(event)
    if ("ended" == event.phase) then
        But50.alpha=1
        But25.alpha=0.2
        But75.alpha=0.2
        freq = 0.5
    end
end
local function handleBut75Event(event)
    if ("ended" == event.phase) then
        But50.alpha=0.2
        But25.alpha=0.2
        But75.alpha=1
        freq = 0.75
    end
end
local function handleEnvButtonEvent(event)
    if ("ended" == event.phase) then
        if(changenv == false) then
            changenv = true
            envButton.alpha = 1
        else
            changenv = false
            envButton.alpha = 0.2
        end
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
	local sceneGroup = self.view

    local mbgImage = {type="image", filename="OptionsParamilloForest.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    local psize = display.newText({
        text = langtexts[langset][8],     
        x = display.contentCenterX,
        y = display.contentCenterY-display.actualContentHeight/3,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    --local slidep = widget.newSlider({x=display.contentCenterX,y=(display.contentCenterY-display.actualContentHeight/3)+display.actualContentHeight/8,
    --    width=200,value=(popsize-50)/2,listener=slidePop})
    sceneGroup:insert(psize)
    --sceneGroup:insert(slidep)
    psize:setFillColor(0)

    --popy = display.contentCenterY+display.actualContentHeight/20
    popy = (display.contentCenterY-display.actualContentHeight/3)+display.actualContentHeight/8


    PBut50 = widget.newButton({
        label = "4",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX-display.contentWidth*(1/6),
        labelColor = {default={0,0,0},over={1,0,0}},
        y = popy,
        onEvent = handlePBut50Event
    })
    sceneGroup:insert(PBut50)
    if(maxgens == 3) then
        PBut50.alpha=1
    else
        PBut50.alpha=0.2
    end

    PBut100 = widget.newButton({
        label = "6",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX,
        labelColor = {default={0,0,0},over={1,0,0}},
        y = popy,
        onEvent = handlePBut100Event
    })
    sceneGroup:insert(PBut100)
    if(maxgens == 5) then
        PBut100.alpha=1
    else
        PBut100.alpha=0.2
    end

    PBut200 = widget.newButton({
        label = "8",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX+display.contentWidth*(1/6),
        labelColor = {default={0,0,0},over={1,0,0}},
        y = popy,
        onEvent = handlePBut200Event
    })
    sceneGroup:insert(PBut200)
    if(maxgens == 7) then
        PBut200.alpha=1
    else
        PBut200.alpha=0.2
    end

    envButton = widget.newButton({
        label = langtexts[langset][17],
        defaultFile = "Play_button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/1.8,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,1,1,1}, over={1,0,0,1}},
        onEvent = handleEnvButtonEvent
    })
    envButton.x = display.contentCenterX
    envButton.y = display.contentCenterY+display.actualContentHeight/8
    sceneGroup:insert(envButton)

    if(changenv == true) then
        envButton.alpha=1
    else
        envButton.alpha=0.2
    end

    --[[local min = display.newText({
        text = 50,     
        x = display.contentCenterX-display.contentWidth*(1/3.5),
        y = slidep.y,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    min:setFillColor(0,0,0)
    sceneGroup:insert(min)
    local max = display.newText({
        text = 250,     
        x = display.contentCenterX+display.contentWidth*(1/3.5),
        y = slidep.y,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    max:setFillColor(0,0,0)
    sceneGroup:insert(max)]]--

    --[[local fsize = display.newText({
        text = langtexts[langset][9],     
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    --local slidef = widget.newSlider({x=display.contentCenterX,y=display.contentCenterY+display.actualContentHeight/8,width=200,value=freq*100,listener=slideFreq})
    sceneGroup:insert(fsize)
    --sceneGroup:insert(slidef)
    fsize:setFillColor(0)

    freqy = display.contentCenterY+display.actualContentHeight/8

    But25 = widget.newButton({
        label = "25%",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX-display.contentWidth*(1/6),
        labelColor = {default={0,0,0},over={1,0,0}},
        y = freqy,
        onEvent = handleBut25Event
    })
    sceneGroup:insert(But25)
    if(freq == 0.25) then
        But25.alpha=1
    else
        But25.alpha=0.2
    end

    But50 = widget.newButton({
        label = "50%",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX,
        labelColor = {default={0,0,0},over={1,0,0}},
        y = freqy,
        onEvent = handleBut50Event
    })
    sceneGroup:insert(But50)
    if(freq == 0.5) then
        But50.alpha=1
    else
        But50.alpha=0.2
    end

    But75 = widget.newButton({
        label = "75%",
        shape="circle",
        radius = display.contentWidth*(1/20),
        x = display.contentCenterX+display.contentWidth*(1/6),
        labelColor = {default={0,0,0},over={1,0,0}},
        y = freqy,
        onEvent = handleBut75Event
    })
    sceneGroup:insert(But75)
    if(freq == 0.75) then
        But75.alpha=1
    else
        But75.alpha=0.2
    end

    cam = display.newImage(images[1])
    cam.strokeWidth = 0
    cam:setStrokeColor(0,0,0)
    cam.x = display.contentCenterX-display.contentWidth*(1/3)
    cam.y = freqy
    cam:scale(0.2,0.2)
    sceneGroup:insert(cam)

    mim = display.newImage(images[2])
    mim.strokeWidth = 0
    mim:setStrokeColor(0,0,0)
    mim.x = display.contentCenterX+display.contentWidth*(1/3)
    mim.y = freqy
    mim:scale(0.2,0.2)
    sceneGroup:insert(mim)]]--

    local homeButton = widget.newButton({
        defaultFile = "Home.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleHomeButtonEvent
    })
    homeButton:scale(0.03,0.03)
    homeButton.x = display.contentWidth*(10/12)
    homeButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(homeButton)

    local backButton = widget.newButton({
        defaultFile = "Back.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleBackButtonEvent
    })
    backButton:scale(0.03,0.03)
    backButton.x = display.contentWidth*(11/12)
    backButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(backButton)

end

function scene:show(event)
    local sceneGroup = self.view
end

function scene:hide(event)
    local sceneGroup = self.view
end

function scene:destroy(event)
    local sceneGroup = self.view
    envButton:removeSelf()
    envButton = nil
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene

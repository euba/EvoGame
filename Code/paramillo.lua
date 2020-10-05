local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("paramillo",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

local function handlePlayButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("paramillo",false)
        composer.gotoScene("go", {effect = "crossFade", time = 500})
    end
end

local function handleOptButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("paramillo",false)
        composer.gotoScene("paramillo_options", {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
    curlvl = 1
    gens = {}
    if(freq ~= 0.5) then
        freq = 0.5
    end
    --[[abcam = math.ceil(popsize*(1-freq))
    abmim = math.ceil((popsize*freq)*(1-freqapo))
    abapo = math.ceil((popsize*freq)*(freqapo))]]--
    abcam = math.ceil(popsize*(1-freq))
    abmim = popsize-abcam
    abapo = 0
    gens[#gens+1] = {abcam,abmim,abapo}

	local sceneGroup = self.view

    local mbgImage = {type="image", filename="ParamilloForest.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    local myText = display.newText({
        text = langtexts[langset][12], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentWidth/10, 
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = tits,
        align = "center"
    })
    myText:setFillColor(0)
    sceneGroup:insert(myText)

    local homeButton = widget.newButton({
        defaultFile = "Home.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleHomeButtonEvent
    })
    homeButton:scale(0.03,0.03)
    homeButton.x = display.contentWidth*(11/12)
    homeButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(homeButton)

    local playButton = widget.newButton({
        label = langtexts[langset][1],
        defaultFile = "Play_button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,1,1,1}, over={1,0,0,1}},
        onEvent = handlePlayButtonEvent
    })
    playButton.x = display.contentCenterX-display.contentWidth*(1/7)
    playButton.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(playButton)

    local setButton = widget.newButton({
        label = langtexts[langset][2],
        defaultFile = "Opt_button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,1,1,1}, over={1,0,0,1}},
        onEvent = handleOptButtonEvent
    })
    setButton.x = display.contentCenterX+display.contentWidth*(1/7)
    setButton.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(setButton)

    local homeButton = widget.newButton({
        defaultFile = "Home.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleHomeButtonEvent
    })
    homeButton:scale(0.03,0.03)
    homeButton.x = display.contentWidth*(11/12)
    homeButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(homeButton)

    --[[local backButton = widget.newButton({
        defaultFile = "Back.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleBackButtonEvent
    })
    backButton:scale(0.03,0.03)
    backButton.x = display.contentWidth*(11/12)
    backButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(backButton)]]--
end

function scene:show(event)
    local sceneGroup = self.view
end

function scene:hide(event)
    local sceneGroup = self.view
end

function scene:destroy(event)
    local sceneGroup = self.view
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene

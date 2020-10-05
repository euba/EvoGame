local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleHelpButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("menu",false)
        composer.gotoScene("tutorial1", {effect = "crossFade", time = 500})
    end
end

local function handlePlayButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("menu",false)
        composer.gotoScene("tutorial1", {effect = "crossFade", time = 500})
    end
end

local function handleSetButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("menu",false)
        composer.gotoScene("options", {effect = "crossFade", time = 500})
    end
end

local function handleParamilloButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("menu",false)
        composer.gotoScene("paramillo", {effect = "crossFade", time = 500})
    end
end

local function handleTiniguaButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("menu",false)
        composer.gotoScene("tinigua", {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
    local sceneGroup = self.view

    local mbgImage = {type="image", filename="Startscreen.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    tit = display.newImage(imgtexts[langset][1])
    tit.strokeWidth = 0
    tit:setStrokeColor(0,0,0)
    tit.x = display.contentCenterX
    tit.y = display.contentCenterY-display.contentHeight*0.2
    local scalefac = (display.contentWidth*0.9)/tit.width
    tit:scale(scalefac,scalefac)
    sceneGroup:insert(tit)

    --[[local myText = display.newText({
        text = langtexts[langset][1], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentHeight/6, 
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = tits,
        align = "center"
    })
    myText:setFillColor(0)
    sceneGroup:insert(myText)]]--

    local helpButton = widget.newButton({
        defaultFile = "Instructions.png",
        --label = "test",
        --labelXOffset = 0,
        --labelYOffset = 0,
        onEvent = handleHelpButtonEvent,
        fontSize = bots,
        --labelColor = {default={1,0,0,1}, over={1,0,0,1}},
        font = "CP.ttf"
    })
    helpButton:scale(0.08,0.08)
    helpButton.x = display.contentWidth*(2/12)
    helpButton.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(helpButton)

    insts = display.newText({
        text = langtexts[langset][14],     
        x = display.contentWidth*(2/12),
        y = (display.contentCenterY+display.actualContentHeight/4)-(helpButton.height/1.5)*0.08,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs-5,
        align = "center"
    })
    sceneGroup:insert(insts)

    local english = display.newImage('english.png')
    english:scale(0.06,0.06)
    english.x = display.contentWidth*(10/12)
    english.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(english)
    local german = display.newImage('german.png')
    german:scale(0.06,0.06)
    german.x = display.contentWidth*(11/12)
    german.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(german)
    if(langset == 1) then
        english.alpha = 1
        german.alpha = 0.5
    end
    if(langset == 2) then
        english.alpha = 0.5
        german.alpha = 1
    end

    local function onTouch(event)
        if(event.phase == "began") then
            langset = 1
            english.alpha = 1
            german.alpha = 0.5
            tit.alpha=0
            tit = display.newImage(imgtexts[langset][1])
            tit.strokeWidth = 0
            tit:setStrokeColor(0,0,0)
            tit.x = display.contentCenterX
            tit.y = display.contentCenterY-display.contentHeight*0.2
            tit:scale(scalefac,scalefac)
            insts.text = langtexts[langset][14]
            sceneGroup:insert(tit)
        end
        return true
    end
    english:addEventListener("touch", onTouch)
    local function onTouch(event)
        if(event.phase == "began") then
            langset = 2
            english.alpha = 0.5
            german.alpha = 1
            tit.alpha=0
            tit = display.newImage(imgtexts[langset][1])
            tit.strokeWidth = 0
            tit:setStrokeColor(0,0,0)
            tit.x = display.contentCenterX
            tit.y = display.contentCenterY-display.contentHeight*0.2
            tit:scale(scalefac,scalefac)
            insts.text = langtexts[langset][14]
            sceneGroup:insert(tit)
        end
        return true
    end
    german:addEventListener("touch", onTouch)

    local lvl1Button = widget.newButton({
        defaultFile = "Paramillo.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleParamilloButtonEvent
    })
    lvl1Button:scale(0.1,0.1)
    lvl1Button.x = display.contentCenterX-display.contentWidth*(1/12)
    lvl1Button.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(lvl1Button)

    local lvl2Button = widget.newButton({
        defaultFile = "Tinigua.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleTiniguaButtonEvent
    })
    lvl2Button:scale(0.1,0.1)
    lvl2Button.x = display.contentCenterX+display.contentWidth*(1/12)
    lvl2Button.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(lvl2Button)

    -- Create the widget
    --[[local playButton = widget.newButton({
        label = "Play!",
        defaultFile = "button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,0,0,1}, over={1,1,1,1}},
        onEvent = handlePlayButtonEvent
    })

    playButton.x = display.contentCenterX
    playButton.y = display.contentCenterY+display.actualContentHeight/5
    sceneGroup:insert(playButton)

    local setButton = widget.newButton({
        label = "Options",
        defaultFile = "button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,0,0,1}, over={1,1,1,1}},
        onEvent = handleSetButtonEvent
    })

    setButton.x = display.contentCenterX
    setButton.y = playButton.y + playButton.height*1
    sceneGroup:insert(setButton)]]--
end

function scene:show(event)
    local sceneGroup = self.view
end

function scene:hide( event )
    local sceneGroup = self.view
end

function scene:destroy( event )
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

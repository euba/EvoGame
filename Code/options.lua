local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleMenuButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("options",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

local function slidePop(event)
    popsize = event.value+20
    --audio.setVolume(mvolume, {channel=1})
end

local function slideFreq(event)
    freq = event.value/100
    freqcur = freq
    --audio.setVolume(svolume, {channel=2})
end

--
-- Start the composer event handlers
--
function scene:create(event)
	local sceneGroup = self.view

    local mbgImage = {type="image", filename="Background_brighter.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    local lang = display.newText({
        text = langtexts[langset][7],     
        x = display.contentCenterX,
        y = display.contentCenterY-display.actualContentHeight/2.5,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    sceneGroup:insert(lang)
    lang:setFillColor(0)

    local english = display.newImage('english.png')
    english:scale(0.3,0.3)
    english.x = display.contentWidth*(1/4)+50
    english.y = display.contentCenterY-display.actualContentHeight/4
    sceneGroup:insert(english)
    local german = display.newImage('german.png')
    german:scale(0.3,0.3)
    german.x = display.contentWidth*(3/4)-50
    german.y = display.contentCenterY-display.actualContentHeight/4
    sceneGroup:insert(german)
    if(langset == 1) then
        english.strokeWidth = 15
        english:setStrokeColor(0,0,1)
    end
    if(langset == 2) then
        german.strokeWidth = 15
        german:setStrokeColor(0,0,1)
    end

    local psize = display.newText({
        text = langtexts[langset][8],     
        x = display.contentCenterX,
        y = display.contentCenterY-display.actualContentHeight/10,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    local slidep = widget.newSlider({x=display.contentCenterX,y=display.contentCenterY,width=250,value=popsize-20,listener=slidePop})
    sceneGroup:insert(psize)
    sceneGroup:insert(slidep)
    psize:setFillColor(0)

    local fsize = display.newText({
        text = langtexts[langset][9],     
        x = display.contentCenterX,
        y = display.contentCenterY+display.actualContentHeight/10,
        width = display.contentWidth-20,
        font = "CP.ttf",   
        fontSize = texs,
        align = "center"
    })
    local slidef = widget.newSlider({x=display.contentCenterX,y=display.contentCenterY+display.actualContentHeight/5,width=250,value=freq*100,listener=slideFreq})
    sceneGroup:insert(fsize)
    sceneGroup:insert(slidef)
    fsize:setFillColor(0)

    local function onTouch(event)
        if(event.phase == "began") then
            langset = 1
            english.strokeWidth = 15
            english:setStrokeColor(0,0,1)
            german.strokeWidth = 0
            psize.text = langtexts[langset][8]
            fsize.text = langtexts[langset][9]
            lang.text = langtexts[langset][7]
        end
        return true
    end
    english:addEventListener("touch", onTouch)
    local function onTouch(event)
        if(event.phase == "began") then
            audio.play(click,{channel=2})
            langset = 2
            german.strokeWidth = 15
            german:setStrokeColor(0,0,1)
            english.strokeWidth = 0
            psize.text = langtexts[langset][8]
            fsize.text = langtexts[langset][9]
            lang.text = langtexts[langset][7]
        end
        return true
    end
    german:addEventListener("touch", onTouch)


    local menuButton = widget.newButton({
        label = "Menu",
        defaultFile = "button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,0,0,1}, over={1,1,1,1}},
        onEvent = handleMenuButtonEvent
    })

    menuButton.x = display.contentCenterX
    menuButton.y = display.contentCenterY+display.actualContentHeight/5 + menuButton.height*1
    sceneGroup:insert(menuButton)

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

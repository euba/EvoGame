local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("win",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end
local function handleResultButtonEvent(event)
    if ("ended" == event.phase) then
        lbutton = "win"
        composer.removeScene("win",false)
        composer.gotoScene("result", {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
    local sceneGroup = self.view  

    local mbgImage = {type="image", filename="Success.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()


    local myText = display.newText({
        text = langtexts[langset][6], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentWidth/10, 
        width = display.contentWidth-display.actualContentWidth/4,
        font = "CP.ttf", 
        fontSize = texs,
        align = "center"
    })
    myText:setFillColor(0)
    sceneGroup:insert(myText)

    local resultButton = widget.newButton({
        label = langtexts[langset][7],
        defaultFile = "Play_button.png",
        labelXOffset = 0,
        labelYOffset = 0,
        width = display.actualContentWidth/4,
        height = display.actualContentHeight/8,
        fontSize = bots,
        font = "CP.ttf",
        labelColor = {default={1,1,1,1}, over={1,0,0,1}},
        onEvent = handleResultButtonEvent
    })
    resultButton.x = display.contentCenterX
    resultButton.y = display.contentCenterY+display.actualContentHeight/4
    sceneGroup:insert(resultButton)

    --[[local homeButton = widget.newButton({
        defaultFile = "Home.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleHomeButtonEvent
    })
    homeButton:scale(0.03,0.03)
    homeButton.x = display.contentWidth*(11/12)
    homeButton.y = display.contentCenterY+display.actualContentHeight/3
    sceneGroup:insert(homeButton)]]--
end

function scene:show(event)
    local sceneGroup = self.view
end

function scene:hide( event )
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

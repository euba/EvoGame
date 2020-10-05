local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("gameover",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
    local sceneGroup = self.view  

    local mbgImage = {type="image", filename="FailDeadBird.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()


    local myText = display.newText({
        text = langtexts[langset][13], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentWidth/10, 
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = texs,
        align = "center"
    })
    myText:setFillColor( 1, 0, 0.5 )
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

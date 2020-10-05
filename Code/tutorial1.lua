local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleFwdButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("tutorial1",false)
        composer.gotoScene("tutorial2", {effect = "crossFade", time = 500})
    end
end

local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("tutorial1",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
    abcam = math.ceil(popsize*(1-freq))
    abmim = math.ceil((popsize*freq)*(1-freqapo))
    abapo = math.ceil((popsize*freq)*(freqapo))

	local sceneGroup = self.view

    local mbgImage = {type="image", filename="whatsthegoal.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()


    local myText = display.newText({
        text = langtexts[langset][3], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentWidth/20, 
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = texs,
        align = "center"
    })
    myText:setFillColor(0)
    sceneGroup:insert(myText)

    butprof = display.newImage("Butterfly_profile.png")
    butprof.strokeWidth = 0
    butprof:setStrokeColor(0,0,0)
    butprof.x = display.contentCenterX
    butprof.y = display.contentCenterY+display.contentHeight*0.05
    local scalefac = (display.contentWidth*0.2)/butprof.width
    butprof:scale(scalefac,scalefac)
    sceneGroup:insert(butprof)

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
        defaultFile = "Forward.png",
        labelXOffset = 0,
        labelYOffset = 0,
        onEvent = handleFwdButtonEvent
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
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene

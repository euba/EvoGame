local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local function handleGoButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("tutorial2",false)
        composer.gotoScene("go", {effect = "crossFade", time = 500})
    end
end

local function handleHomeButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("result",false)
        composer.gotoScene("menu", {effect = "crossFade", time = 500})
    end
end

local function handleBackButtonEvent(event)
    if ("ended" == event.phase) then
        composer.removeScene("result",false)
        composer.gotoScene(lbutton, {effect = "crossFade", time = 500})
    end
end

--
-- Start the composer event handlers
--
function scene:create(event)
	local sceneGroup = self.view

    cam = display.newImage(images[1])
    cam.strokeWidth = 0
    cam:setStrokeColor(0,0,0)
    cam.x = display.contentCenterX-display.contentWidth*(1/5)
    cam.y = display.contentCenterY-display.contentHeight*0.37
    cam:scale(0.2,0.2)
    sceneGroup:insert(cam)

    mim = display.newImage(images[2])
    mim.strokeWidth = 0
    mim:setStrokeColor(0,0,0)
    mim.x = display.contentCenterX
    mim.y = display.contentCenterY-display.contentHeight*0.37
    mim:scale(0.2,0.2)
    sceneGroup:insert(mim)

    for i=1,#gens do
        local tnum = display.newText({
            text = "t"..(i-1)..":", 
            x = display.contentCenterX-display.contentWidth*(1/3), 
            y = (display.contentCenterY-display.contentHeight*0.35)+display.contentHeight*0.08*i, 
            font = "CP.ttf", 
            fontSize = rtexs,
            align = "center"
        })
        tnum:setFillColor(0)
        sceneGroup:insert(tnum)

        local camnum = display.newText({
            text = gens[i][1], 
            x = display.contentCenterX-display.contentWidth*(1/5), 
            y = (display.contentCenterY-display.contentHeight*0.35)+display.contentHeight*0.08*i, 
            font = "CP.ttf", 
            fontSize = rtexs,
            align = "center"
        })
        camnum:setFillColor(0)
        sceneGroup:insert(camnum)

        local mimnum = display.newText({
            text = gens[i][2], 
            x = display.contentCenterX, 
            y = (display.contentCenterY-display.contentHeight*0.35)+display.contentHeight*0.08*i, 
            font = "CP.ttf", 
            fontSize = rtexs,
            align = "center"
        })
        mimnum:setFillColor(0)
        sceneGroup:insert(mimnum)
    end

    if(curlvl == 1) then
        local mbgImage = {type="image", filename="OptionsParamilloForest.png"} 
        local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
        mbackground.x = display.contentCenterX
        mbackground.y = display.contentCenterY
        mbackground.fill = mbgImage
        sceneGroup:insert(mbackground)
        mbackground:toBack()
    else
        local mbgImage = {type="image", filename="OptionsTiniguaForest.png"} 
        local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
        mbackground.x = display.contentCenterX
        mbackground.y = display.contentCenterY
        mbackground.fill = mbgImage
        sceneGroup:insert(mbackground)
        mbackground:toBack()

        apo = display.newImage(images[3])
        apo.strokeWidth = 0
        apo:setStrokeColor(0,0,0)
        apo.x = display.contentCenterX+display.contentWidth*(1/5)
        apo.y = display.contentCenterY-display.contentHeight*0.37
        apo:scale(0.2,0.2)
        sceneGroup:insert(apo)

        for i=1,#gens do
            local aponum = display.newText({
                text = gens[i][3], 
                x = display.contentCenterX+display.contentWidth*(1/5), 
                y = (display.contentCenterY-display.contentHeight*0.35)+display.contentHeight*0.08*i, 
                font = "CP.ttf", 
                fontSize = rtexs,
                align = "center"
            })
            aponum:setFillColor(0)
            sceneGroup:insert(aponum)
        end
    end


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
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene

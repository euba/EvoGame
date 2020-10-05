local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

--
-- Start the composer event handlers
--
function scene:create(event)
	local sceneGroup = self.view

    local mbgImage = {type="image", filename="Reproducing.png"} 
    local mbackground = display.newRect(0,0,display.contentWidth,display.actualContentHeight)
    mbackground.x = display.contentCenterX
    mbackground.y = display.contentCenterY
    mbackground.fill = mbgImage
    sceneGroup:insert(mbackground)
    mbackground:toBack()

    local myText = display.newText({
        text = langtexts[langset][4], 
        x = display.contentCenterX, 
        y = display.contentCenterY-display.actualContentHeight/10, 
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = texs,
        align = "center"
    })
    myText:setFillColor(0,0,0)
    sceneGroup:insert(myText)

    secondsLeft = gentime
    local clockText = display.newText({
        text = secondsLeft,
        x = display.contentCenterX,
        y = display.contentCenterY+display.actualContentHeight/5,
        width = display.contentWidth-display.actualContentWidth/10,
        font = "CP.ttf", 
        fontSize = bots*2,
        align = "center"
    })
    clockText:setFillColor(1,0,0)
    sceneGroup:insert(clockText)

    local function updateTime()
        if(clockText~=nil) then
            secondsLeft = secondsLeft - 1 
            local timeDisplay = string.format(secondsLeft)
            clockText.text = timeDisplay
            timer.performWithDelay(500, function()
                if(clockText~=nil) then
                    clockText:setFillColor(1)
                end
            end,1)
            timer.performWithDelay(1000, function()
                if(clockText~=nil) then
                    clockText:setFillColor(1,0,0)
                end
            end,1)
            if(secondsLeft == 0) then
                composer.removeScene("go",false)
                composer.gotoScene("game", {effect = "crossFade", time = 500})
            end
        end
    end

    timer.performWithDelay(500, function()
        clockText:setFillColor(1)
    end,1)
    timer.performWithDelay(1000, function()
        clockText:setFillColor(1,0,0)
    end,1)
    local countDownTimer = timer.performWithDelay(1000,updateTime,secondsLeft)

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

--[[application =
{

	content =
	{
		width = 320,
		height = 480, 
		scale = "letterBox",
		fps = 30,
		
		imageSuffix =
		{
			    ["@2x"] = 2,
		},
	},

	-- Push notifications
	notification =
	{
		iphone =
		{
			types =
			{
				"badge", "sound", "alert", "newsstand"
			}
		}
	},  
}  --]]


application = 
{
    content = 
    {	width = 320,
		height = 480,
        scale = "adjusted", --zoomStretch,zoomEven, adjusted
        xAlign = "center",
        yAlign = "center",
        fps = 60,

    }
}
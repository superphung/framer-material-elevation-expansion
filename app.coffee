
background = new BackgroundLayer
	backgroundColor: "#eeeeee"

layers = []

for l in [0...30]
	layer = new Layer
		width: Framer.Device.screen.width
		backgroundColor: "#ffffff"
		shadowSpread: 1
		shadowColor: "#rgba(0,0,0, .25)"
	layer.y = l * 100
	layer.originalFrame = layer.frame
	layer.index = 1
	layers.push layer

circle = new Layer
	borderRadius: "50%"
	backgroundColor: "#dddddd"
	opacity: 0
	
handler = (event, layer) ->
	circle.scale = 0
	circle.opacity = 1
	circle.superLayer = layer
	circle.midX = event.offsetX
	circle.midY = event.offsetY	
	
	circle.animate
			properties:
				scale: 30
				opacity: 0
			curve: "ease-out"
			time: .5
	
	if layer.index == 1
		layer.index = 2
		layer.animate
			properties:
				shadowSpread: 2
				shadowBlur: 2
			time: .2
		Utils.delay 0.2, () ->
			layer.animate
				properties:
					y: 0
					height: Framer.Device.screen.height
				time: .3
	else
		layer.animate
			properties:
				y: layer.originalFrame.y
				height: 100
			time: .8
		Utils.delay 0.8, () ->
			layer.animate
				properties:
					shadowSpread: 1
					shadowBlur: 0
					index: 1
				time: .2

for l in [0...30]
	layers[l].on Events.Click, handler
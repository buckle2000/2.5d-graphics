local canvas = love.graphics.newCanvas()
canvas:setFilter('nearest','nearest')
love.graphics.setDefaultFilter('nearest', 'nearest')
local img_chair = love.graphics.newImage("chair.png")
local sw, sh = img_chair:getDimensions()
-- local batch = love.graphics.newSpriteBatch(img_chair)
local quads = {}
local angle = 0.0
SCALE = 0.5

for i=0,63 do
	table.insert(quads, love.graphics.newQuad(i*32, 0, 32, 32, sw, sh))
end

-- local shader = love.graphics.newShader("2.5d.glsl")

function love.update(dt)
	if love.keyboard.isDown('left') then
		angle = angle - 0.03
	end
	if love.keyboard.isDown('right') then
		angle = angle + 0.03
	end
end

local objs

local function clear()
	objs = {}
end

local sin, cos = math.sin, math.cos

local function draw_chair(x, y)
	x, y = x*cos(angle)-y*sin(angle), x*sin(angle)+y*cos(angle)
	table.insert(objs, {x, y})
end

-- local function round(n)
-- 	return math.floor(n+0.5)
-- end

round = function (n) return n end

local function draw()
	table.sort(objs, function (a,b) return a[2]<b[2] end)
	for _,obj in ipairs(objs) do
		for i=1,64 do
			love.graphics.draw(img_chair, quads[i], round(obj[1]), round(obj[2])+(1-i)/SCALE, angle, nil, nil, 16, 16)
		end
	end
end

function love.draw()
	-- love.graphics.setCanvas(canvas)
	-- love.graphics.clear()
	-- love.graphics.push()
	love.graphics.setShader(shader)
	love.graphics.translate(400, 300)
	love.graphics.scale(1, SCALE)
	clear()
	for row=-1,1 do
		for col=-1,1 do
			draw_chair(row*40, col*40)
		end
	end
	draw()
	-- love.graphics.pop()
	-- love.graphics.setCanvas()
	-- love.graphics.draw(canvas)
end

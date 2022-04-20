local MonBackColor = colors.black
local MonColor = colors.white
local zOffset = -4

function peripheralConnect(name)
    per = peripheral.find(name)
    assert(per ~= nil, 'Unable to find '..name)
    print('Sucessfully connected to '..name ..'!')
    return per
end

function initMon(mon)
    mon.setTextScale(0.5)
    mon.setTextColor(MonColor)
    mon.setBackgroundColor(MonBackColor)
    mon.setCursorBlink(false)
    mon.clear()
end

function drawMon(mon, p)
    mon.setBackgroundColor(MonColor)
    mon.setCursorPos(p.x, p.y)
    mon.write(' ')
end

function lerp(start, finish, t)
    return start + t * (finish - start)
end

function lerpPoint(p1, p2, t)
    return {x=lerp(p1.x, p2.x, t), y=lerp(p1.y, p2.y, t)}
end

function roundPoint(p)
    return {x=math.floor(p.x+0.5), y=math.floor(p.y+0.5)}
end

function drawLine(mon, p1, p2)
    mon.setBackgroundColor(MonColor)
    -- Calculate the diagonal distance
    local N = math.max(math.abs(p1.x-p2.x), math.abs(p1.y-p2.y))

    -- Draw points on screen
    local i = 0
    while i <= N do
        local t
        if N == 0 then t = 0 else t = i / N end
        drawMon(mon, roundPoint(lerpPoint(p1, p2, t)))
        i = i + 1
    end
end

function rotate3D(points, angle)
    local newPoints = {}
    for _, point in pairs(points) do
        newPoint = {x=point.x*math.cos(angle)-point.z*math.sin(angle),
                    y=point.y,
                    z=point.x*math.sin(angle)+point.z*math.cos(angle)}
        table.insert(newPoints, newPoint)
    end
    return newPoints
end


function getPoints2D(points3D)
    local points2D = {}
    for _, point in pairs(points3D) do
        table.insert(points2D, {x=point.x/(point.z+zOffset), y=point.y/(point.z+zOffset)})
    end
    return points2D
end

function scaleCenterPoints(points, scale, maxX, maxY)
    local newPoints = {}
    for _, point in pairs(points) do
        table.insert(newPoints, {x=scale*point.x + math.floor(maxX/2 + 0.5),
                                 y=(2/3)*scale*point.y + math.floor(maxY/2 + 0.5)})
    end
    return newPoints
end

local Mon = peripheralConnect('monitor')
initMon(Mon)
local MaxX, MaxY = Mon.getSize()

local origPoints = {
    {x=1, y=1, z=1},{x=1, y=-1, z=1},{x=-1, y=-1, z=1}, {x=-1,y=1,z=1},
    {x=1, y=1, z=-1},{x=1, y=-1, z=-1},{x=-1, y=-1, z=-1}, {x=-1,y=1,z=-1}
}

while true do
    initMon(Mon)
    local screenPoints = {}
    for _, point in pairs(scaleCenterPoints(getPoints2D(origPoints), 40, MaxX, MaxY)) do
        table.insert(screenPoints, point)
    end

    drawLine(Mon, screenPoints[1], screenPoints[2])
    drawLine(Mon, screenPoints[1], screenPoints[4])
    drawLine(Mon, screenPoints[1], screenPoints[5])
    drawLine(Mon, screenPoints[2], screenPoints[3])
    drawLine(Mon, screenPoints[2], screenPoints[6])
    drawLine(Mon, screenPoints[3], screenPoints[7])
    drawLine(Mon, screenPoints[3], screenPoints[4])
    drawLine(Mon, screenPoints[4], screenPoints[8])
    drawLine(Mon, screenPoints[5], screenPoints[8])
    drawLine(Mon, screenPoints[5], screenPoints[6])
    drawLine(Mon, screenPoints[6], screenPoints[7])
    drawLine(Mon, screenPoints[7], screenPoints[8])

    origPoints = rotate3D(origPoints, math.pi/64)
    sleep(0.05)
end
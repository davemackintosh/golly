-- golly
displayMode(FULLSCREEN)

-- Use this function to perform your initial setup
function setup()
    parameter.color("DeadCellColour", color(189, 98, 98, 255))
    parameter.color("AliveCellColour", color(255, 255, 255, 255))
    parameter.color("Background", color(20, 20, 20, 255))
    parameter.boolean("Play")
    parameter.action("Next Generation", function () gol:calculate() end)
    
    size = 28
    gol  = Gol(WIDTH / size, HEIGHT / size)

    parameter.watch("gol._generations")

    gol.drawMethod = function (cell)
        wid = WIDTH / size
        hei = HEIGHT / size
    
        if cell.s == gol._alive then
            fill(AliveCellColour)
        else
            fill(DeadCellColour)
        end
        rect(size * (cell.x - 1), size * cell.y, size, size)
    end
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(Background)

    -- If we've paused, stop calculating
    if Play then
        gol:calculate()
    end
    
    -- Always draw
    gol:draw()
end

function touched(t)
    gol:touched(t)
end
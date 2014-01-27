Gol = class()

function Gol:init(W, H)
    -- Set the size
    self.columns  = W
    self.rows     = H
    
    -- The varying states of cells
    self._alive    = 1
    self._dead     = 0
    
    -- The game states
    self._generations = 0
    
    -- Some public things
    self.matrix    = {}
    
    -- This is a method to set for a draw method
    -- Called for every cell, every frame
    self.drawMethod = function(cell) end
    
    -- Create a blank board
    self:create()
end

function Gol:create()
    for r = 1, self.rows do
        table.insert(self.matrix, {})
        for c = 1, self.columns do
            table.insert(self.matrix[r], {})
            self.matrix[r][c] = self._dead
        end
    end
end

function Gol:clear()
    for r = 1, self.rows do
        for c = 1, self.columns do
            self.matrix[r][c] = self._dead
        end
    end
end

function Gol:alive(c, r)
    if self.matrix[r][c] == self._alive then
        return true
    end
    
    return false
end

function Gol:dead(c, r)
    if self.matrix[r][c] == self._dead then
        return true
    end
    
    return false
end

function Gol:calculate()
    local n    = 0
    local tab  = self.matrix
    local alive
    local dead
    
    -- Neighbour positions from the current index
    local nbrs = {
        {-1,-1},
        {-1,0},
        {-1,1},
        {0,-1},
        {0,1},
        {1,-1},
        {1,0},
        {1,1}
    }
    
    for r = 2, self.rows - 1 do
        for c = 2, self.columns - 1 do
            n = 0
            alive = self:alive(c, r)
            --dead  = self:dead(c, r)
            
            -- How many neighbours does this cell have?
            for _,a in ipairs(nbrs) do
                if self:alive(c + a[2], r + a[1]) then
                    n = n + 1
                end
            end

            -- Kill or live
            if alive then
                if n < 2 or n > 3 then
                    tab[r][c] = self._dead
                end
            else
                if n == 3 then
                    tab[r][c] = self._alive
                end
            end
            
            
            --[[if alive and n < 2 then
                tab[r][c] = self._dead
            elseif alive and (n == 2 or n == 3) then
                tab[r][c] = self._alive
            elseif alive and n >= 3 then
                tab[r][c] = self._dead
            elseif dead and n == 3 then
                tab[r][c] = self._alive
            end
            ]]--
           
        end
    end
    self._generations = self._generations + 1
end

function Gol:draw()
    for r = 1, self.rows do
        for c = 1, self.columns do
            self.drawMethod({
                x = c,
                y = r,
                s = self.matrix[r][c]
            })
        end
    end
end

function round(number)
    local n = number % 1
    
    if n >= .5 then
        return math.ceil(number)
    else
        return math.floor(number)
    end
end

function Gol:touched(touch)
    local x = round(touch.x / (WIDTH / self.columns))
    local y = round(touch.y / (HEIGHT / self.rows))
    
    self.matrix[y][x] = self._alive
end

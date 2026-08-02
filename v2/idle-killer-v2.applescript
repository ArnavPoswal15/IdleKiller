-- IdleKiller V2 - Organic Movement
-- Simulates curved, human-like mouse movement
-- Press Cmd+Q to stop

global rand
set rand to current date

on randomNumber(min, max)
    return (random number from min to max)
end randomNumber

on organicMove(targetX, targetY, steps)
    tell application "System Events"
        set currentPos to (current location of (mouse))
        set startX to (item 1 of currentPos)
        set startY to (item 2 of currentPos)
        set dx to targetX - startX
        set dy to targetY - startY
        
        repeat with i from 1 to steps
            set progress to i / steps
            
            -- Base position
            set baseX to startX + (dx * progress)
            set baseY to startY + (dy * progress)
            
            -- Add gentle curve
            set curveOffset to (sin (progress * pi)) * (randomNumber(-15, 16))
            set randomOffsetX to (randomNumber(-5, 6)) * (1 - progress)
            set randomOffsetY to (randomNumber(-5, 6)) * (1 - progress)
            
            set newX to (baseX + curveOffset + randomOffsetX) as integer
            set newY to (baseY + (curveOffset * 0.6) + randomOffsetY) as integer
            
            set mouse location to {newX, newY}
            delay 0.02 -- 20ms (SAME as original)
        end repeat
    end tell
end organicMove

on mouseClick()
    tell application "System Events"
        click at (current location of (mouse))
    end tell
end mouseClick

-- Main loop
repeat
    tell application "System Events"
        set currentPos to (current location of (mouse))
        set startX to (item 1 of currentPos)
        set startY to (item 2 of currentPos)
        
        -- Random movement (SAME: -80 to 80)
        set dx to randomNumber(-80, 80)
        set dy to randomNumber(-80, 80)
        set targetX to startX + dx
        set targetY to startY + dy
        
        -- Forward movement (25 steps, 20ms each)
        organicMove(targetX, targetY, 25)
        
        -- Random click (40% chance)
        if randomNumber(1, 100) ≤ 40 then
            delay (randomNumber(0.2, 0.6))
            click at (current location of (mouse))
            delay 0.06 -- 60ms (SAME as original)
        end if
        
        delay 0.3 -- 300ms (SAME as original)
        
        -- Return movement (25 steps, 20ms each)
        set currentPos to (current location of (mouse))
        set currentX to (item 1 of currentPos)
        set currentY to (item 2 of currentPos)
        organicMove(startX, startY, 25)
        
        -- Random idle (10-20 sec)
        delay randomNumber(10, 20)
    end tell
end repeat

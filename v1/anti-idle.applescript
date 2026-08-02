-- Anti-Idle Script for macOS
-- Simulates human mouse movement + random clicks
-- Press Cmd+Q to stop

global rand
set rand to current date

on randomNumber(min, max)
    return (random number from min to max)
end randomNumber

on mouseMove(x, y)
    tell application "System Events"
        set currentPos to (current location of (mouse))
        set newPos to {x, y}
        -- Smooth movement using steps
        repeat with i from 1 to 25
            set stepX to (item 1 of currentPos) + ((x - (item 1 of currentPos)) * i / 25)
            set stepY to (item 2 of currentPos) + ((y - (item 2 of currentPos)) * i / 25)
            set mouse location to {stepX as integer, stepY as integer}
            delay 0.02
        end repeat
    end tell
end mouseMove

on mouseClick()
    tell application "System Events"
        click at (current location of (mouse))
    end tell
end mouseClick

-- Main loop
repeat
    tell application "System Events"
        set currentPos to (current location of (mouse))
        set x to (item 1 of currentPos)
        set y to (item 2 of currentPos)
        
        -- Random movement (-80 to +80 pixels)
        set dx to randomNumber(-80, 80)
        set dy to randomNumber(-80, 80)
        set targetX to x + dx
        set targetY to y + dy
        
        -- Smooth move to target
        repeat with i from 1 to 25
            set stepX to x + ((targetX - x) * i / 25)
            set stepY to y + ((targetY - y) * i / 25)
            set mouse location to {stepX as integer, stepY as integer}
            delay 0.02
        end repeat
        
        -- Random click (40% chance)
        if randomNumber(1, 100) ≤ 40 then
            delay (randomNumber(0.2, 0.6))
            click at (current location of (mouse))
        end if
        
        delay 0.3
        
        -- Smooth return to original position
        repeat with i from 1 to 25
            set stepX to targetX + ((x - targetX) * i / 25)
            set stepY to targetY + ((y - targetY) * i / 25)
            set mouse location to {stepX as integer, stepY as integer}
            delay 0.02
        end repeat
        
        -- Random idle (10-20 seconds)
        delay randomNumber(10, 20)
    end tell
end repeat

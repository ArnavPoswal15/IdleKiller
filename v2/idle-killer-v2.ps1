Add-Type -AssemblyName System.Windows.Forms

# Import mouse click API
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Mouse {
    [DllImport("user32.dll", CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);

    public const int LEFTDOWN = 0x02;
    public const int LEFTUP   = 0x04;
}
"@

Write-Host "Started. Organic movement + random clicks."
Write-Host "Press Ctrl+C to stop."

$rand = New-Object System.Random

while ($true) {

    # Current position
    $start = [System.Windows.Forms.Cursor]::Position
    $startX = $start.X
    $startY = $start.Y

    # Random movement distance (EXACT same as original: -80 to 80)
    $dx = $rand.Next(-80, 81)
    $dy = $rand.Next(-80, 81)

    $targetX = $startX + $dx
    $targetY = $startY + $dy

    $steps = 25  # EXACT same as original

    # ---- FORWARD MOVEMENT (EXACT same speed as original) ----
    for ($i = 1; $i -le $steps; $i++) {

        $progress = $i / $steps

        # Base position (straight line)
        $baseX = $startX + ($dx * $progress)
        $baseY = $startY + ($dy * $progress)

        # Add gentle curve (subtle, not jerky)
        $curveOffset = [Math]::Sin($progress * [Math]::PI) * $rand.Next(-15, 16)

        $x = [int]($baseX + $curveOffset)
        $y = [int]($baseY + ($curveOffset * 0.6))

        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)

        # EXACT same delay as original: 20ms
        Start-Sleep -Milliseconds 20
    }

    # ---- RANDOM CLICK (40% chance - EXACT same as original) ----
    if ($rand.Next(1, 101) -le 40) {

        Start-Sleep -Milliseconds ($rand.Next(200, 600))

        [Mouse]::mouse_event([Mouse]::LEFTDOWN, 0, 0, 0, 0)
        Start-Sleep -Milliseconds 60  # EXACT same as original
        [Mouse]::mouse_event([Mouse]::LEFTUP, 0, 0, 0, 0)
    }

    # EXACT same pause as original
    Start-Sleep -Milliseconds 300

    # ---- RETURN MOVEMENT (EXACT same speed as original) ----
    for ($i = 1; $i -le $steps; $i++) {

        $progress = $i / $steps

        $baseX = $targetX + (($startX - $targetX) * $progress)
        $baseY = $targetY + (($startY - $targetY) * $progress)

        # Add gentle curve on return
        $curveOffset = [Math]::Sin($progress * [Math]::PI) * $rand.Next(-12, 13)

        $x = [int]($baseX + $curveOffset)
        $y = [int]($baseY + ($curveOffset * 0.5))

        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)

        # EXACT same delay as original: 20ms
        Start-Sleep -Milliseconds 20
    }

    # EXACT same idle time as original: 10-20 seconds
    Start-Sleep -Seconds ($rand.Next(10, 21))
}

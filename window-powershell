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

Write-Host "Started. Smooth movement + random clicks."
Write-Host "Press Ctrl+C to stop."

$rand = New-Object System.Random

while ($true) {

    # Current position
    $start = [System.Windows.Forms.Cursor]::Position

    # Random movement distance
    $dx = $rand.Next(-80, 81)
    $dy = $rand.Next(-80, 81)

    $targetX = $start.X + $dx
    $targetY = $start.Y + $dy

    $steps = 25

    # Smooth move forward
    for ($i = 1; $i -le $steps; $i++) {

        $x = $start.X + (($targetX - $start.X) * $i / $steps)
        $y = $start.Y + (($targetY - $start.Y) * $i / $steps)

        [System.Windows.Forms.Cursor]::Position =
            New-Object System.Drawing.Point([int]$x, [int]$y)

        Start-Sleep -Milliseconds 20
    }

    # ---- RANDOM CLICK (40% chance) ----
    if ($rand.Next(1,101) -le 40) {

        Start-Sleep -Milliseconds ($rand.Next(200,600))

        [Mouse]::mouse_event([Mouse]::LEFTDOWN,0,0,0,0)
        Start-Sleep -Milliseconds 60
        [Mouse]::mouse_event([Mouse]::LEFTUP,0,0,0,0)
    }

    Start-Sleep -Milliseconds 300

    # Smooth return
    for ($i = 1; $i -le $steps; $i++) {

        $x = $targetX + (($start.X - $targetX) * $i / $steps)
        $y = $targetY + (($start.Y - $targetY) * $i / $steps)

        [System.Windows.Forms.Cursor]::Position =
            New-Object System.Drawing.Point([int]$x, [int]$y)

        Start-Sleep -Milliseconds 20
    }

    # Random idle time (10–20 sec)
    Start-Sleep -Seconds ($rand.Next(10,21))
}

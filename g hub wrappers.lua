local LOGLEVEL = "normal"
local SLEEP_NORMAL = 50
local SLEEP_DEBUG = 1500
local OVERRIDE_SHORTCIRCUIT = false

function OnEvent(event, arg)
    -- the mouse descriptions below are for the G502X, and may be different depending on the model of your mouse
    if (event == "MOUSE_BUTTON_PRESSED") then
        if      (arg == 1) then

        elseif  (arg == 10) then -- top left auxiliary far down

        elseif  (arg == 11) then -- top left auxiliary near down

        elseif  (arg == 7) then -- wheel tilt left

        elseif  (arg == 3) then -- wheel main down

        elseif  (arg == 9) then -- wheel auxiliary down

        elseif  (arg == 8) then -- wheel tilt right

        elseif  (arg == 2) then -- right mouse button down

        elseif  (arg == 4) then -- thumb near down

        elseif  (arg == 6) then -- thumb middle down

        elseif  (arg == 5) then -- thumb far down

        end
    end
    if (event == "MOUSE_BUTTON_RELEASED") then
        if      (arg == 1) then

        elseif  (arg == 10) then -- top left auxiliary far down

        elseif  (arg == 11) then -- top left auxiliary near down

        elseif  (arg == 7) then -- wheel tilt left

        elseif  (arg == 3) then -- wheel main down

        elseif  (arg == 9) then -- wheel auxiliary down

        elseif  (arg == 8) then -- wheel tilt right

        elseif  (arg == 2) then -- right mouse button down

        elseif  (arg == 4) then -- thumb near down

        elseif  (arg == 6) then -- thumb middle down

        elseif  (arg == 5) then -- thumb far down

        end
    end
end

--- Converts any Lua value into a human-readable string representation.
--- This function can handle tables, nested tables, and basic data types.
--- It is particularly useful for debugging, allowing developers to print
--- out the contents of tables and other variables.
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

--- Awaits the Ctrl key press before executing the given function.
--- Holding the Ctrl+Shift keys simultaneously will short-circuit the function.
--- @param message string The message to print.
function await_ctrlprk(message)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    print(message)
    control_pressed = false
    control_released = false

    while control_pressed == false do
        if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

        if iIsModifierPressed("ctrl") then
            control_pressed = true
        end
    end
    Sleep(25)
    while control_released == false do
        if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

        if iIsModifierPressed("ctrl") == false then
            control_released = true 
        end
    end
end

--- Outputs a message to the log if the log level is set to "debug" or "normal".
--- @param message string|table The message to be printed.
---
--- Remarks:
--- This function checks if the log level is set to "debug" or "normal". If the log level matches any of these, it prints the message to the log. If the message is a table, it uses the dump function to convert it to a string before printing.
---
--- Example:
--- > ```lua
--- > -- Print a message
--- > print("Hello, world!")
--- > ```
function print(message)
    if LOGLEVEL == "debug" or LOGLEVEL == "normal" then
        local message_type = type(message)
        if message_type == "table" then
            iOutputLogMessage("" .. dump(message) .. "\n")
        else
            iOutputLogMessage("" .. message .. "\n")
        end
    end
end

--- Pauses execution for a specified time if the log level is set to "debug".
---
--- Remarks:
--- This function pauses execution for a specified time if the log level is set to "debug". The duration of the pause is determined by the value of the SLEEP_DEBUG constant. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Pause execution for debugging
--- > dbg()
--- > ```
function dbg()
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    if LOGLEVEL == "debug" then
        iSleep(SLEEP_DEBUG)
    end
end

--- Pauses execution for a specified time based on the log level.
---
--- Remarks:
--- This function pauses execution for a specified time based on the log level. If the log level is set to "debug", it pauses for the duration specified by the SLEEP_DEBUG constant; otherwise, it pauses for the duration specified by the SLEEP_NORMAL constant. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Pause execution
--- > slp()
--- > ```
function slp(period)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end
    
    period = default(period,SLEEP_NORMAL)

    if LOGLEVEL == "debug" then
        iSleep(SLEEP_DEBUG)
    else
        iSleep(SLEEP_NORMAL)
    end
end

--- Pauses execution for a long duration based on the log level.
---
--- Remarks:
--- This function pauses execution for a long duration based on the log level. If the log level is set to "debug", it pauses for the duration specified by the SLEEP_DEBUG constant; otherwise, it pauses for 250 milliseconds. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Pause execution for a long duration
--- > longslp()
--- > ```
function longslp()
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    if LOGLEVEL == "debug" then
        iSleep(SLEEP_DEBUG)
    else
        iSleep(250)
    end
end

--- Simulates pressing and releasing a specified keyboard key.
--- @param key string|integer The key to be pressed and released.
---
--- Remarks:
--- This function simulates pressing and releasing the specified keyboard key using the iPressAndReleaseKey function. It also pauses briefly after the key press. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Press and release the 'A' key
--- > prk("a")
--- > ```
function prk(key)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iPressAndReleaseKey(key)
    slp()
end

--- Simulates pressing a specified keyboard key.
--- @param key string|integer The key to be pressed.
---
--- Remarks:
--- This function simulates pressing the specified keyboard key using the iPressKey function. It also pauses briefly after the key press. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Press the 'A' key
--- > pk("a")
--- > ```
function pk(key)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iPressKey(key)
    slp()
end

--- Releases a specified keyboard key.
--- @param key string|integer The key to be released.
---
--- Remarks:
--- This function releases the specified keyboard key using the ReleaseKey function. It also pauses briefly after the key release. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Release the 'A' key
--- > rk("a")
--- > ```
function rk(key)
    ReleaseKey(key)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    slp()
end

--- Moves the mouse cursor to an absolute position on a multi-monitor screen layout.
--- @param xcoord number The normalized X coordinate between 0 (farthest left) and 65535 (farthest right).
--- @param ycoord number The normalized Y coordinate between 0 (farthest top) and 65535 (farthest bottom).
---
--- Remarks:
--- This function moves the mouse cursor to the specified absolute position on a multi-monitor screen layout using the MoveMouseToVirtual function. It also pauses briefly after the movement. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Move the mouse cursor to the upper-left corner of the virtual desktop
--- > mmtv(0, 0)
--- > ```
function mmtv(xcoord,ycoord)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    x,y = iGetMousePosition()
    iMoveMouseToVirtual(x,y)
    iSleep(5)

    iMoveMouseToVirtual(xcoord,ycoord)
end

--- Moves the mouse cursor to a relative position.
--- @param xcoord number The movement along the x-axis.
--- @param ycoord number The movement along the y-axis.
---
--- Remarks:
--- This function moves the mouse cursor to the specified relative position using the MoveMouseRelative function. It also pauses briefly after the movement. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Move the mouse cursor upwards and to the left
--- > mmt(-10, -10)
--- > ```
function mmt(xcoord,ycoord)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iMoveMouseTo(xcoord+1,ycoord+1)
    iSleep(5)
    iMoveMouseTo(xcoord,ycoord)
end

--- Moves the mouse cursor to a relative position.
--- @param xcoord number The movement along the x-axis.
--- @param ycoord number The movement along the y-axis.
---
--- Remarks:
--- This function moves the mouse cursor to the specified relative position using the MoveMouseRelative function. It also pauses briefly after the movement. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Move the mouse cursor to the right and down
--- > mmr(10, 10)
--- > ```
function mmr(xcoord,ycoord)
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end
    
    iSleep(20)
    iMoveMouseRelative(1,1)
    iMoveMouseRelative(-1,-1)
    iMoveMouseRelative(xcoord,ycoord)

end

--- Simulates pressing and releasing the left mouse button.
---
--- Remarks:
--- This function simulates the press and release of the left mouse button using the PressMouseButton and ReleaseMouseButton functions. It also pauses briefly after each action. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Simulate pressing and releasing the left mouse button
--- > prlmb()
--- > ```
function prlmb()
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iPressMouseButton(1)
    slp()
    iReleaseMouseButton(1)
    slp()
end

--- Simulates pressing and releasing the middle mouse button.
---
--- Remarks:
--- This function simulates the press and release of the middle mouse button using the PressMouseButton and ReleaseMouseButton functions. It also pauses briefly after each action. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Simulate pressing and releasing the middle mouse button
--- > prmmb()
--- > ```
function prmmb()
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iPressMouseButton(2)
    slp()
    iReleaseMouseButton(2)
    slp()
end

--- Simulates pressing and releasing the right mouse button.
---
--- Remarks:
--- This function simulates the press and release of the right mouse button using the PressMouseButton and ReleaseMouseButton functions. It also pauses briefly after each action. Short-circuits if both the Shift and Ctrl keys are pressed simultaneously.
---
--- Example:
--- > ```lua
--- > -- Simulate pressing and releasing the right mouse button
--- > prrmb()
--- > ```
function prrmb()
    if iIsModifierPressed("shift") and iIsModifierPressed("ctrl") and not OVERRIDE_SHORTCIRCUIT then do return end end

    iPressMouseButton(3)
    slp()
    iReleaseMouseButton(3)
    slp()
end

--- Returns the given value unless it is nil, in which case the default value is returned.
function default(value, default_value)
    if value == nil then return default_value end
    return value
end

--- Retrieves the current state of the M keys for the specified device family, defaulting to keyboards.
--- @param family string Optional. The device family name ("kb" for keyboards, "lhc" for left-handed controllers).
--- @return number mkeystate The current M key state (1 = M1, 2 = M2, 3 = M3).
---
--- Remarks:
--- None.
---
--- Example:
--- > ```lua
--- > -- Get the current M key state
--- > local current_mkey = iGetMKeyState()
--- > ```
function iGetMKeyState(family) family = default(family,"kb"); return GetMKeyState(family) end

--- Sets the current state of the M keys for the specified device family, defaulting to keyboards.
--- @param mkey number The M key state to set (1 = M1, 2 = M2, 3 = M3).
--- @param family string Optional. The device family name ("kb" for keyboards, "lhc" for left-handed controllers).
--- @return nil
---
--- Remarks:
--- NOTE: Immediately calling GetMKeyState afterwards may return the previous state. Use OnEvent to confirm completion.
---
--- Example:
--- > ```lua
--- > -- Set the current M Key state to M1 when G1 is pressed
--- > function OnEvent(event, arg)
--- >     if (event == "G_PRESSED" and arg == 1) then
--- >         iSetMKeyState(1)
--- >     end
--- > end
--- > ```
function iSetMKeyState(mkey,family) family = default(family,"kb"); SetMKeyState(mkey,family) end

--- Pauses the script execution for the specified amount of time, defaulting to 5 milliseconds if not provided.
--- @param timeout integer Optional. The total time to sleep in milliseconds. Defaults to 5ms.
--- @return nil
---
--- Remarks:
--- Scripting runs on a separate thread than the main Profiler, thus pausing the script will not affect it.
--- You can use this function to simulate delays.
--- Deactivation of the profiler will wait 1 second for the script to finish, after which the script will be forcefully aborted. Take precaution if using a long timeout.
---
--- Example:
--- > ```lua
--- > -- Sleeping for 20 milliseconds
--- > Sleep(20)
--- > ```
function iSleep(timeout) timeout = default(timeout,5); Sleep(timeout) end

--- Sends a log message to the script editor's console.
---@param message string Printf-style formatted string containing the message.
---
--- > Example:
--- >
--- > ```lua
--- > iOutputLogMessage("Hello World %d\n", 2007)  -- Send out "Hello World"
--- > ```
function iOutputLogMessage(message) OutputLogMessage(message) end

--- Returns the total number of milliseconds elapsed since the script has been running.
---@return integer elapsed The elapsed time in milliseconds.
--- Example:
--- > ```lua
--- > -- Display the script running time
--- > local runningTime = iGetRunningTime()
--- > OutputLogMessage("This script has been running for: %d ms", runningTime)
--- > ```
function iGetRunningTime() return GetRunningTime() end

--- Retrieves the current date and time formatted according to the given string format.
--- @param format string Optional. The date format string. Defaults to "dd-mm-yyyy".
--- @return string|table currentdate The formatted date and time as a string if a format string is provided, otherwise as a table.
---
--- Remarks:
--- If one wishes to supply their own format string, it uses the same rules as strftime(). The special string *t tells the date() function to return a table.
---
--- Example:
--- > ```lua
--- > -- Display the current date/time
--- > OutputLogMessage("Today’s date/time is: %s\n", GetDate())
--- > ```
function iGetDate(format) format = default(format,"dd-mm-yyyy"); return GetDate(format) end

--- Clears the output window of the script editor.
---@return nil
--- Example:
--- > ```lua
--- > -- Clear the script editor log
--- > OutputLogMessage("This message will self destruct in 2 seconds\n")
--- > Sleep(2000)
--- > iClearLog()
--- > ```
function iClearLog() ClearLog() end

--- The PressKey() function is used to simulate a keyboard key press.
--- NOTE: Calling IsModifierPressed or IsKeyLockOn immediately afterwards for a simulated
--- modifier or lock key will likely return the previous state. It will take a few milliseconds for
--- the operation to complete.
---@param scancode number|string Specifies the numerical scancode or predefined keyname of the key to be pressed.<br>
---@return nil
---
--- Remarks:
--- If multiple keys are provided as arguments, all keys will be simulated with a press.
--- For scancode and keyname values, refer to AppendixA.
---
--- Example:
--- > ```lua
--- > -- Simulate "a" pressed using the scancode<br>
--- > PressKey(30)
--- > -- Simulate "a" pressed using the keyname<br>
--- > PressKey("a")
--- > -- Simulate "a" and "b" being pressed<br>
--- > PressKey("a", "b")
--- > ```
---@see AppendixA
function iPressKey(key) PressKey(key) end

--- The ReleaseKey() function is used to simulate a keyboard key release.
---@param scancode number|string Specifies the numerical scancode or predefined keyname of the key to be released.<br>
---@return nil
---
--- Remarks:
--- If multiple keys are provided as arguments, all keys will be simulated with a release.
--- For scancode and keyname values, refer to AppendixA.
---
--- Example:
--- > ```lua
--- > -- Simulate "a" released using the scancode<br>
--- > ReleaseKey(30)
--- > -- Simulate "a" released using the keyname<br>
--- > ReleaseKey("a")
--- > -- Simulate "a" and "b" being released<br>
--- > ReleaseKey("a", "b")
--- > ```
---@see AppendixA
function iReleaseKey(key) ReleaseKey(key) end

--- The PressAndReleaseKey() function is used to simulate a keyboard key press followed by a release.
--- NOTE: Calling IsModifierPressed or IsKeyLockOn immediately afterwards for a simulated
--- modifier or lock key will likely return the previous state. It will take a few milliseconds for
--- the operation to complete.
---@param scancode number|string Specifies the numerical scancode or predefined keyname of the key to be pressed and released.<br>
---@return nil
---
--- Remarks:
--- If multiple keys are provided as arguments, all keys will be simulated with a press and a release.
--- For scancode and keyname values, refer to AppendixA.
---
--- Example:
--- > ```lua
--- > -- Simulate "a" pressed and released using the scancode<br>
--- > PressAndReleaseKey(30)
--- > -- Simulate "a" pressed and released using the keyname<br>
--- > PressAndReleaseKey("a")
--- > -- Simulate "a" and "b" being pressed and released<br>
--- > PressAndReleaseKey("a", "b")
--- > ```
---@see AppendixA
function iPressAndReleaseKey(key) PressAndReleaseKey(key) end

--- Determines if a particular modifier key is currently in a pressed state.
--- @param keyname string The predefined keyname of the modifier key to check.
--- The keyname must be one of the following:
--- | Modifier | Description                         |
--- |----------|-------------------------------------|
--- | "lalt"   | Left Alt key                        |
--- | "ralt"   | Right Alt key                       |
--- | "alt"    | Either Alt key                      |
--- | "lshift" | Left Shift key                      |
--- | "rshift" | Right Shift key                     |
--- | "shift"  | Either Shift key                    |
--- | "lctrl"  | Left Ctrl key                       |
--- | "rctrl"  | Right Ctrl key                      |
--- | "ctrl"   | Either Ctrl key                     |
--- @return boolean keystate if the modifier key is currently pressed, false otherwise.
---
--- Remarks:
--- None.
---
--- Example:
--- > ```lua
--- > -- Press a specific modifier
--- > PressKey("lshift")
--- > -- Sleep for 100 ms to allow IsModifierPressed() to get an accurate result
--- > Sleep(100)
--- > if IsModifierPressed("shift") then
--- >     OutputLogMessage("Shift is pressed.\n")
--- > end
--- > -- Release the key so it is no longer pressed
--- > ReleaseKey("lshift")
--- > -- Sleep for 100 ms to allow IsModifierPressed() to get an accurate result
--- > Sleep(100)
--- > if not IsModifierPressed("shift") then
--- >     OutputLogMessage("Shift is not pressed.\n")
--- > end
--- > ```
function iIsModifierPressed(modifier) return IsModifierPressed(modifier) end

--- Simulates a mouse button press.
--- @param button number The button identifier. Use the following table:
---   - 1: Left Mouse Button
---   - 2: Middle Mouse Button
---   - 3: Right Mouse Button
---   - 4: X1 Mouse Button
---   - 5: X2 Mouse Button
--- @return nil
---
--- Remarks:
--- Calling IsMouseButtonPressed immediately afterwards will likely return the previous
--- state. It will take a few milliseconds for the operation to complete.
---
--- Example:
--- > ```lua
--- > -- Simulate left mouse button press
--- > PressMouseButton(1)
--- > -- Simulate right mouse button press
--- > PressMouseButton(3)
--- > ```
function iPressMouseButton(button) PressMouseButton(button) end

--- Simulates a mouse button release.
--- @param button number The button identifier. Use the following table:
---   - 1: Left Mouse Button
---   - 2: Middle Mouse Button
---   - 3: Right Mouse Button
---   - 4: X1 Mouse Button
---   - 5: X2 Mouse Button
--- @return nil
---
--- Remarks:
--- None.
---
--- Example:
--- > ```lua
--- > -- Simulate a left mouse button click (press and release)
--- > PressMouseButton(1)
--- > ReleaseMouseButton(1)
--- > ```
function iReleaseMouseButton(button) ReleaseMouseButton(button) end

--- Simulates a mouse button press followed by a release.
--- @param button number The button identifier. Use the following table:
---   - 1: Left Mouse Button
---   - 2: Middle Mouse Button
---   - 3: Right Mouse Button
---   - 4: X1 Mouse Button
---   - 5: X2 Mouse Button
--- @return nil
---
--- Remarks:
--- Calling IsMouseButtonPressed immediately afterwards will likely return the previous
--- state. It will take a few milliseconds for the operation to complete.
---
--- Example:
--- > ```lua
--- > -- Simulate a left mouse button click (press and release)
--- > PressAndReleaseMouseButton(1)
--- > ```
function iPressAndReleaseMouseButton(button) PressAndReleaseMouseButton(button) end

--- Determines if a particular mouse button is currently in a pressed state.
--- @param button number The button identifier. Use the following table:
---   - 1: Left Mouse Button
---   - 2: Middle Mouse Button
---   - 3: Right Mouse Button
---   - 4: X1 Mouse Button
---   - 5: X2 Mouse Button
--- @return boolean pressedstate if the button is currently pressed, false otherwise.
---
--- Example:
--- > ```lua
--- > -- Press a mouse button
--- > PressMouseButton(1)
--- > if IsMouseButtonPressed(1) then
--- >     OutputLogMessage("Left mouse button is pressed.\n")
--- > end
--- > -- Release the button so it is no longer pressed
--- > ReleaseMouseButton(1)
--- > if not IsMouseButtonPressed(1) then
--- >     OutputLogMessage("Left mouse button is not pressed.\n")
--- > end
--- > ```
function iIsMouseButtonPressed(button) return IsMouseButtonPressed(button) end

--- Moves the mouse cursor to an absolute position on the screen.
--- @param x number Normalized X coordinate between 0 (farthest left) and 65535 (farthest right).
--- @param y number Normalized Y coordinate between 0 (farthest top) and 65535 (farthest bottom).
---
--- Remarks:
--- If multiple monitors are present, use MoveMouseToVirtual.
--- Calling GetMousePosition immediately afterwards will likely return the previous state. It
--- will take a few milliseconds for the operation to complete.
---
--- Example:
--- > ```lua
--- > -- Move mouse to upper, left corner
--- > MoveMouseTo(0, 0)
--- > -- Move mouse to center of screen
--- > MoveMouseTo(32767, 32767)
--- > -- Move mouse to lower, right corner
--- > MoveMouseTo(65535, 65535)
--- > ```
function iMoveMouseTo(x,y) MoveMouseTo(x,y) end

--- Simulates relative mouse movement.
--- @param x number Movement along the x-axis.
--- @param y number Movement along the y-axis.
---
--- Remarks:
--- Positive x values simulate movement to the right.
--- Negative x values simulate movement to the left.
--- Positive y values simulate movement downwards.
--- Negative y values simulate movement upwards.
---
--- Example:
--- > ```lua
--- > -- Simulate relative mouse movement upwards in 1 pixel increments
--- > for i = 0, 50 do
--- >     MoveMouseRelative(0, -1)
--- >     Sleep(8)
--- > end
--- > ```
function iMoveMouseRelative(x,y) MoveMouseRelative(x,y) end

--- Simulates mouse wheel movement.
--- @param times number Number of mouse wheel clicks.
---
--- Remarks:
--- Positive values denote wheel movement upwards (away from the user).
--- Negative values denote wheel movement downwards (towards the user).
---
--- Example:
--- > ```lua
--- > -- Simulate mouse wheel 3 clicks up
--- > MoveMouseWheel(3)
--- > -- Simulate mouse wheel 1 click down
--- > MoveMouseWheel(-1)
--- > ```
function iMoveMouseWheel(times) MoveMouseWheel(times) end

--- Returns the normalized coordinates of the current mouse cursor location.
--- NOTE: Calling this function immediately after a mouse movement operation, like MoveMouseTo, MoveMouseRelative, etc., may return the previous mouse position due to system latency.
--- @return number x Normalized X coordinate between 0 (farthest left) and 65535 (farthest right).
--- @return number y Normalized Y coordinate between 0 (farthest top) and 65535 (farthest bottom).
---
--- Remarks:
--- If multiple monitors are present, use MoveMouseToVirtual.
---
--- Example:
--- > ```lua
--- > -- Get the current mouse cursor position
--- > local x, y = iGetMousePosition()
--- > OutputLogMessage("Mouse is at %d, %d\n", x, y)
--- > ```
function iMoveMouseToVirtual(x,y) MoveMouseToVirtual(x,y) end

--- Returns the normalized coordinates of the current mouse cursor location.
--- @return number x Normalized X coordinate between 0 (farthest left) and 65535 (farthest right).
--- @return number y Normalized Y coordinate between 0 (farthest top) and 65535 (farthest bottom).
---
--- Example:
--- > ```lua
--- > -- Get the current mouse cursor position
--- > local x, y = iGetMousePosition()
--- > OutputLogMessage("Mouse is at %d, %d\n", x, y)
--- > ```
function iGetMousePosition() return GetMousePosition() end

-- function iOutputLCDMessage(text,timeout) timeout = default(timeout,1000), OutputLCDMessage(text,timeout) end
-- function iClearLCD() ClearLCD() end

--- Plays an existing macro.
--- @param name string The name of the existing macro belonging to the current profile.
--- @return nil
---
--- Remarks:
--- If the function is called while another script macro is playing, no action is taken. In other words, only one script macro may be playing at any given time.
--- If the function is called while the same script macro is playing, the macro is queued. The macro will simulate a key press down (on a virtual macro key), wait for 100ms, then simulate a key release. This way macros will on press and on release will be played properly. For granular control on macro playback, take a look at PressMacro and ReleaseMacro functions.
---
--- Example:
--- > ```lua
--- > -- Play an existing macro
--- > iPlayMacro("my macro")
--- > ```
function iPlayMacro(name) PlayMacro(name) end

--- Plays an existing macro by simulating a key press down.
--- @param name string The name of the existing macro belonging to the current profile.
--- @return nil
---
--- Remarks:
--- If the function is called while another script macro is playing, no action is taken. In other words, only one script macro may be playing at any given time.
--- If the function is called while the same script macro is playing, the macro is queued.
---
--- Example:
--- > ```lua
--- > -- Play an existing macro
--- > iPressMacro("my macro")
--- > ```
function iPressMacro(name) PressMacro(name) end

--- Plays an existing macro by simulating a key release.
--- @param name string The name of the existing macro belonging to the current profile.
--- @return nil
---
--- Remarks:
--- If the function is called while another script macro is playing, no action is taken. In other words, only one script macro may be playing at any given time.
--- If the function is called while the same script macro is playing, the macro is queued.
---
--- Example:
--- > ```lua
--- > -- Play an existing macro
--- > iReleaseMacro("my macro")
--- > ```
function iReleaseMacro(name) ReleaseMacro(name) end

--- Aborts any macro started from a script.
--- @return nil
---
--- Remarks:
--- Any keys still pressed after a call to PlayMacro will be released. Macros playing outside the script will continue to play.
---
--- Example:
--- > ```lua
--- > -- Start a macro
--- > PlayMacro("my macro")
--- > -- Wait for 100ms and then abort any playing macro
--- > Sleep(100)
--- > AbortMacro()
--- > ```
function iAbortMacro(name) AbortMacro(name) end

--- Determines if a particular lock button is currently in an enabled state.
--- @param key string The key name. Use the following table:
---   - "scrolllock": Scroll Lock
---   - "capslock": Caps Lock
---   - "numlock": Number Lock
--- @return boolean True if the lock is currently enabled, false otherwise.
---
--- Example:
--- > ```lua
--- > -- Check if the numlock is on and turn it off if it is
--- > if IsKeyLockOn("numlock") then
--- >     PressAndReleaseKey("numlock")
--- > end
--- > ```
function iIsKeyLockOn(key) return IsKeyLockOn(key) end

-- function iSetBacklightColor(red,green,blue,family) family = default(family,"kb"); SetBacklightColor(red,green,blue,family) end

--- Sends log messages to the Windows debugger.
--- @param message string The message to be sent. Printf style, formatted string containing the message.
--- @return nil
---
--- Remarks:
--- Mirror of string.format().
--- You must manually insert a carriage return "\n" to denote end of line.
--- Use tools like Dbg View for viewing these messages.
---
--- Example:
--- > ```lua
--- > -- Send out "Hello World"
--- > OutputDebugMessage("Hello World %d\n", 2007)
--- > ```
function iOutputDebugMessage(message) OutputDebugMessage(message) end

-- function iSetMouseDPITable(value1,value2,value3,index) SetMouseDPITable({value1,value2,value3},index) end
-- function iSetMouseDPITableIndex(index) SetMouseDPITableIndex(index) end

--- Enables event reporting for mouse button 1.
--- @param onezero string|number Optional. Specifies whether to enable (1 or true) or disable (0 or false) event reporting for mouse button 1. Defaults to "1".
--- @return nil
---
--- Remarks:
--- The primary mouse button is not reported by default for performance issues.
---
--- Example:
--- > ```lua
--- > -- Enable event reporting for mouse button 1
--- > EnablePrimaryMouseButtonEvents(true)
--- >
--- > -- Disable event reporting for mouse button 1
--- > EnablePrimaryMouseButtonEvents(false)
--- > ```
function iEnablePrimaryMouseButtonEvents(onezero) onezero = default(onezero,"1"); EnablePrimaryMouseButtonEvents(onezero) end
-- function iSetSteeringWheelProperty(device,property,value) end


--- Appendix A:
--- 
--- Table of scancodes and keynames used in PressKey(), ReleaseKey(), IsModifierPressed().
--- | Keyname       | Scancode (hex) |
--- |---------------|----------------|
--- | "escape"      | 0x01           |
--- | "f1"          | 0x3b           |
--- | "f2"          | 0x3c           |
--- | "f3"          | 0x3d           |
--- | "f4"          | 0x3e           |
--- | "f5"          | 0x3f           |
--- | "f6"          | 0x40           |
--- | "f7"          | 0x41           |
--- | "f8"          | 0x42           |
--- | "f9"          | 0x43           |
--- | "f10"         | 0x44           |
--- | "f11"         | 0x57           |
--- | "f12"         | 0x58           |
--- | "f13"         | 0x64           |
--- | "f14"         | 0x65           |
--- | "f15"         | 0x66           |
--- | "f16"         | 0x67           |
--- | "f17"         | 0x68           |
--- | "f18"         | 0x69           |
--- | "f19"         | 0x6a           |
--- | "f20"         | 0x6b           |
--- | "f21"         | 0x6c           |
--- | "f22"         | 0x6d           |
--- | "f23"         | 0x6e           |
--- | "f24"         | 0x76           |
--- | "printscreen" | 0x137          |
--- | "scrolllock"  | 0x46           |
--- | "pause"       | 0x146          |
--- | "tilde"       | 0x29           |
--- | "1"           | 0x02           |
--- | "2"           | 0x03           |
--- | "3"           | 0x04           |
--- | "4"           | 0x05           |
--- | "5"           | 0x06           |
--- | "6"           | 0x07           |
--- | "7"           | 0x08           |
--- | "8"           | 0x09           |
--- | "9"           | 0x0a           |
--- | "0"           | 0x0b           |
--- | "minus"       | 0x0c           |
--- | "equal"       | 0x0d           |
--- | "backspace"   | 0x0e           |
--- | "tab"         | 0x0f           |
--- | "q"           | 0x10           |
--- | "w"           | 0x11           |
--- | "e"           | 0x12           |
--- | "r"           | 0x13           |
--- | "t"           | 0x14           |
--- | "y"           | 0x15           |
--- | "u"           | 0x16           |
--- | "I"           | 0x17           |
--- | "o"           | 0x18           |
--- | "p"           | 0x19           |
--- | "lbracket"    | 0x1a           |
--- | "rbracket"    | 0x1b           |
--- | "backslash"   | 0x2b           |
--- | "capslock"    | 0x3a           |
--- | "a"           | 0x1e           |
--- | "s"           | 0x1f           |
--- | "d"           | 0x20           |
--- | "f"           | 0x21           |
--- | "g"           | 0x22           |
--- | "h"           | 0x23           |
--- | "j"           | 0x24           |
--- | "k"           | 0x25           |
--- | "l"           | 0x26           |
--- | "semicolon"   | 0x27           |
--- | "quote"       | 0x28           |
--- | "enter"       | 0x1c           |
--- | "lshift"      | 0x2a           |
--- | "non_us_slash"| 0x56           |
--- | "z"           | 0x2c           |
--- | "x"           | 0x2d           |
--- | "c"           | 0x2e           |
--- | "v"           | 0x2f           |
--- | "b"           | 0x30           |
--- | "n"           | 0x31           |
--- | "m"           | 0x32           |
--- | "comma"       | 0x33           |
--- | "period"      | 0x34           |
--- | "slash"       | 0x35           |
--- | "rshift"      | 0x36           |
--- | "lctrl"       | 0x1d           |
--- | "lgui"        | 0x15b          |
--- | "lalt"        | 0x38           |
--- | "spacebar"    | 0x39           |
--- | "ralt"        | 0x138          |
--- | "rgui"        | 0x15c          |
--- | "appkey"      | 0x15d          |
--- | "rctrl"       | 0x11d          |
--- | "insert"      | 0x152          |
--- | "home"        | 0x147          |
--- | "pageup"      | 0x149          |
--- | "delete"      | 0x153          |
--- | "end"         | 0x14f          |
--- | "pagedown"    | 0x151          |
--- | "up"          | 0x148          |
--- | "left"        | 0x14b          |
--- | "down"        | 0x150          |
--- | "right"       | 0x14d          |
--- | "numlock"     | 0x45           |
--- | "numslash"    | 0x135          |
--- | "numminus"    | 0x4a           |
--- | "num7"        | 0x47           |
--- | "num8"        | 0x48           |
--- | "num9"        | 0x49           |
--- | "numplus"     | 0x4e           |
--- | "num4"        | 0x4b           |
--- | "num5"        | 0x4c           |
--- | "num6"        | 0x4d           |
--- | "num1"        | 0x4f           |
--- | "num2"        | 0x50           |
--- | "num3"        | 0x51           |
--- | "numenter"    | 0x11c          |
--- | "num0"        | 0x52           |
--- | "numperiod"   | 0x53           |
AppendixA = {}

--- Define the scancodes table
AppendixA.scancodes = {
    ["escape"] = 0x01,
    ["f1"] = 0x3b,
    ["f2"] = 0x3c,
    ["f3"] = 0x3d,
    ["f4"] = 0x3e,
    ["f5"] = 0x3f,
    ["f6"] = 0x40,
    ["f7"] = 0x41,
    ["f8"] = 0x42,
    ["f9"] = 0x43,
    ["f10"] = 0x44,
    ["f11"] = 0x57,
    ["f12"] = 0x58,
    ["f13"] = 0x64,
    ["f14"] = 0x65,
    ["f15"] = 0x66,
    ["f16"] = 0x67,
    ["f17"] = 0x68,
    ["f18"] = 0x69,
    ["f19"] = 0x6a,
    ["f20"] = 0x6b,
    ["f21"] = 0x6c,
    ["f22"] = 0x6d,
    ["f23"] = 0x6e,
    ["f24"] = 0x76,
    ["printscreen"] = 0x137,
    ["scrolllock"] = 0x46,
    ["pause"] = 0x146,
    ["tilde"] = 0x29,
    ["1"] = 0x02,
    ["2"] = 0x03,
    ["3"] = 0x04,
    ["4"] = 0x05,
    ["5"] = 0x06,
    ["6"] = 0x07,
    ["7"] = 0x08,
    ["8"] = 0x09,
    ["9"] = 0x0a,
    ["0"] = 0x0b,
    ["minus"] = 0x0c,
    ["equal"] = 0x0d,
    ["backspace"] = 0x0e,
    ["tab"] = 0x0f,
    ["q"] = 0x10,
    ["w"] = 0x11,
    ["e"] = 0x12,
    ["r"] = 0x13,
    ["t"] = 0x14,
    ["y"] = 0x15,
    ["u"] = 0x16,
    ["i"] = 0x17,
    ["o"] = 0x18,
    ["p"] = 0x19,
    ["lbracket"] = 0x1a,
    ["rbracket"] = 0x1b,
    ["backslash"] = 0x2b,
    ["capslock"] = 0x3a,
    ["a"] = 0x1e,
    ["s"] = 0x1f,
    ["d"] = 0x20,
    ["f"] = 0x21,
    ["g"] = 0x22,
    ["h"] = 0x23,
    ["j"] = 0x24,
    ["k"] = 0x25,
    ["l"] = 0x26,
    ["semicolon"] = 0x27,
    ["quote"] = 0x28,
    ["enter"] = 0x1c,
    ["lshift"] = 0x2a,
    ["non_us_slash"] = 0x56,
    ["z"] = 0x2c,
    ["x"] = 0x2d,
    ["c"] = 0x2e,
    ["v"] = 0x2f,
    ["b"] = 0x30,
    ["n"] = 0x31,
    ["m"] = 0x32,
    ["comma"] = 0x33,
    ["period"] = 0x34,
    ["slash"] = 0x35,
    ["rshift"] = 0x36,
    ["lctrl"] = 0x1d,
    ["lgui"] = 0x15b,
    ["lalt"] = 0x38,
    ["spacebar"] = 0x39,
    ["ralt"] = 0x138,
    ["rgui"] = 0x15c,
    ["appkey"] = 0x15d,
    ["rctrl"] = 0x11d,
    ["insert"] = 0x152,
    ["home"] = 0x147,
    ["pageup"] = 0x149,
    ["delete"] = 0x153,
    ["end"] = 0x14f,
    ["pagedown"] = 0x151,
    ["up"] = 0x148,
    ["left"] = 0x14b,
    ["down"] = 0x150,
    ["right"] = 0x14d,
    ["numlock"] = 0x45,
    ["numslash"] = 0x135,
    ["numminus"] = 0x4a,
    ["num7"] = 0x47,
    ["num8"] = 0x48,
    ["num9"] = 0x49,
    ["numplus"] = 0x4e,
    ["num4"] = 0x4b,
    ["num5"] = 0x4c,
    ["num6"] = 0x4d,
    ["num1"] = 0x4f,
    ["num2"] = 0x50,
    ["num3"] = 0x51,
    ["numenter"] = 0x11c,
    ["num0"] = 0x52,
    ["numperiod"] = 0x53,
}

--- Retrieves the scancode corresponding to the given keyname.
---@param keyName string The name of the key.
---@return number|nil scancode The scancode if found, nil otherwise.
---
--- Remarks:
--- If the provided keyname does not exist in the scancodes table, nil is returned.
---
--- Example:
--- > ```lua
--- > -- Get the scancode for the keyname "f21"
--- > local scancode = appendixA:getScancode("f21")
--- > print("Scancode for keyname 'f21':", scancode)  -- Output: "Scancode for keyname 'f21': 108"
--- > ```
---
function AppendixA.getScancode(keyName)
    return AppendixA.scancodes[keyName]
end

--- Retrieves the keyname corresponding to the given scancode.
---@param scancode number The scancode of the key.
---@return string|nil keyname The keyname if found, nil otherwise.
---
--- Remarks:
--- If the provided scancode does not exist in the scancodes table, nil is returned.
---
--- Example:
--- > ```lua
--- > -- Get the keyname for the scancode 0x6c
--- > local keyName = appendixA:getKeyName(0x6c)
--- > print("Keyname for scancode 0x6c:", keyName)  -- Output: "Keyname for scancode 0x6c: f21"
--- > ```
---
function AppendixA.getKeyName(scancode)
    local keyName = nil

    for name, code in pairs(AppendixA.scancodes) do
        if code == scancode then
            keyName = name
            break
        end
    end

    return keyName
end
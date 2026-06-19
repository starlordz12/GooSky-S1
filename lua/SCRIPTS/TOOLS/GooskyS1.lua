-- =========================================================================
-- GooskyS1.lua  -  EdgeTX TOOLS script for the GooSky S1 V3 Pro (ELRS / GTS)
-- Radio: RadioMaster TX15 Max (EdgeTX 3.0.0+)   Location: /SCRIPTS/TOOLS/
-- =========================================================================
-- PURPOSE: a READ-ONLY pre-flight dashboard. It displays flight mode, timer,
-- throttle-hold status, live telemetry, a pre-flight checklist and the switch
-- assignments.
--
-- SAFETY GUARANTEE: this script is strictly informational. It NEVER arms the
-- helicopter and NEVER changes any flight-critical setting. It only READS
-- values (getValue / model.getTimer) and draws to the screen. There are no
-- writes to channels, mixes, outputs, the RF module, or model settings.
--
-- NOTE: switch assignments below mirror /docs/switch-table.md. If you remap
-- switches in the model, update the SW_* names here to match. Values that a
-- given setup does not provide are shown as "---".
-- =========================================================================

-- ---- configuration (edit to match your model if you remap switches) -------
local SW_HOLD = "sf"   -- Throttle Hold (master motor cut)
local SW_MODE = "sa"   -- Flight mode: Easy / Mild / Wild
local SW_STAB = "sb"   -- Stability (CH5): Self-level <-> 3D
local FLIGHT_TIMER = 0 -- model timer index used for flight time (T1)
local LQ_WARN = 50     -- link-quality warning threshold (RQly), informational

-- ---- small helpers --------------------------------------------------------
local function has(name)
  return getFieldInfo(name) ~= nil
end

local function tele(name)
  if has(name) then
    return getValue(name)
  end
  return nil
end

-- read a 3-position switch source -> -1, 0, 1 (or nil if unavailable)
local function sw3(name)
  if not has(name) then return nil end
  local v = getValue(name)
  if v == nil then return nil end
  if v < -100 then return -1
  elseif v > 100 then return 1
  else return 0 end
end

local function modeName()
  local p = sw3(SW_MODE)
  if p == nil then return "?" end
  if p < 0 then return "EASY"
  elseif p == 0 then return "MILD"
  else return "WILD" end
end

local function stabName()
  local p = sw3(SW_STAB)
  if p == nil then return "?" end
  if p < 0 then return "SELF-LEVEL"
  elseif p == 0 then return "MID/SELF"
  else return "3D" end
end

-- Throttle hold: SF up = HOLD (motor cut) per /docs/switch-table.md
local function holdOn()
  local p = sw3(SW_HOLD)
  if p == nil then return nil end
  return (p < 0)   -- switch "up" reads negative on EdgeTX
end

local function fmtTime(secs)
  if secs == nil then return "--:--" end
  if secs < 0 then secs = -secs end
  local m = math.floor(secs / 60)
  local s = secs % 60
  return string.format("%02d:%02d", m, s)
end

local function tnum(v, suffix)
  if v == nil then return "---" end
  suffix = suffix or ""
  return tostring(v) .. suffix
end

-- ---- pre-flight checklist (display-only reminders) ------------------------
local checklist = {
  "Throttle HOLD = ON (SF up)",
  "Area clear, nose pointed away",
  "Blades/bolts/gears tight",
  "Battery charged & secured",
  "Radio ON first, model correct",
  "Link & telemetry healthy",
  "Failsafe = motor-off (verified)",
}

-- =========================================================================
-- DRAW
-- =========================================================================
local page = 1            -- 1 = dashboard, 2 = checklist + switches
local PAGES = 2

local function header(title)
  lcd.clear()
  lcd.drawText(3, 2, "GooSky S1 V3 Pro", INVERS)
  lcd.drawText(LCD_W - 3, 2, title, RIGHT + INVERS)
  lcd.drawLine(0, 14, LCD_W, 14, SOLID, FORCE)
end

local function drawDashboard()
  header("PRE-FLIGHT")

  local y = 20
  local hold = holdOn()
  local holdTxt, holdFlag
  if hold == nil then
    holdTxt, holdFlag = "UNKNOWN", BLINK
  elseif hold then
    holdTxt, holdFlag = "HOLD (motor cut)", 0
  else
    holdTxt, holdFlag = "LIVE  !!", BLINK
  end
  lcd.drawText(3, y, "Throttle:", 0)
  lcd.drawText(85, y, holdTxt, holdFlag)
  y = y + 16

  lcd.drawText(3, y, "Mode:", 0)
  lcd.drawText(85, y, modeName(), 0)
  y = y + 16

  lcd.drawText(3, y, "Stability:", 0)
  lcd.drawText(85, y, stabName(), 0)
  y = y + 16

  -- timer (flight time)
  local t = model.getTimer(FLIGHT_TIMER)
  local tval = nil
  if t ~= nil then tval = t.value end
  lcd.drawText(3, y, "Timer:", 0)
  lcd.drawText(85, y, fmtTime(tval), 0)
  y = y + 16

  -- telemetry
  lcd.drawLine(0, y, LCD_W, y, DOTTED, FORCE)
  y = y + 3
  local rssi = tele("RSSI") or tele("1RSS")
  local rqly = tele("RQly")
  local tpwr = tele("TPWR")
  local rxbt = tele("RxBt")

  lcd.drawText(3,   y, "RSSI " .. tnum(rssi, "dB"), 0)
  local rqFlag = 0
  if rqly ~= nil and rqly < LQ_WARN then rqFlag = BLINK end
  lcd.drawText(120, y, "LQ " .. tnum(rqly), rqFlag)
  y = y + 14
  lcd.drawText(3,   y, "TPWR " .. tnum(tpwr, "mW"), 0)
  lcd.drawText(120, y, "Vbat " .. tnum(rxbt, "V"), 0)
end

local function drawChecklist()
  header("CHECKLIST")
  local y = 18
  for i = 1, #checklist do
    lcd.drawText(3, y, "[ ] " .. checklist[i], SMLSIZE)
    y = y + 12
  end
  lcd.drawLine(0, y, LCD_W, y, DOTTED, FORCE)
  y = y + 2
  lcd.drawText(3, y, "SF=Hold SA=Mode SB=Stab", SMLSIZE)
  y = y + 11
  lcd.drawText(3, y, "Tool is read-only (safe)", SMLSIZE)
end

-- =========================================================================
-- LIFECYCLE
-- =========================================================================
local function init()
  page = 1
end

local function run(event)
  -- page navigation; exit on EXIT
  if event == EVT_VIRTUAL_EXIT or event == EVT_EXIT_BREAK then
    return 1   -- leave the tool
  elseif event == EVT_VIRTUAL_NEXT or event == EVT_VIRTUAL_INC
      or event == EVT_ROT_RIGHT then
    page = page + 1
    if page > PAGES then page = 1 end
  elseif event == EVT_VIRTUAL_PREV or event == EVT_VIRTUAL_DEC
      or event == EVT_ROT_LEFT then
    page = page - 1
    if page < 1 then page = PAGES end
  end

  if page == 1 then
    drawDashboard()
  else
    drawChecklist()
  end

  return 0   -- keep running
end

return { init = init, run = run, name = "GooSky S1" }

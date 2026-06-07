-- gi で Chrome の最初の入力欄にフォーカスする
local sequenceActive = false
local sequenceTimer = nil

local JS = [[(function() {
    var activeEl = document.activeElement;
    var activeTag = activeEl && activeEl.tagName;
    var activeRole = activeEl && activeEl.getAttribute && activeEl.getAttribute('role');
    if (activeTag === 'INPUT' || activeTag === 'TEXTAREA' || (activeEl && activeEl.isContentEditable)
        || activeRole === 'searchbox' || activeRole === 'textbox' || activeRole === 'combobox') {
        return 'already focused';
    }
    var CSS = [
        'input:not([type=hidden]):not([type=submit]):not([type=button]):not([type=reset])'
            + ':not([type=image]):not([type=checkbox]):not([type=radio]):not([type=file]):not([disabled])',
        'textarea:not([disabled])',
        '[contenteditable=true]',
        '[role=searchbox]','[role=textbox]','[role=combobox]'
    ].join(',');
    function visible(el) { var r = el.getBoundingClientRect(); return r.width > 0 && r.height > 0; }
    function search(root) {
        var els = root.querySelectorAll(CSS);
        for (var i = 0; i < els.length; i++) { if (visible(els[i])) return els[i]; }
        var hosts = root.querySelectorAll('*');
        for (var i = 0; i < hosts.length; i++) {
            if (hosts[i].shadowRoot) { var f = search(hosts[i].shadowRoot); if (f) return f; }
        }
        return null;
    }
    var target = search(document);
    if (target) { target.focus(); return 'focused:' + target.tagName; }
    return 'no input found';
})()]]

-- AppleScriptをファイルに書き出して起動時に一度だけ準備
local SCRIPT_PATH = "/tmp/hs_gi_focus.applescript"
local appleScript = 'tell application "Google Chrome"\n' ..
    '    execute active tab of front window javascript ' ..
    string.format('%q', JS) .. '\n' ..
    'end tell'
local f = io.open(SCRIPT_PATH, "w")
if f then f:write(appleScript); f:close() end

local function focusFirstInput()
    -- hs.task で完全に別プロセス化 → eventtapをブロックしない
    hs.task.new("/usr/bin/osascript", function(code, stdout, stderr)
        print("focusFirstInput: code=" .. tostring(code) .. " result=" .. tostring(stdout))
    end, {SCRIPT_PATH}):start()
end

local giWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local app = hs.application.frontmostApplication()
    if not app or app:bundleID() ~= "com.google.Chrome" then
        sequenceActive = false
        return false
    end

    local flags = event:getFlags()
    if flags.cmd or flags.ctrl or flags.alt or flags.shift then
        sequenceActive = false
        return false
    end

    local char = hs.keycodes.map[event:getKeyCode()]

    if char == "g" then
        sequenceActive = true
        if sequenceTimer then sequenceTimer:stop() end
        sequenceTimer = hs.timer.doAfter(1.5, function()
            sequenceActive = false
        end)
        return true

    elseif char == "i" and sequenceActive then
        sequenceActive = false
        if sequenceTimer then sequenceTimer:stop() end
        focusFirstInput() -- 別プロセスで実行、即座にreturn
        return true

    else
        sequenceActive = false
    end

    return false
end)

giWatcher:start()

-- Secure Input解除後にeventtapを自動復帰させるウォッチドッグ
hs.timer.doEvery(0.5, function()
    if not giWatcher:isEnabled() then
        if not hs.eventtap.isSecureInputEnabled() then
            giWatcher:start()
            print("eventtap 復帰完了（Secure Input解除を検出）")
        end
    end
end)

hs.alert.show("Hammerspoon 起動完了 - gi で入力欄にフォーカス")

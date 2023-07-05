local wibox = require('wibox')

local vpn_widget = wibox.widget.textbox()

function update_vpn_widget()
    -- Проверяем, запущен ли процесс WireGuard
    local wg_process = io.popen("pgrep wg-quick")
    local is_vpn_running = wg_process:read("*a")
    wg_process:close()

    -- Устанавливаем текст виджета в зависимости от состояния VPN
    if is_vpn_running ~= "" then
        vpn_widget:set_text("VPN: On")
    else
        vpn_widget:set_text("VPN: Off")
    end
end

update_vpn_widget()

awful.widget.watch("bash -c 'pgrep wg-quick'", 5, function(_, stdout)
    if stdout ~= "" then
        vpn_widget:set_text("VPN: On")
    else
        vpn_widget:set_text("VPN: Off")
    end
end)

return vpn_widget
ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
end)

function MadenMenu()
    local elements = {
        {label = 'Araç Al',   value = 'arackirala'},
        {label = 'Token Sat',          value = 'tokensat'},
        {label = 'Menüyü Kapat',       value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'madenmenu', {
        title    = 'Maden Menüsü',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'arackirala' then
            TriggerEvent("zn-maden:aracal")
        elseif data.current.value == 'tokensat' then
            TriggerServerEvent("zn-maden:tokensat")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

RegisterNetEvent("zn-maden:aracal")
AddEventHandler("zn-maden:aracal", function()
    local ped = PlayerPedId()
    ESX.Game.SpawnVehicle(Config.Arac, Config.Araccikarma, 500.50, function(vehicle)
    end)
end)

RegisterNetEvent("zn-maden:arackoy")
AddEventHandler("zn-maden:arackoy", function()
    local currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(currentVehicle, true, true)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    SetEntityCoords(GetPlayerPed(-1), x - 2, y, z)
    DeleteVehicle(currentVehicle)
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Menu.x, Config.Menu.y, Config.Menu.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Menu.x, Config.Menu.y, Config.Menu.z, true)
        if dst2 < 5 then
            sleep = 2
            DrawMarker(2, Config.Menu.x, Config.Menu.y, Config.Menu.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(Config.Menu.x, Config.Menu.y, Config.Menu.z + 0.5, '[E] Menüyü Aç')
                if IsControlJustReleased(0, 38) then
                    MadenMenu()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        for k in pairs(Config.Kayabolge) do
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local dst = GetDistanceBetweenCoords(playercoords, Config.Kayabolge[k].x, Config.Kayabolge[k].y, Config.Kayabolge[k].z, true)
            local dst2 = GetDistanceBetweenCoords(playercoords, Config.Kayabolge[k].x, Config.Kayabolge[k].y, Config.Kayabolge[k].z, true)
            if dst2 < 10 then
                sleep = 2
                DrawMarker(2, Config.Kayabolge[k].x, Config.Kayabolge[k].y, Config.Kayabolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
                if dst2 < 2 then
                    DrawText3Ds(Config.Kayabolge[k].x, Config.Kayabolge[k].y, Config.Kayabolge[k].z + 0.5, '[E] Kaya Kaz')
                    if IsControlJustReleased(0, 38) then
                        ESX.TriggerServerCallback("zn-maden:itemkontrol", function(item)
                            if item then
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "kayakaz",
                                    duration = 30000,
                                    label = "kaya kazıyorsun",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "melee@large_wpn@streamed_core",
                                        anim = "ground_attack_on_spot",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_tool_pickaxe",
                                        bone = 57005,
                                        coords = { x = 0.18, y = -0.02, z = -0.02 },
                                        rotation = { x = 100.0, y = 150.00, z = 140.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        TriggerServerEvent("zn-maden:kaya")
                                    end
                                end)
                            else
                                ESX.ShowNotification('Üzerinde Kazma Yok!')
                            end
                        end)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Araccikarma.x, Config.Araccikarma.y, Config.Araccikarma.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Araccikarma.x, Config.Araccikarma.y, Config.Araccikarma.z, true)
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
        if dst2 < 5 then
            sleep = 2
            DrawMarker(2, Config.Araccikarma.x, Config.Araccikarma.y, Config.Araccikarma.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(Config.Araccikarma.x, Config.Araccikarma.y, Config.Araccikarma.z + 0.5, '[E] Aracı Koy')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("zn-maden:arackoy")
                end
            end
        end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Tokenal.x, Config.Tokenal.y, Config.Tokenal.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Tokenal.x, Config.Tokenal.y, Config.Tokenal.z, true)
        if dst2 < 5 then
            sleep = 2
            DrawMarker(2, Config.Tokenal.x, Config.Tokenal.y, Config.Tokenal.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(Config.Tokenal.x, Config.Tokenal.y, Config.Tokenal.z + 0.5, '[E] Token Al')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "token",
                        duration = 5000,
                        label = "taşlar veriliyor",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("zn-maden:tokenal")
                        end
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.KayaErit.x, Config.KayaErit.y, Config.KayaErit.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.KayaErit.x, Config.KayaErit.y, Config.KayaErit.z, true)
        if dst2 < 5 then
            sleep = 2
            DrawMarker(2, Config.KayaErit.x, Config.KayaErit.y, Config.KayaErit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(Config.KayaErit.x, Config.KayaErit.y, Config.KayaErit.z + 0.5, '[E] Taş Erit')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "taşerit",
                        duration = 15000,
                        label = "taş eritiliyor",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "amb@prop_human_bum_bin@idle_a",
                            anim = "idle_a",
                            flags = 49,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("zn-maden:kayaerit")
                        end
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Menu)

	SetBlipSprite (blip, 268)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Maden Merkezi")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(2952.436, 2767.997, 40.024)

	SetBlipSprite (blip, 268)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Maden Ocağı")
	EndTextCommandSetBlipName(blip)
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end
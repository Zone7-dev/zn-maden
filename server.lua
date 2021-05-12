ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-tokensat")
AddEventHandler("zn-tokensat", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem(Config.Token, 1) then
    xPlayer.addMoney(15)
    end
end)

RegisterNetEvent("zn-kaya")
AddEventHandler("zn-kaya", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(Config.Kaya, 1)
end)

RegisterNetEvent("zn-taserit")
AddEventHandler("zn-taserit", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem(Config.Kaya, 1) then
    xPlayer.addInventoryItem(Config.Tas, 1)
    end
end)

RegisterNetEvent("zn-tokenal")
AddEventHandler("zn-tokenal", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem(Config.Tas, 1) then
        xPlayer.addInventoryItem(Config.Token, 1)
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-maden^0] - Started!')
	end
end)
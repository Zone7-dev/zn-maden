ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-maden:tokensat")
AddEventHandler("zn-maden:tokensat", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("mdntoken").count >= 1 then
        xPlayer.removeInventoryItem("mdntoken", 1)
        Citizen.Wait(500)
        xPlayer.addMoney(15)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Token Yok')
    end
end)

RegisterNetEvent("zn-maden:kaya")
AddEventHandler("zn-maden:kaya", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem("kaya", 1) then
        xPlayer.addInventoryItem("kaya", 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
    end
end)

RegisterNetEvent("zn-maden:kayaerit")
AddEventHandler("zn-maden:kayaerit", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("kaya").count >= 1 then
        if xPlayer.canCarryItem("tas", 1) then
            xPlayer.removeInventoryItem("kaya", 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem("tas", 1)
        else
            TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Kaya Yok')
    end             
end)

RegisterNetEvent("zn-maden:tokenal")
AddEventHandler("zn-maden:tokenal", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("tas").count >= 1 then
        if xPlayer.canCarryItem("mdntoken", 1) then
            xPlayer.removeInventoryItem("tas", 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem("mdntoken", 1)
        else
            TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Taş Yok')
    end   
end)

ESX.RegisterServerCallback("zn-maden:itemkontrol", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("kazma").count >= 1 then
        cb(true)
    else
        cb(false) 
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-maden^0] - Started!')
	end
end)
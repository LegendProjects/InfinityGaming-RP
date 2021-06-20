local GUI = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0
local vehStorage = {}

function setVehicleTable()
	local vehicleTable = {['adder']=1, ['osiris']=0, ['pfister811']=0, ['penetrator']=0, ['autarch']=0, ['bullet']=0, ['cheetah']=0, ['cyclone']=0, ['voltic']=0, ['reaper']=1, ['entityxf']=0, ['t20']=0, ['taipan']=0, ['tempesta']=2, ['tezeract']=0, ['torero']=1, ['turismor']=0, ['fmj']=0, ['gp1']=2, ['infernus ']=0, ['italigtb']=1, ['italigtb2']=1, ['nero']=2, ['nero2']=0, ['vacca']=1, ['vagner']=0, ['visione']=0, ['prototipo']=0, ['xa21']=2, ['zentorno']=0}
	--[[
		0 = vehicle has no storage
		1 = vehicle storage is in bonnet
	]]
	for k, v in pairs(vehicleTable) do
	getHash = GetHashKey(k)
	vehStorage[getHash] = v
	end
end

setVehicleTable()

RegisterNetEvent("ig-inventory-trunk:setOwnedVehicule")
AddEventHandler("ig-inventory-trunk:setOwnedVehicule", function(vehicle)
	vehiclePlate = vehicle
end)

function getItemyWeight(item)
	local weight = 0
	local itemWeight = 0
	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
		itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end


function openTrunk()
  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  globalplate = GetVehicleNumberPlateText(vehicle)

	if not IsPedInAnyVehicle(playerPed) then
		local coords = GetEntityCoords(playerPed)
		myVeh = false
		PlayerData = ESX.GetPlayerData()

		for i = 1, #vehiclePlate do
			local vPlate = vehiclePlate[i]
			local vFront = all_trim(GetVehicleNumberPlateText(vehicle))
			if vPlate == vFront then
				myVeh = true
			elseif lastChecked < GetGameTimer() - 60000 then
				TriggerServerEvent("ig-inventory-trunk:getOwnedVehicle")
				lastChecked = GetGameTimer()
				Wait(2000)
				for i = 1, #vehiclePlate do
					local vPlate = vehiclePlate[i]
					local vFront = all_trim(GetVehicleNumberPlateText(vehicle))
					if vPlate == vFront then
						myVeh = true
					end
				end
			end
		end

		if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and PlayerData.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Mafia) or (Config.CheckOwnership and myVeh) then
			if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
				local vehFront = VehicleInFront()
				vehHash = GetEntityModel(vehFront)
				local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
     	 		local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
		  		local vehiclePos = GetWorldPositionOfEntityBone(vehFront, vehBone)
					
      			if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
					lastVehicle = vehFront
					local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehFront))
					local locked = GetVehicleDoorLockStatus(vehFront)
					local class = GetVehicleClass(vehFront)
					local vehicleHash = GetEntityModel(vehFront)
					ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
						SetVehicleDoorShut(vehFront, open, false)
					else
						if locked == 0 or locked == 1 then
							SetVehicleDoorOpen(vehFront, 5, false, false)
							ESX.UI.Menu.CloseAll()
							if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
								CloseToVehicle = true
								exports['mythic_progbar']:Progress({
									name = "open_trunk",
									duration = 2000,
									label = "Opening vehicle trunk..",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
									animation = {
										animDict = "mini@repair",
										anim = "fixing_a_ped",
										flags = 49,
									},
								}, function(status)
									if not status then
										if VehicleInFront() == lastVehicle then
											if vehicleHash == GetHashKey('tug') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 700000, myVeh)
											elseif vehicleHash == GetHashKey('guardian') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('dinghy') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dinghy2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dinghy4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gradywhite') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('jetmax') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('keywest') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('airboat') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('contender39') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('marquis') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('speeder') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('squalo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('seashark') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('seashark3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('submersible') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('submersible2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('suntrap') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('toro') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('toro2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('tropic') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('tropic2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('seasparrow') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dodo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('seabreeze') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('brickade') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 500000, myVeh)
											elseif vehicleHash == GetHashKey('ram2500') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('ram2500forg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('ram2500forggoose') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('ramlh20') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('contender') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('thauler') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('amv19') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('vantage') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('audirs6tk') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('240z') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('r8ppi') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('r32') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rs318') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('rs4avant') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('sq72016') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ttrs') then
												OpenCoffreInventoryMenu(GetVehicleNumberPateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('440i') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('450crf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('hcbr17') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('hdiron883') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('bmci') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('boss302') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gemera') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('outlaw1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('s2k') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sunrise') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('nicksultan') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodz350pandem') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodbacalar') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodcamaro') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodf40') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rmodgt63') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodjeep') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('rmodjesko') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('broncoc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('i8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('bmws') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('lumma750') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('m2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('m4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rmodm3e36') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodm4gts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('x5m2016') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('x6m') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('z4bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('2019chiron') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('bug09') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('hydrasport53tower') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 550000, myVeh)
											elseif vehicleHash == GetHashKey('hydrasport53') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 550000, myVeh)
											elseif vehicleHash == GetHashKey('bvit') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('fct') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('06tahoe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('13hilux') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 12000, myVeh)
											elseif vehicleHash == GetHashKey('hilux2013') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 12000, myVeh)
											elseif vehicleHash == GetHashKey('hoonitruck') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('13sls') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('14gtf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('70challenger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('71falcon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('falcontaxi') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('80series') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('2013tahoe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('20trailboss') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('21escalade') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('camaross') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g20c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('zl12017') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('300srt8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('c7') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('c7r') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('futo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('panto') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('warrener') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('488gtb') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlaeText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('675lt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlaeText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('720s') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlaeText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('2011hsv') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlaeText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('aperta') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('f812') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('gtoxx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('f8t') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('italia458') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('pista') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('primo4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('2016ranger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('raptor150') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('19raptor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('xr6ute') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ba') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('bc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('bdivo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('baikal') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('daemon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('rc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('hvrod') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('rcf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('f15078') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('fe86') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fgxr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fgute') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('frr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('gt17') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('nh2r') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('na6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('mst') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('mystic800') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fgt3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('fgt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('mustang19') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rmodmustang') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('14hsv') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('impala67') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('impalass') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dawnonyx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('16charger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('hqmonaro') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('hsvmaloo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('vess') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('vkss') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('vlwalky') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('civicsedan') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('civic') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('santafe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('veloster') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('seadoogti215') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('ftype') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('p7') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('92jeepcherokee') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('srt8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('stelvio') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('stockade4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('trailcat') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('koup') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('agerars') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('cv8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('regera') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rk2019') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('count5') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('lp610') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('lp700r') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('terzo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('zentenario') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('lex570') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('rmodamgc63') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodm5e34') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodmk7') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodmustang') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodpagani') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rmodsian') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('rmodsupra') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodz350pandem') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rmodzl1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rrphantom') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('sweptail') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('ghis2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gmt900escalade') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('mcgt4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sportsmanmud') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sorento19') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('mlmansory') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('mp412c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('p1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('senna') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('amggts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('e63amg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('e92') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('elegyx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g65amg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('mlbrabus') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('s3sedan') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('supra') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('slsamg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('soft92') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('silvia3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('w221s5000') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('f430s') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('cooperworks') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('05subleg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('acr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('acr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('ben17') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('benson3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('caracarase') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('demon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dodgert70') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dyna17') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('exc530') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('kx450f') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('kxf450') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('exc530sm') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('f4rr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('evora') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('evox') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('firebird') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('focusrs') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fordh') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fordhv2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('foxct') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fpace2017') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fpu') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('frontier4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('limocaddy') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('gtx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('hemicuda') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('hellion') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('peyote3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('club') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 20000, myVeh)
											elseif vehicleHash == GetHashKey('coquette4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('vstr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('imorgon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('retinue2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('Stafford') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('Cheburek') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 20000, myVeh)
											elseif vehicleHash == GetHashKey('kamacho') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('Hermes') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('Yosemite') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('trophytruck') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('kuruma') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('schafter3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('faction3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('faction2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('lurcher') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('buffalo2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dominator3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('drafter') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('paragon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('hilux1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('infinitig35') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('kiagt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('ktmx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('limocaddy') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('limoxts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('lykan') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('stelvio') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('subaruimpreza') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('subisti08') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('subwrx') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('suzukigv') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('svr16') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('viper') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('evolution6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('evo9mr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('kuruma') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('buccaneer2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('370z') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fontier4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('gtr7a') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gtr96') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('lwgtr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('nissantitan17') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('nspeedo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('outlander800r') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('patrold') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('qashqai16') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('r33') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('s15rb') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('skyline') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('slega') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('356ac') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('718boxster') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('718caymans') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('918') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('macan') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('macanturbo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('p911r') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('pajero83') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('panamera17turbo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('pturismo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rufrgt8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('wraith') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('adder') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('autarch') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('banshee2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('bullet') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('cheetah') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('cyclone') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('entityxf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('fmj') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('infernus') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('le7b') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('osiris') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('pfister811') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('prototipo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('reaper') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sc1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sheava') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('sultanrs') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('t20') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('turismor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('tyrus') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('vacca') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('visione') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('voltic') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('zentorno') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('r1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('r6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('baller2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('baller3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('cavalcade2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('dubsta') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('bcss') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('dubsta2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('buzzard2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('hmr1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('yellowfin') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 150000, myVeh)
											elseif vehicleHash == GetHashKey('sr510') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('fq2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('granger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gresley') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('huntley') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('landstalker') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateTex(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('mesa') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('mesa3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('patriot') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('radi') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rocoto') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rocoto') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('seminole') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('xls') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('teslax') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('tmodel') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('tr22') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('camry55') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('chevelle67') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('cc1') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gt86') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gt86q') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gt86rbc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gtcl') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('camv50') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('gt86') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('gt40') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('cbrr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('gsxr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('chingon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('gt86q') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('hilux99') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('jzx100') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('prius') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('rav4') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('boattrailer') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('pete352custom') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('phantomhd') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('flatbed') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 180000, myVeh)
											elseif vehicleHash == GetHashKey('rumpo3') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('r50') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('beetle74') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('fulux63') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('passat') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('patrol2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_omega') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_omega2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_camry') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_coloradop') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_colorados') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_fgute') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_fg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_evoke') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_hilux') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_hiluxp') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_coloradop') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_patrol') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_1200rt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('polgd_ter') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_lancer') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_falcon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_vfdiv') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_zbwagon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_sportswagon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_sorento') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_ranger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_rangerp') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_kluger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_santafe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_sor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_zbwagon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_stinger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polgd_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_xr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_fgxr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_vess') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_vicbmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_xr8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_x5') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_f6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_300c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_gts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_mustang') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polhwy_rptr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_1200rt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 2500, myVeh)
											elseif vehicleHash == GetHashKey('polshp_as365') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_aw139') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_kluger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polshp_x5') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_camry') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_camry50') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_colorado') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polum_evoke') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_gtf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_gtr') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_kluger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_expedition') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_vess') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_falcon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_sor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polum_xr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_lancer') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_xr8') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_300c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_pajero') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_rg') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_santafe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_sor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_sportswagon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polum_stinger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_vess') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_vicbmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polum_zb') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_colo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 12000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_as350') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_aw139') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_bearcat') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 400000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_bearcat2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 400000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_merc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_colorado') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_insurgent') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 400000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_raptor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('polspg_valkyrie') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polum_pajer') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_zb') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polum_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_colorado') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 12000, myVeh)
											elseif vehicleHash == GetHashKey('polum_stinger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('polum_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polum_kluger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_falcon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_rlvf') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_as350') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_as3502') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polafp_bell412') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('polvip_300c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polvip_bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polvip_fgxr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('polvip_x5') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('polvip_xr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('westpac_as350') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('westpac_aw139') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('westpac_bell412') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('westpac_mh65c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('trailerdump') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 650000, myVeh)
											elseif vehicleHash == GetHashKey('barracks') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 350000, myVeh)
											elseif vehicleHash == GetHashKey('w900') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 5000, myVeh)
											elseif vehicleHash == GetHashKey('gronos6x6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 340000, myVeh)
											elseif vehicleHash == GetHashKey('18f350ds') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 340000, myVeh)
											elseif vehicleHash == GetHashKey('colorado') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('colorado_tray') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('18f350dsb') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 340000, myVeh)
											elseif vehicleHash == GetHashKey('ems_13ambo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_20ambo') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_300c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('ems_1200rt') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('ems_as350') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('ems_aw139') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 10000, myVeh)
											elseif vehicleHash == GetHashKey('ems_colorado') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('ems_gts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('ems_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_mustang') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('ems_patrol') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_santafe') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_sor') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_ter') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('ems_zbwagon') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('fire_brush') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('fire_hilux') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('fire_htrescue') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_pajero') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_pumper') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_pumper2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_ranger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('fire_s64e') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fire_tanker') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 60000, myVeh)
											elseif vehicleHash == GetHashKey('fire_tanker2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_ter') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_trescue') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_trescue2') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('fire_vfsw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('fire_xr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_300c') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_bmw') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_camry') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_evoke') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_gts') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_hilux') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 120000, myVeh)
											elseif vehicleHash == GetHashKey('g6_iload') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('g6_lancer') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_lc') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('g6_patrol') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 80000, myVeh)
											elseif vehicleHash == GetHashKey('g6_stinger') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_vess') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_vfii') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_x5') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000, myVeh)
											elseif vehicleHash == GetHashKey('g6_xr6') then
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), 40000)
											else
												OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.TrunkSize[class], myVeh)
				  							end
											if Config.CameraAnimationTrunk == true then
												DeleteSkinCam()
												loadCamera(0, 3)
											end
										else
											exports['mythic_notify']:SendAlert('error', _U('trunk_closed'))
										end
									end
								end)
							end
						else
							exports['mythic_notify']:SendAlert('error', _U('trunk_closed'))
						end
					end
				else
					exports['mythic_notify']:SendAlert('error', _U('no_veh_nearby'))
				end
				lastOpen = true
				GUI.Time = GetGameTimer()
			end
		else
			exports['mythic_notify']:SendAlert('error', _U('nacho_veh'))
		end
	end
end
local count = 0
local isDead = false

AddEventHandler('iG:onPlayerDeath', function()
	isDead = true
end)


-- Key controls
Citizen.CreateThread(function()
  exports['ig-keybinds']:RegisterKeybind('OpenVehicleTrunk', 'Open Vehicle Trunk', 'G', OpenVehicleTrunk)
end)

OpenVehicleTrunk = function ()
  if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if (GetGameTimer() - GUI.Time) > 1000 then
            openTrunk()
            GUI.Time = GetGameTimer()
        end
    end
end
Citizen.CreateThread(
    function()
        while true do
            Wait(500)
            if lastVehicle ~= nil and DoesEntityExist(lastVehicle) then
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local vehicleCoords = GetEntityCoords(lastVehicle)
                local distance = GetDistanceBetweenCoords(coords, vehicleCoords, 1)

                if distance > 2.0 then
                    TriggerEvent("ig-inventory:closeInventory")
					SetVehicleDoorShut(lastVehicle, 5, false)
                end
            end
        end
    end
)
-- Citizen.CreateThread(function()
-- 	while true do
-- 	Wait(50)

-- 	if CloseToVehicle then
-- 		local playerPed = GetPlayerPed(-1)
-- 		local coords = GetEntityCoords(playerPed)
-- 		local vehicle = VehicleInFront()
		
-- 		if checkVehicle == 1 then open, vehBone = 4, GetEntityBoneIndexByName(vehicle, 'bonnet')
-- 		elseif checkVehicle == nil then open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') elseif checkVehicle == 2 then open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') else return end
		
-- 		local vehiclePos = GetWorldPositionOfEntityBone(vehicle, vehBone)
-- 		local pedDistance = GetDistanceBetweenCoords(vehiclePos, coords, 1)

-- 		local isClose = false
-- 		if (open == 5 and checkVehicle == nil) then if pedDistance < 5.0 then isClose = true end elseif (open == 5 and checkVehicle == 2) then if pedDistance < 5.0 then isClose = true end elseif open == 4 then if pedDistance < 5.0 then isClose = true end end
-- 		if DoesEntityExist(vehicle) and isClose then
-- 			CloseToVehicle = true
-- 		else
-- 			CloseToVehicle = false
-- 			lastOpen = false
-- 			ESX.UI.Menu.CloseAll()
-- 			SetVehicleDoorShut(lastVehicle, open, false)
-- 			lastVehicle = nil
-- 		end
-- 		end
-- 	end
--   end)

RegisterNetEvent("iG:playerLoaded")
AddEventHandler("iG:playerLoaded",function(xPlayer)
	-- PlayerData = xPlayer
	TriggerServerEvent("ig-inventory-trunk:getOwnedVehicle")
	-- lastChecked = GetGameTimer()
end)

function OpenCoffreInventoryMenu(plate, max, myVeh)
	ESX.TriggerServerCallback("ig-inventory-trunk:getInventoryV", function(inventory)
		text = _U("trunk_info", plate, (inventory.weight / 100), (max / 100))
		data = {plate = plate, max = max, myVeh = myVeh, text = text}
		TriggerEvent("ig-inventory:openTrunkInventory", data, inventory.blackMoney, inventory.cashMoney, inventory.items, inventory.weapons)
	end, plate)
end

function all_trim(s)
	if s then
		return s:match "^%s*(.*)":match "(.-)%s*$"
	else
		return "noTagProvided"
	end
end

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
		if type(k) ~= "number" then
			k = '"' .. k .. '"'
		end
		s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

RegisterNetEvent("ig-inventory:onClosedInventory")
AddEventHandler(
    "ig-inventory:onClosedInventory",
    function(type)
        if type == "trunk" then
            closeTrunk()
        end
    end
)

function closeTrunk()
    if lastVehicle ~= nil then
        SetVehicleDoorShut(lastVehicle, 5, false)
    end

    lastVehicle = nil
end
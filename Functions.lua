getgenv().pathfindingnotrunning = false
local Functions = {
    PlayerPosition = function(name)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        return rootPart.Position
    end,
    
    QuickTouchInterest = function(name, parttotouch, time)
        firetouchinterest(parttotouch, game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart"), 0)
        task.wait(time or 0.1)
        firetouchinterest(parttotouch, game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart"), 1)
    end,
    
    DistanceFromPlayer = function(name, part)
        local playerPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local partPosition = part.Position
        local distanceinstuds = (playerPosition - partPosition).Magnitude
        return math.ceil(distanceinstuds)
    end,
    
    Pathfinding = function(name, targetPosition)
        if not getgenv().pathfindingrunning then
            getgenv().pathfindingrunning = true
            local PFS = game:GetService("PathfindingService")
            local path = PFS:CreatePath()
            local test = game:GetService("Workspace"):WaitForChild(game:GetService("Players").LocalPlayer.Name)
            local hum = test:WaitForChild("Humanoid")
            local HRP = test:WaitForChild("HumanoidRootPart")
            local success, errorMsg = pcall(function()
            	path:ComputeAsync(HRP.Position, targetPosition)
            end)
            if success and path.Status == Enum.PathStatus.Success then
            	local waypoints = path:GetWaypoints()
            	for _, waypoint in pairs(waypoints) do
            		if waypoint.Action == Enum.PathWaypointAction.Jump and hum.Jump == false then
            			hum.Jump = true
            			wait()
            			hum.Jump = false
            		end
            		repeat
            		    hum:MoveTo(waypoint.Position)
            		until HRP.Position == waypoint.Position
            		if HRP.Position == targetPosition then
            			break
            		end
            	end
            elseif path.Status == Enum.PathStatus.NoPath then
            	print("No possible path")
            else
            	warn("Failed to compute path: ", errorMsg)
            end
            getgenv().pathfindingrunning = false
        end
    end
}
return Functions

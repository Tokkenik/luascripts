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
        local PathfindingService = game:GetService("PathfindingService")
        local Humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
        local Root = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local path = PathfindingService:CreatePath({
            AgentRadius = 1,
            AgentCanJump = true,
            AgentCanClimb = true,
            WaypointSpacing = math.huge,
        })
        path:ComputeAsync(Root.Position, targetPosition)
        local waypoints = path:GetWaypoints()
        for i, waypoint in ipairs(waypoints) do
            Humanoid:MoveTo(waypoint.Position)
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                Humanoid.Jump = true
            end
            Humanoid.MoveToFinished:Wait()
        end
    end,}
return Functions

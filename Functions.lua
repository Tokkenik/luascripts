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
        local Humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
        local Body = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local path = game:GetService("PathfindingService"):CreatePath({
        	AgentRadius = 1.5,
        	AgentHeight = 6,
        	AgentCanJump = true,
        	AgentCanClimb = true,
        	WaypointSpacing = 3,
        })
        path:ComputeAsync(Body.Position, targetPosition)
        if path.Status == Enum.PathStatus.Success then
           local wayPoints = path:GetWaypoints()
           for i = 1, #wayPoints do
               local point = wayPoints[i]
               Humanoid:MoveTo(point.Position)
               local success = Humanoid.MoveToFinished:Wait()
               if not success then
                   print("Trying to pathfind again...")
                   Humanoid.Jump = true
                   Humanoid:MoveTo(point.Position)
                   if not Humanoid.MoveToFinished:Wait() then
                       break
                   end
               end
           end
        end
    end,}
return Functions

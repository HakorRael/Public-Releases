--[[
	Hello! This spring module was originally made by BlackShibe but was FPS dependant so I (ONXXF on roblox, d9d3 on discord) edited it to make it work at any FPS
--]]

-- Services
local RunService = game:GetService('RunService')

-- Config
local Iterations = 8

-- Data
local last_Time = tick()
local curr_Delta = 0

-- Module
local SpringModule = {}

-- Functions
function SpringModule.Create(self, Mass, Force, Damping, Speed)
	local Spring = {
		Target      = Vector3.new(),
		Position    = Vector3.new(),
		Velocity    = Vector3.new(),

		Mass        = Mass or 5,
		Force       = Force or 50,
		Damping     = Damping or 4,
		Speed       = Speed  or 4,
	}
	
	function Spring.Shove(self, Force)
		local X, Y, Z = Force.X, Force.Y, Force.Z
		
		if X ~= X or X == math.huge or X == -math.huge then
			X = 0
		end
		
		if Y ~= Y or Y == math.huge or Y == -math.huge then
			Y = 0
		end
		
		if Z ~= Z or Z == math.huge or Z == -math.huge then
			Z = 0
		end
		
		local EndVector = Vector3.new(X, Y, Z)
		self.Velocity = self.Velocity + (curr_Delta * 60) * EndVector -- * (reelDelta * 60)
	end

	function Spring.Update(self, Delta)
		local ScaledDeltaTime = Delta * self.Speed / Iterations -- math.min(Delta, 1) *
		curr_Delta = Delta
		
		for Index = 1, Iterations do
			local IterationForce = self.Target - self.Position
			local Acceleration = (IterationForce * self.Force) / self.Mass

			Acceleration = Acceleration - self.Velocity * self.Damping

			self.Velocity = self.Velocity + Acceleration * ScaledDeltaTime
			self.Position = self.Position + self.Velocity * ScaledDeltaTime
		end

		return self.Position
	end

	return Spring
end

-- Return
return SpringModule

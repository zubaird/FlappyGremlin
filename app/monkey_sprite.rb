class MonkeySprite < Joybox::Physics::PhysicsSprite

	def initialize(world)
		@world = world
		x = Screen.width / 2
		y = 200
		@player_body = @world.new_body(
			position: [x, y],
			type: Body::Dynamic,
			fixed_rotation: true
		) do
			polygon_fixture(
				box: [18 / 4, 60 / 4],
				friction: 0.05,
				density: 10.5
			)
		end
		super file_name: 'monkey.png', body: @player_body
		@alive = true
	end

	def alive?
		@alive
	end


	def jump(playerlocation, touchlocation)
		@playerlocation = playerlocation
		@touchlocation = touchlocation 

		if alive?
			if @playerlocation < @touchlocation
				self.body.apply_force force:[50,200]
			elsif @playerlocation > @touchlocation
				self.body.apply_force force:[-50,200]
			else
				self.body.apply_force force:[0,200]
			end
		end
	end


	def die
		@alive = false
		self.run_action Blink.with times: 50
	end


	def current_position
		@player_body.position
	end



end
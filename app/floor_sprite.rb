class FloorSprite < Joybox::Physics::PhysicsSprite

	def initialize(world) 
		@world = world
		@floor = @world.new_body(
			position: [175,-200],
			type: Body::Kinematic) do
				circle_fixture radius: 370,
								density: -5.0,
								friction: 0.5,
								restitution: 0.5,
								gravity_scale: 0,
								fixed_rotation: true
		end

		super file_name: 'jet_engine.png', body: @floor
		
	end


	def keep_moving
		
		self.body.apply_force force:[0,0]
		self.body.angular_velocity = 2
		# self.linear_velocity = [0,0]

	end


end
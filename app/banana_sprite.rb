class BananaSprite < Joybox::Core::Sprite

	

	def initialize

		super file_name: "banana.png"
		x = Screen.width
		random_spawn = 225 + rand(250)
		y = random_spawn
		self.position = [x,y]
		
	end

	def banana_position
		self.position
	end

	def move_banana
		x = Screen.width
		y = self.position.y
		self.run_action Move.to position: [-x,y], duration: 9.0
	end

	def die
		self.run_action Blink.with times: 10, duration: 1.5
		self.run_action Move.to position: [0,-100000]
	end


end
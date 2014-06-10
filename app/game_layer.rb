class GameLayer < Joybox::Core::Layer

  attr_reader :player
  
  def on_enter
  	
  	
  	load_background
  	load_world
  	load_player
  	load_controls
  	game_loop
  	load_floor
  	# load_update_position_label (FOR DEBUGGING)
  	# load_update_banana_position_label (FOR DEBUGGING)
  	load_banana
  	load_score_label
  end


private


# => CONTROLS
    def load_controls
    	@player = MonkeySprite.new(@world)
		self << @player
		on_touches_began do |touches, event|
		touch = touches.any_object
		  touches.each do |touch|
		    # location = touch.locationInView(touch.view)
		    @playerlocation = @player.current_position.x.to_int
		    @touchlocation = touch.location.x.to_int
		    @player.jump(@player.current_position.x.to_int, @touchlocation)
		  end
		end
	end

# => BACKGROUND
	def load_background
   	    @sky = LayerColor.new color: "#4FBEEB".to_color
   	    @bg = Sprite.new file_name: "bg_image2.png", position: [Screen.width - 275 , Screen.height - 75]
    	self << @sky
    	self << @bg
	end

# => WORLD
	def load_world
		@world =  World.new(gravity:[0,-9.8])
	end


# => LOAD PLAYER
	def load_player

	end

	def load_banana
		# @banana = BananaSprite.new
		@banana = BananaSprite.new
		# super file_name: 'banana.png'
		self << @banana
		@banana.move_banana
	end

	def load_floor
		@floor = FloorSprite.new(@world)
		self << @floor
	end


# => GAME LOOP
	def game_loop
		schedule_update do |delta|

			@update_x = @player.current_position.x.to_int
			@update_y = @player.current_position.y.to_int

			@banana_x = @banana.banana_position.x.to_int
			@banana_y = @banana.banana_position.y.to_int

			update_position(@update_x,@update_y)

			spawn_banana

			update_banana_position(@banana_x,@banana_y)

			banana_collision

			update_score(@score)

			# => FOR DEBUGGING
			# if banana_on_screen(@banana_x, @banana_y)
			# else
			# 	load_banana
			# 	# @world.destroy_body @banana
			# end

			if @player.alive? && on_screen(@update_x,@update_y)
				@world.step delta: delta
				@floor.keep_moving	
			else 
				game_over
			end
		end
	end

	def game_over
		Joybox.director.stop_animation
		Joybox.director.replace_scene GameOverLayer.scene
	end


# => LABELS FOR GREMLIN MONKEY

	# def load_update_position_label  (FOR DEBUGGING)

	# 	@labelbox = Label.new(
	# 		text: "#{@curent_position_x}, #{@current_position_y}",
	# 		font_size: 20,
	# 		color: Color.new(255,255,255),
	# 		position: [Screen.width, Screen.half_height]
	# 		)
	# 	self << @labelbox
	# end

	def update_position(x,y)
		@current_position_x = x
		@current_position_y = y
		# @labelbox.text = "#{@current_position_x}, #{@current_position_y}"
	end

	def load_score_label
		@score = 0
		@scorebox = Label.new(
			text: "Score: #{@score}",
			font_size: 30,
			color: Color.new(0,0,0),
			position: [ Screen.half_width, Screen.height - 50])
		self << @scorebox
	end

	def update_score(score)
		@score = score
		@scorebox.text = "Score: #{@score}"
	end

	def on_screen(horizontal, vertical)
		if horizontal > 0 && vertical > 0 && vertical < Screen.height && horizontal < Screen.width
			return true
		else
			return false
		end
	end


# => BANANA ACTIONS

	# def load_update_banana_position_label (FOR DEBUGGING)
	# 	@bananalabelbox = Label.new(
	# 		text: "#{@curent_position_x}, #{@current_position_y}",
	# 		font_size: 40,
	# 		color: Color.new(255,255,255),
	# 		position: [Screen.width, 400]
	# 		)
	# 	self << @bananalabelbox
	# end

	def update_banana_position(x,y)
		@current_position_x = x
		@current_position_y = y
		# @bananalabelbox.text = "#{@current_position_x}, #{@current_position_y}" (FOR DEBUGGING)
	end

	def spawn_banana

		if banana_eaten?
			load_banana
		elsif banana_escape?
			@player.die
		end

	end


	def banana_on_screen(horizontal, vertical)
		if vertical > 0
			return true
		else 
			return false
		end
	end

	def banana_eaten?
		@banana_y < 0
	end

	def banana_escape?
		@banana_x < 0
	end

	def banana_collision
		if CGRectIntersectsRect(@banana.bounding_box, @player.bounding_box)
			@banana.die
			@score += 100
		end
	end


# => EXPERIMENTAL
	def set_viewpoint_center(position)

		x = [position.x, Screen.width / 2 ].max
		y = [position.y, Screen.height / 2 ].max
		viewPoint = Screen.center + 3

	end


end
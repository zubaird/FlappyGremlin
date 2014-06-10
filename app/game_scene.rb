class GameScene < Joybox::Core::Scene

	def on_enter
		@bg = BackgroundLayer.new
		self << @bg

		@game_layer = GameLayer.new
		self << @game_layer
	end

end

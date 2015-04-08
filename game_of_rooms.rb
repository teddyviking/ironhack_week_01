require 'pry'
class Game
	attr_reader :rooms, :character, :reader
	attr_accessor :win_condition


	def initialize(*rooms)
		@rooms ={}
		@allowed_values = %w(N E S W sing quit)
		@win_condition = false

		rooms.each do |room|
			@rooms[room.name] = room
		end
		
	end

	def init_game
		create_character
		until @win_condition == true
			display_current_location
			apply_action(get_user_input)
		end
		get_end_of_game
	end

	def create_character
		@character = Character.new(Room.new)
	end

	def display_current_location
		puts @character.location.description
	end

	def get_user_input
		puts "a>"
		user_input = ""
		until @allowed_values.include?(user_input)
			puts "Sorry. You can't do this" if user_input != ""
			user_input = gets.chomp	
		end
		user_input
	end

	def get_end_of_game
		puts "THE END"
	end

	def apply_action(user_input)
		action = select_action(user_input)
		# action.valid?
		make_action(action, user_input)
		
	end
	def select_action(user_input)
		case user_input
		when "N" || "E" || "S" || "W"	
			return "move"
		when "sing"
			return "sing"
		when "quit"
			puts "You have left the game"
			exit
		end
	end
	def make_action(action, user_input)
		p action
		if action == "sing"
			@character.sing(@character.location)
		elsif action == "move"
			new_room = get_new_room(user_input, @character.location)
			@character.move(new_room)
			# set_new_allowed_values
		end
	end

	def get_new_room (user_input, current_room)
		
		new_location = current_room.location
		case user_input
		when "N"	 
			 new_location[:y] +=1
		when "E"
			new_location[:x] +=1
		when "S"
			new_location[:y] -=1
		when "W"
			new_location[:x] -=1
		end
		new_room = @rooms.select do |name, room|
			room.location == new_location
		end
		return new_room.to_a[0][1]
	end

	# def set_new_allowed_values
	# 	@allowed_values = []
		
	# end
end

class Character
	attr_reader :name, :location

	def initialize(room)
		@name = "Pedro"
		@location = room
		
	end

	
	def move (new_room)
		@location = new_room
	end

	def sing(room)
		puts room.responses_to_actions[:sing]
	end

end

class Room
	attr_reader :description, :name, :location, :available_moves, :responses_to_actions

	def initialize(name="Kitchen", x=2, y=1, description="You are in ", available_moves=["N","E"] )
		@name = name
		@description = description + @name
		@available_moves = available_moves
		@responses_to_actions = {sing: "Some windows break because of your dreadful voice"}
		@location ={x: x, y: y}
	end
	

end

living_room = Room.new("Living Room", 2, 2)
hall = Room.new("Hall", 3, 1)

game = Game.new(living_room, hall)
game.init_game











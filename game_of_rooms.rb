require 'pry'
class Game
	attr_reader :rooms, :character, :reader
	attr_accessor :win_condition


	def initialize(*rooms)
		@rooms ={}
		@allowed_values = []
		@win_condition = false

		rooms.each do |room|
			@rooms[room.name] = room
		end
		
	end

	def init_game
		create_character
		set_allowed_values
		until @win_condition == true
			display_current_location
			apply_action(get_for_input)
		end
		get_end_of_game
	end

	def create_character
		@character = Character.new(Room.new)
	end

	def display_current_location
		puts @character.location.description
	end

	def get_for_input
		puts "a>"
		user_input = ""
		until @allowed_values.include?(user_input)
			user_input = ask_user_input(user_input)
		end
		user_input
	end

	def ask_user_input(user_input)
		puts "Sorry. You can't do this" if user_input != ""
		return gets.chomp.downcase.to_sym
	end

	def get_end_of_game
		puts "THE END"
	end

	def apply_action(user_input)
		make_action(user_input)
	end
	def make_action(user_input)
		movements = [:n, :e, :w, :s]
		if movements.include?(user_input)					
			input = user_input.to_s.upcase
			new_room = get_new_room(input, @character.location)
			get_method_to_call(user_input).call(@character.move(new_room))
			set_allowed_values
		end

		case user_input
		when :sleep
			get_method_to_call(user_input).call		
		when :sing
			get_method_to_call(user_input).call		
		when :quit
			puts "You have left the game"
			exit
		end
	end
	
	def get_method_to_call(user_input)
		@character.location.responses_to_actions[user_input]
	end
	#this method doesn't belong here
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

	def set_allowed_values
		@allowed_values = []
		@character.location.responses_to_actions.each do |key, value|
			@allowed_values << key
		end
		p @allowed_values
	end
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

	def initialize(name="Kitchen", x=2, y=1, description="You are in ")
		@name = name
		@description = description + @name
		@responses_to_actions = {
			quit: "exit",
			n: response_to_north,
			e: response_to_east,
			sing: response_to_sing,
			sleep: response_to_sleep
		}
		@location ={x: x, y: y}
	end

	def response_to_sleep
		proc {puts "ZZZZZZ"}
	end

	def response_to_sing
		proc {puts "You sing out loud and some windows break"}
	end

	def response_to_north
		lambda {|param| puts param}
	end
	def response_to_east
		lambda {|param| puts param}
	end

end

living_room = Room.new("Living Room", 2, 2)
hall = Room.new("Hall", 3, 1)

game = Game.new(living_room, hall)
game.init_game











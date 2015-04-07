require 'pry'
class Game
	attr_reader :rooms, :character

	def initialize(*rooms)
		@rooms ={}

		rooms.each do |room|
			@rooms[room.name] = room
		end
		
	end

	def init_game
		@character = Character.new(Room.new)
		puts @character.location.description
		apply_action(get_user_input)
		puts @character.location.description
	end

	def get_user_input
		puts "a>"
		user_input = ""
		possible_moves = @character.location.available_moves
		until possible_moves.include?(user_input)
			puts "Sorry. You can't go this way" if user_input != ""
			user_input = gets.chomp.upcase	
		end
		user_input
	end

	def apply_action(user_input)
		new_room = get_new_room(user_input, @character.location)
		@character.move(new_room)
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

end

class Room
	attr_reader :description, :name, :location, :available_moves

	def initialize(name="Kitchen", x=2, y=1, description="Estás en ", available_moves=["N","E"] )
		@name = name
		@description = description + @name
		@available_moves = available_moves
		@location ={x: x, y: y}
	end
	
end

living_room = Room.new("Living Room", 2, 2)
hall = Room.new("Hall", 3, 1)

game = Game.new(living_room, hall)
game.init_game











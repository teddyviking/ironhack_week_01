require 'pry'

class ShoppingCart
	attr_reader :items

	def initialize
		@items = Hash.new { |hash, key| hash[key] = 1 }

		
	end
	def add(item, *quantity)
		quantity == [] ? @items[item] : @items[item] = quantity[0]

	end

	def cost

	end
end

class Item
	attr_reader :name
	def initialize(name)
		@name = name
	end
end

class PriceList
	def initialize
		@objects = {
			apples: 10,
			oranges: 5,
			banana: 20,
			watermelon: 50,
			rice: 1,
			vacuum_cleaner: 150,
			anchovies: 2
		}
	end
end









cart = ShoppingCart.new
price_list = PriceList.new
apple = Item.new("apple")
banana = Item.new("banana")

cart.add apple
cart.add banana
binding.pry
cart.cost 
#=> 30
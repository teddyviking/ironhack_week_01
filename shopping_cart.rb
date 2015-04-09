require 'pry'

class ShoppingCart
	attr_reader :items

	def initialize
		@items = Hash.new { |hash, key| hash[key] = 1 }
		
	end
	def add(item, *quantity)
		@items[item] = quantity

	end
end

class Item
	attr_reader :kind
	def initialize(kind)
		@kind = kind
	end
end










cart = ShoppingCart.new
apple = Item.new("apple")
banana = Item.new("banana")

cart.add apple
cart.add banana
binding.pry
cart.cost 
#=> 30
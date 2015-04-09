require 'pry'

class ShoppingCart
	attr_reader :items

	def initialize(prices)
		@items = Hash.new { |hash, key| hash[key] = 1 }
		@prices = prices

		
	end
	def add(item, *quantity)
		quantity == [] ? @items[item] : @items[item] = quantity[0]

	end

	def cost
		final_prices = set_final_prices
		puts sum_prices(final_prices)
	end

	def set_final_prices
		@items.merge(keep_present_prices) do |key, oldval, newval|
			oldval * newval
		end
		
	end

	def keep_present_prices
		@prices.objects.keep_if do |key, value|
			@items.keys.map{|key| key.name}.include?(key)
		end
		
	end

	def sum_prices(items)
		items.reduce(0) do |sum, (key, value)|
			sum += value
		end
	end
end

class Item
	attr_reader :name
	def initialize(name)
		@name = name.to_sym
	end
end

class PriceList
	attr_reader :objects
	def initialize
		@objects = {
			apple: 10,
			orange: 5,
			banana: 20,
			watermelon: 50,
			rice: 1,
			vacuum_cleaner: 150,
			anchovies: 2
		}
	end
end





cart = ShoppingCart.new(PriceList.new)
apple = Item.new("apple")
banana = Item.new("banana")

cart.add apple
cart.add banana

cart.cost 
binding.pry
puts "Frase chorra para pry: Elija la suya favorita"
#=> 30
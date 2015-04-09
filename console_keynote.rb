require 'pry'

class Keynote
	attr_reader :slides

	def begin_presentation
		
	end

	def get_slides
		
	end

	def select_slide
		
	end

	def display_slide
		
	end

	def change_slide
		
	end
end

class Slide
	attr_reader :text

	def get_text(slides)
		
	end

	def format_text
		
	end

end

class SlideCreator
	def initialize(file)
		@slides = split_simple_txt(file)
	end

	def split_simple_txt(file)
		slides = File.read(file).split(/\n/) - [""]
		return slides
	end
end

 iterminal = SlideCreator.new("keynote.txt")

binding pry
puts "Frase chorra para que pry funcione"






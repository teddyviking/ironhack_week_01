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

	def initialize(text)
		@text = text
	end
	
	def get_text(slides)
		
	end

	def format_text
		
	end

end

class SlidesCreator
	attr_reader :slides
	def initialize(file)
		@slides = create_slides(file)
	end
	def create_slides(file)
		splitted_text = split_simple_txt(file)
		slides = []
		splitted_text.each {|fragment| slides << Slide.new(fragment)}
		slides
	end

	def split_simple_txt(file)
		splitted_text = File.read(file).split(/\n/) - [""]
		return splitted_text
	end

end

 iterminal = SlidesCreator.new("keynote.txt")

binding pry
puts "Frase chorra para que pry funcione"






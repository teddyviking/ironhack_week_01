require 'pry'
require 'terminfo'

class Keynote
	attr_reader :slides, :current_slide

	def initialize(slides)
		@slides = slides
		@current_slide = 0
	end

	def start_presentation
		display_slide(0)
		get_action
	end

	def display_slide(slide_number)
		slide = select_slide(slide_number)
		get_format(slide)
		@current_slide = slide_number
	end

	def select_slide(slide_number)
		@slides[slide_number]
	end

	def get_format(slide)
		slide.format_text
	end

	def get_action
		input = gets.chomp
		if input == "previous" || input == "next" 
			change_slide(input)
			get_action
		elsif input == "exit"
			exit
		end	
				
	end

	def change_slide(input)
		if input == "next" && @current_slide < (@slides.size - 1)
			display_slide(@current_slide + 1)
		elsif input == "previous" && @current_slide > 0
			display_slide(@current_slide - 1)
		elsif input == "next" && @current_slide == (@slides.size - 1)
			exit			
		end		
	end
end

class Slide
	attr_reader :text

	def initialize(text)
		@text = text
	end

	def format_text
		screen_size = TermInfo.screen_size
		system('clear')
		print "\n" * (screen_size[0]/2) 
		puts @text.center(screen_size[1])
		print "\n" * (screen_size[0]/2)
	end
end

class SlidesExtractor
	attr_reader :slides
	def initialize(file)
		@slides = create_slides(file)
	end
	def create_slides(file)
		splitted_text = split_simple_txt(file)
		slides = splitted_text.map {|fragment| Slide.new(fragment)}
	end

	def split_simple_txt(file)
		File.read(file).split(/\n/) - [""]
		splitted_text
	end

end

keynote = Keynote.new(SlidesExtractor.new("keynote.txt").slides)

keynote.start_presentation


puts "Frase chorra para que pry funcione"






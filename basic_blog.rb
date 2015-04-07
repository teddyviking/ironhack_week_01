require 'pry'
require 'colorize'

class Blog
	attr_accessor :posts
	attr_reader :current_page_number

	def initialize(*posts)
		@posts = posts
		@pages = []
		@current_page_number = 0

		sort_posts(posts)
		create_pages(posts)
		publish_front_page(@pages[@current_page_number])
	end


	def publish_front_page(page)
		page.each{|post| give_format(post)}
		add_numeration
		ask_user_for_action
	end

	def add_numeration
		index_of_pages = []
		@pages.each_index{|i| index_of_pages << (i + 1) }
		# p index_of_pages
		colorize_current_page(index_of_pages)
		puts "Pages: " + index_of_pages.join(' ')
	end

	def colorize_current_page(index_of_pages)
		index_of_pages.map! do |page_number|
			page_number = page_number.to_s
			if page_number  == (@current_page_number + 1).to_s
				page_number = page_number.colorize(:blue)
			else
				page_number
			end
		end
	end

	def ask_user_for_action
		user_input = get_user_input
		if user_input == "next" && @current_page_number != @pages.index(@pages.last)
			advance_page
		elsif user_input == "prev" && @current_page_number != @pages.index(@pages.first)
			drop_page
		end
	end

	def get_user_input
		puts "What do you want to do? (NEXT, PREV, EXIT)"
		user_input = gets.chomp.downcase
	end


	def advance_page
		@current_page_number += 1
		publish_front_page(@pages[@current_page_number])
	end 

	def drop_page
		@current_page_number -= 1
		publish_front_page(@pages[@current_page_number])
	end



	private

	def sort_posts(posts)
		posts.sort!{|post1, post2| post2.date <=> post1.date}
	end

	def create_pages(posts)	
		i = 0
		page = []
		posts.each do |post|
			page << post
			i += 1
			if i % 3 == 0
				@pages << page
				page = []
			elsif post == posts.last
				@pages << page		
			end
		end
	end

	def give_format(post)
		if post.sponsor
			puts '******' + post.title + '******'
		else
			puts post.title
		end
		puts '********************'
		puts post.text
		puts '--------------------'
	end
end


class Post
	attr_accessor :title, :text, :sponsor
	attr_reader :date

	def initialize
		@date = Time.now
	end

	def is_sponsored?
		return true if @sponsor
	end
end



post1 = Post.new
post1.title = "1. Hello World!"
post1.text = "Because everything is wonderful"
post1.sponsor = true
post2 = Post.new
post2.title = "2. Goodbye World!"
post2.text = "I don't love you any more"
post3 = Post.new
post3.title = "3. Not everything is lost"
post3.text = "It's the third post"
post3.sponsor = true
post4 = Post.new
post4.title = "4. Do you believe in sheeps?"
post4.text = "I'm not creating more posts"


blog = Blog.new(post1, post2, post3, post4)

# puts "\n\n\nWhat do you want to do? \n (NEXT, PREV, EXIT) \n\n\n\n\n".colorize(:red)
# user_input = gets.chomp.downcase
# if user_input == "next" && @current_page_number != @pages.index(@pages.last)
# 		advance_page
# 	elsif user_input == "prev" && @current_page_number != @pages.index(@pages.first)
# 		drop_page
# 	end

# blog.advance_page


puts "THE END"



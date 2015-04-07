require 'pry'
require 'colorize'

class Blog
	attr_accessor :posts
	attr_reader :current_page, :total_pages

	def initialize
		@posts = []
		@current_page = 0
	end

	def create_front_page(posts)
		sort_posts(posts)
		i = 0
		page = []
		posts.each do |post|
			page << post
			i += 1
			if i % 3 == 0
				@posts << page
				page = []
			elsif post == posts.last
				@posts << page		
			end
		end
	end

	def publish_front_page(*posts)
		create_front_page(posts)
		@posts[@current_page].each do |post|	
			if post.sponsor
				puts '******' + post.title + '******'
			else
				puts post.title
			end
			puts '********************'
			puts post.text
			puts '--------------------'
		end
		pages = @posts.map{|page| @posts.index(page) + 1}
		pages.map! do |page| 
			page = page.to_s
			if page == (@current_page + 1).to_s
				page = page.colorize(:blue)
			else
				page
			end
			
		end
		puts "Pages: " + pages.join(' ')
	end

	def advance_page
		@current_page += 1
	end 

	def drop_page
		@current_page -= 1
	end


	private

	def sort_posts(posts)
		posts.sort!{|post1, post2| post2.date <=> post1.date}
	end

end


class Post
	attr_accessor :title, :text, :sponsor
	attr_reader :date

	def initialize
		@date = Time.now
	end
end

blog = Blog.new

post1 = Post.new
post1.title = "1. Hello World!"
post1.text = "Because everything is wonderful"
post1.sponsor = true
post2 = Post.new
post2.title = "2. Goodbye World!"
post2.text = "I don't love you any more"
post3 = Post.new
post3.title = "3"
post3.text = "It's the third post"
post4 = Post.new
post4.title = "4"
post4.text = "I'm not creating more posts"


blog.publish_front_page(post1, post2, post3, post4)
blog.advance_page
blog.publish_front_page(post1, post2, post3, post4)


puts "THE END"

require 'pry'

class Blog
	attr_accessor :posts
	def initialize
		@posts = []
	end
	def create_front_page(posts)
		sort_posts(posts)
		posts.each do |post|
			@posts << post
		end
	end

	def publish_front_page(*posts)
		create_front_page(posts)
		@posts.each do |post|
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
post1.title = "Hello World!"
post1.text = "Because everything is wonderful"
post1.sponsor = true
post2 = Post.new
post2.title = "Goodbye World!"
post2.text = "I don't love you any more"


blog.publish_front_page(post1, post2)
binding.pry


puts "THE END"

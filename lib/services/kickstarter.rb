require 'rest_client'

class Kickstarter
	
	def fetch
		begin
			term = "social"
			query="http://www.kickstarter.com/projects/search.json?search=&term="
			res = RestClient.get(query + term)
			dir = self.tmp_dir
			# Dump the data in some temp file 
			unless File.directory?(dir)
				self.create_tmp_dir
			end
			date = Date.today
			filename = "#{term}-#{date.day }-#{date.month}-#{date.year}"
			File.open("#{dir}/#{filename}", 'a+') do |f| 
				f.write(res) 
			end
			#ActiveSupport::JSON.decode(res)
		rescue
			return {}
		end
	end

	
	def tmp_dir
		"#{Rails.root}/lib/services/tmp_data/#{self.class}"
	end

	def create_tmp_dir
		dir = self.tmp_dir
		FileUtils.mkdir_p dir
	end
end

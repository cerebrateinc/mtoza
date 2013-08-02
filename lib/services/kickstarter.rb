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
			#
		rescue
			return {}
		end
	end

	def create
		# Read all files
		dir = self.tmp_dir
		files = Dir["#{dir}/*"]
		files.each do |file|
			File.open(file) do |f|
				res = ActiveSupport::JSON.decode(f.read()) 
				puts res.inspect				
				projects = res["projects"]
				projects.each do |project|
					ks = KickstarterProject.find_by_uid(project['id'])
					unless ks
						ks = KickstarterProject.new
					end
					puts project['deadline']
					params = {
						:uid => project['id'],
						:name => project['name'],
						:goal => project['goal'],
						:pledged => project['pledged'],
						:state => project['state'],
						:country => project['country'],
						:creator => project['creator'].to_json,
						:deadline => DateTime.strptime(project['deadline'].to_s,'%s'), 
						:project_launched_at => DateTime.strptime(project['launched_at'].to_s,'%s'),
						:project_created_at => DateTime.strptime(project['created_at'].to_s,'%s'),
						:backers_count => project['backers_count'],
						:location_str => project['location'].to_json,
						:category_str => project['category'].to_json
					}
					ks.update_attributes(params)
					File.delete(f)
				end
			end
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

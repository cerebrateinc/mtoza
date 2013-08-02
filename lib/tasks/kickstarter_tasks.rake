namespace :kickstarter do
	desc "Rake task to import data from Kickstarter"
	task :fetch => :environment do
		ks = Kickstarter.new
		ks.fetch
	end

	task :import => :environment do
		ks = Kickstarter.new
		ks.create
	
	end
end
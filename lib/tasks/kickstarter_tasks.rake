namespace :kickstarter do
	desc "Rake task to import data from Kickstarter"
	task :import => :environment do
		puts Rails.env
		ks = Kickstarter.new
		ks.fetch
	end
end
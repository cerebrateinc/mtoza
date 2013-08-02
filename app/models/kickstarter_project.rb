class KickstarterProject < ActiveRecord::Base
  attr_accessible :uid, :name, 
  				  :goal, :pledged, :state, 
  				  :country, :creator, :deadline, :project_launched_at, 
  				  :project_created_at, :backers_count, :location_str, :category_str

end

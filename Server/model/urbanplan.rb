class UrbanPlan

	attr_accessor :urbanPlanId
	attr_accessor :name
	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :zoom
	attr_accessor :tilesets

	def initialize(row)
		self.urbanPlanId = row[0].to_s
		self.name = row[1].to_s
		self.latitude = row[2].to_s
		self.longitude = row[3].to_s
		self.zoom = row[4].to_s
	end

	def to_json(options = {})
		return JSON.pretty_generate({
			'urbanPlanId' => @urbanPlanId,
			'name' => @name,
			'latitude' => @latitude,
			'longitude' => @longitude,
			'zoom' => @zoom,
			'tilesets' => @tilesets
		}, options)
	end

end
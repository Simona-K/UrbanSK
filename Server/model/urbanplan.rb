class UrbanPlan

	attr_accessor :tilesetid
	attr_accessor :grouping
	attr_accessor :name
	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :zoom
	attr_accessor :released

	def initialize(row)
		self.tilesetid = row[0].to_s
		self.grouping = row[1].to_s
		self.name = row[2].to_s
		self.latitude = row[3].to_s
		self.longitude = row[4].to_s
		self.zoom = row[5].to_s
		self.released = row[6].to_s
	end

	def to_json(options = {})
		return JSON.pretty_generate({
			'tilesetid' => @tilesetid,
			'grouping' => @grouping,
			'name' => @name,
			'latitude' => @latitude,
			'longitude' => @longitude,
			'zoom' => @zoom,
			'released' => @released
		}, options)
	end

end
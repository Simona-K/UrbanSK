class Tileset

	attr_accessor :tilesetId
	attr_accessor :urbanPlanId
	attr_accessor :name
	attr_accessor :released

	def initialize(row)
		self.tilesetId = row[0].to_s
		self.urbanPlanId = row[1].to_s
		self.name = row[2].to_s
		self.released = row[3].to_s
	end

	def to_json(options = {})
		return JSON.pretty_generate({
			'tilesetId' => @tilesetId,
			'urbanPlanId' => @urbanPlanId,
			'name' => @name,
			'released' => @released
		}, options)
	end

end
require 'sqlite3'
require 'base64'
require_relative 'queries'
require_relative '../model/urbanplan'
require_relative '../model/tileset'

class Database

  def initialize
    @db = SQLite3::Database.new('data/database.sqlite3')
    @queries = Queries.new
  end

  def createUrbanPlansTable
    @db.execute @queries.createUrbanPlansTable
  end

  def createTilesetsTable
    @db.execute @queries.createTilesetsTable
  end

  def urbanPlans
    urbanPlanRows = @db.execute @queries.urbanPlans
    puts "Urban plans"
    puts urbanPlanRows.count
    urbanPlans = Array.new
    urbanPlanRows.each do |urbanPlanRow|
      urbanPlan = UrbanPlan.new(urbanPlanRow)

      tilesetRows = @db.execute @queries.tilesets(urbanPlan.urbanPlanId)
      puts "Tilesets for urban plan %{urbanPlanId}"
       puts tilesetRows.count
      tilesets = Array.new
      tilesetRows.each do |tilesetRow|
        tileset = Tileset.new(tilesetRow)
        tilesets.push(tileset)
      end
      urbanPlan.tilesets = tilesets
      urbanPlans.push(urbanPlan)
    end
    resultHash = Hash["urbanPlans"=>urbanPlans]
    return resultHash
  end

end
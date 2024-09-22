require 'sqlite3'
require 'base64'
require_relative 'queries'
require_relative '../model/urbanplan'

class Database

  def initialize
    @db = SQLite3::Database.new('data/database.sqlite3')
    @queries = Queries.new
  end

  def createUrbanPlans
    @db.execute @queries.createUrbanPlans
  end

  def urbanPlans
    rows = @db.execute @queries.urbanPlans
    puts rows.count
    urbanPlans = Array.new
    rows.each do |row|
      urbanPlan = UrbanPlan.new(row)
      urbanPlans.push(urbanPlan)
    end
    resultHash = Hash["urbanPlans"=>urbanPlans]
    return resultHash
  end

end
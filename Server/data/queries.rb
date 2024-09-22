require 'sqlite3'
require_relative '../model/urbanplan'
require_relative '../model/tileset'

class Queries

  # Urban plans

  def urbanPlans
    return <<-SQL
      select * from urbanPlans order by name
    SQL
  end

  def urbanPlan(urbanPlanId)
    return <<-SQL
      select * from urbanPlans where urbanPlanId="#{urbanPlanId}"
    SQL
  end

  def dropUrbanPlansTable
    return <<-SQL
      drop table if exists urbanPlans;
    SQL
  end

  def createUrbanPlansTable
    return <<-SQL
      create table urbanPlans (
        urbanPlanId varchar(100),
        name varchar(100),
        latitude varchar(100),
        longitude varchar(100),
        zoom varchar(100)
      );
    SQL
  end

  def addUrbanPlan(urbanPlan, database)
    statement = database.prepare <<-SQL
      insert into urbanPlans (
      urbanPlanId,
      name,
      latitude,
      longitude,
      zoom
      ) values (?,?,?,?,?)
    SQL

    statement.execute urbanPlan.urbanPlanId,
                      urbanPlan.name,
                      urbanPlan.latitude,
                      urbanPlan.longitude,
                      urbanPlan.zoom
    statement.close
  end

  # Tilesets

  def tilesets
    return <<-SQL
      select * from tilesets order by name
    SQL
  end

  def tilesets(urbanPlanId)
    return <<-SQL
      select * from tilesets where urbanPlanId="#{urbanPlanId}"
    SQL
  end

  def dropTilesetsTable
    return <<-SQL
      drop table if exists tilesets;
    SQL
  end

  def createTilesetsTable
    return <<-SQL
      create table tilesets (
        tilesetId varchar(100),
        urbanPlanId varchar(100),
        name varchar(100),
        released varchar(100)
      );
    SQL
  end

  def addTileset(tileset, database)
    statement = database.prepare <<-SQL
      insert into tilesets (
      tilesetId,
      urbanPlanId,
      name,
      released
      ) values (?,?,?,?)
    SQL

    statement.execute tileset.tilesetId,
                      tileset.urbanPlanId,
                      tileset.name,
                      tileset.released
    statement.close
  end

end
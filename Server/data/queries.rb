require 'sqlite3'
require_relative '../model/urbanplan'

class Queries

  def urbanPlans
    return <<-SQL
      select * from urbanPlans order by name
    SQL
  end

  def urbanPlan(tilesetid)
    return <<-SQL
      select * from urbanPlans where tilesetid="#{tilesetid}"
    SQL
  end

  def dropUrbanPlans
    return <<-SQL
      drop table if exists urbanPlans;
    SQL
  end

  def createUrbanPlans
    return <<-SQL
      create table urbanPlans (
        tilesetId varchar(100),
        grouping varchar(100),
        name varchar(100),
        latitude varchar(100),
        longitude varchar(100),
        zoom varchar(100),
        released varchar(100)
      );
    SQL
  end

  def addMovie(movie, database)
    statement = database.prepare <<-SQL
      insert into urbanPlans (
      tilesetid,
      grouping,
      name,
      latitude,
      longitude,
      zoom,
      released
      ) values (?,?,?,?,?,?,?)
    SQL

    statement.execute urbanplan.tilesetid,
                      urbanplan.grouping,
                      urbanplan.name,
                      urbanplan.latitude,
                      urbanplan.longitude,
                      urbanplan.zoom,
                      urbanplan.released
    statement.close
  end

end
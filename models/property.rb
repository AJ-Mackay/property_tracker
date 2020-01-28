require('pg')

class Property

  attr_accessor :value, :number_of_bedrooms, :year_built, :buy_let_status

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @value = options["value"].to_i()
    @number_of_bedrooms = options["number_of_bedrooms"].to_i()
    @year_built = options["year_built"].to_i()
    @buy_let_status = options["buy_let_status"]
  end

  def save()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "INSERT INTO property_tracker (value, number_of_bedrooms, year_built, buy_let_status) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values).first()["id"].to_i()
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "DELETE FROM property_tracker WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end


  def update()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "UPDATE property_tracker SET (value, number_of_bedrooms, year_built, buy_let_status) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "SELECT * FROM property_tracker"
    db.prepare("all", sql)
    list = db.exec_prepared("all")
    db.close()
    return list.map {|item| Property.new(item)}
  end

  def Property.delete_all()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "DELETE FROM property_tracker"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  # def Property.find_by_id(id_to_find)
  #   db = PG.connect({
  #     dbname: "property_tracker",
  #     host: "localhost"
  #     })
  #   sql = "SELECT * FROM property_tracker"
  #   db.prepare("find_by_id", sql)
  #   all_properties = db.exec_prepared("find_by_id")
  #   all_properties_array = all_properties.map {|property| Property.new(property)}
  #   property_to_find = all_properties_array.find {|property| property.id == id_to_find}
  #   db.close()
  #   return property_to_find
  #   end

  def Property.find_by_id(id_to_find)
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "SELECT * FROM property_tracker WHERE id = $1"
    values = [id_to_find]
    db.prepare("id", sql)
    property_to_find = db.exec_prepared("id", values)
    db.close()
    return property_to_find.map {|property| Property.new(property)}
  end


end

require('pg')

class BountyHunter

  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :collected_by

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @collected_by = options['collected_by'] || 'OPEN'
  end

  def save()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "INSERT INTO bounty_hunters
    (name, species, bounty_value, collected_by)
    VALUES
    ($1, $2, $3, $4) RETURNING *
    "
    values = [@name, @species, @bounty_value, @collected_by]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "DELETE FROM bounty_hunters
    WHERE id = $1"
    values = [@id]
    db.prepare("delete1", sql)
    bounties = db.exec_prepared("delete1", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "UPDATE bounty_hunters
    SET (
      name, species, bounty_value, collected_by
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
    values = [@name, @species, @bounty_value, @collected_by, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def BountyHunter.find_by_id(id)
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "SELECT * FROM bounty_hunters WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    target = db.exec_prepared("find_by_id", values)
    db.close()
    target_array = target.map { |bounty| BountyHunter.new(bounty)}
    return nil if target_array.length == 0
    return target_array[0]
  end

  def BountyHunter.find_by_name(name)
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "SELECT * FROM bounty_hunters WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    target = db.exec_prepared("find_by_name", values)
    db.close()
    target_array = target.map { |bounty| BountyHunter.new(bounty)}
    return nil if target_array.length == 0
    return target_array[0]
  end

  def BountyHunter.all()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "SELECT * FROM bounty_hunters"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map { |hunter| BountyHunter.new(hunter)}
  end

  def BountyHunter.delete_all()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'} )
    sql = "DELETE FROM bounty_hunters"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


end

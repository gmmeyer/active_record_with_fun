require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject

  def self.parse_all(results)
  end
end

class SQLObject < MassObject
  def self.columns
    cols = DBConnection.execute2("SELECT * FROM #{self.table_name}")[0]
    cols.each do |col|
      self.class_eval %Q"
        def #{col}
           @#{col}
        end
      "
      self.class_eval %Q"
        def #{col}=value
          @#{col}=value
          @attributes[:#{col}] = value
        end
      "

    end
    return cols
  end

  def self.parse_all(results)
    results.map{ |attrs| self.new(attrs) }
  end

  def self.table_name=(table_name)
    @table_name = table_name
    @table_name
  end

  def self.table_name
    if @table_name == nil
      @table_name = self.to_s.underscore.pluralize
    end
    @table_name
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
      #{self.table_name}
    SQL

    return self.parse_all(results)
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, {id: id})
      SELECT
        *
      FROM
      #{self.table_name}
      WHERE
        id = :id

    SQL

    return self.parse_all(results)[0]
  end

  def initialize(options = {})
    attributes
    options.each do |attr_name,value|
      foo = "#{attr_name}".to_sym
      raise 'lala' if self.class.columns.include?(foo)
      #self.send(foo,)
      instance_variable_set("@#{attr_name}", value)
      p attr_name
      @attributes[attr_name.to_sym] = value
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    arr = []
    number = self.class.columns.count - 1
    names = self.class.columns[1..-1].join(",")
    q_marks = (["?"]*number).join(",")

    results = DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{names})
      VALUES
        (#{q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id

  end

  def save
    if self.class.find(id).nil?
      self.insert
    else
      self.update
    end

  end

  def update
    set_line = self.class.columns.join( " = ?," ) + " = ?"

    results = DBConnection.execute(<<-SQL, attribute_values + [self.id])
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL

  end

end

require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'
require 'debugger'

class MassObject

  my_attr_accessor :a

  def self.parse_all(results)
    # ...

  end
end

class SQLObject < MassObject
  def self.columns
    # ...
    cols = DBConnection.execute2("SELECT * FROM #{self.table_name}")[0]
    cols.map {|col| col.to_sym}
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
    @table_name
  end

  def self.table_name
    # ...
    if @table_name == nil
      @table_name = self.to_s.underscore.pluralize
    end
    @table_name
  end

  def self.all
    # ...
    DBConnection.execute(<<-SQL,columns)

      SELECT
      #{table_name}.*
      FROM
      columns[i]

    SQL
  end

  def self.find(id)
    # ...
  end

  def attributes
    # ...
    @a = 1
    @attributes ||= {}
    i_vars = self.instance_variables
    i_vars.each_with_index do |i_var, i|
      temp_var = "#{i_vars[i]}".gsub('@', '')
      @attributes[temp_var.to_sym] = instance_variable_get i_var
    end
    return @attributes
  end

  def insert
    # ...
  end

  def initialize
    # ...
    options.each do |attr_name,value|
      foo = "#{attr_name}".gsub('@', '').to_sym
      raise 'lala' if table_name.include?(foo)
    end
  end

  def save
    # ...
  end

  def update
    # ...
  end

  def attribute_values
    # ...
  end
end

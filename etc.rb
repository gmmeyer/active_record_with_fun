reset

require '/Users/appacademy/Desktop/active_record_with_fun/lib/active_record_lite/02_sql_object.rb'

class Cat < SQLObject
end

class Human < SQLObject
  self.table_name = "humans"
end

human = Human.find(2)

human.fname = "Matthew"
human.lname = "von Rubens"
human.update



a = Cat.new(:name => "Gizmo", :owner_id => 1)
a.name
a.name = 'g'
a
a.name
a.attribute_values

a = Cat.new(:name => "Gizmo", :owner_id => 1)

a.attribute_values

Cat.columns

Cat.all

Cat.attributes
Cat.columns
Cat.attributes

Cat.find(1)

Cat.all[1].id
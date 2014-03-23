reset

require '/Users/appacademy/Desktop/active_record_with_fun/lib/active_record_lite/02_sql_object.rb'

class Cat < SQLObject
end

aaaa = Cat.new(:name => "Gizmo", :owner_id => 1)

aaaa.attribute_values

Cat.columns

Cat.all

Cat.attributes
Cat.columns
Cat.attributes

Cat.find(1)

Cat.all[1].id
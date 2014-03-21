require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject

  def self.attributes
    attrs = []
    if self.superclass == AttrAccessorObject
      raise "must not call #attributes on MassObject directly"
    end

    attrs = self.instance_variables
    attrs.map{ |attr| instance_variable_get attr }
  end

  def initialize(params = {})
    params.each do |attr, value|
      instance_variable_set("@#{attr}",value)
    end
  end
end

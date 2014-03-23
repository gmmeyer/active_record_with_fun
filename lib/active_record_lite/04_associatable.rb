require_relative '03_searchable'
require 'active_support/inflector'

# Phase IVa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    # ...
    return class_name.to_s.constantize
  end

  def table_name
    # ...
    return class_name.pluralize.underscore
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    @foreign_key = "#{name}_id".to_sym
    @class_name = name.camelcase.singularize
    @primary_key = :id
    options.each do |option,pointing_at|
      instance_variable_set("@#{option}", pointing_at)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    @foreign_key = "#{self_class_name}_id".underscore.to_sym
    @class_name = name.camelcase.singularize
    @primary_key = :id

    options.each do |option,pointing_at|
      instance_variable_set("@#{option}", pointing_at)
    end

  end
end

module Associatable
  # Phase IVb
  def belongs_to(name, options = {})
    # ...
    define_method(
    #{name}.send()

    BelongsToOptions.new
    )
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase V. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end

ActiveSupport::Inflector.inflections do |inflect|
   inflect.irregular 'human', 'humans'
end

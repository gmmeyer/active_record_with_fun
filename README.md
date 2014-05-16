# Active Record Lite

Active Record is Rails's Object Relational Map.
It's what allows Rails to access entries in the database(s).
I wanted to better understand Active Record, so I tried to build a clone of it. It doesn't have the power of the full version, but it is a functional clone.
That being said, I would strongly recommend against using it, it has not been tested in any real environments.

## Technology used

### Metaprogramming
Active Record works because of the powerful metaprogramming abilities inherent to Ruby.

Ruby's has  abilities, like send, define_method, class_eval, instance_eval, set_instance_variable and others make writing  this a very  
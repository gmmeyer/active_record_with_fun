class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |attr|
      self.class_eval %Q"
        def #{attr}
          @#{attr}
        end
        "

        self.class_eval %Q"
        def #{attr}=value
          @#{attr}=value
        end
        "
    end

  end

end

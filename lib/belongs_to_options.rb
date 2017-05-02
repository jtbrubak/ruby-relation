require_relative 'assoc_options'
require 'active_support/inflector'

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    new_options = { primary_key: :id,
      foreign_key: "#{name.downcase}_id".to_sym,
      class_name: name.to_s.camelcase }.merge!(options)
    @primary_key = new_options[:primary_key]
    @foreign_key = new_options[:foreign_key]
    @class_name = new_options[:class_name]
  end
end

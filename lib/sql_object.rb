require_relative 'db_connection'
require_relative 'searchable'
require_relative 'associatable'
require 'active_support/inflector'

class SQLObject
  extend Searchable
  extend Associatable

  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    @columns[0].map { |col| col.to_sym }
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { attributes[col] }
      define_method("#{col}=") { |val| attributes[col] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ? @table_name : self.name.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      id = ?
    SQL
    result.first ? self.new(result.first) : nil
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.join(", ")
    question_marks = (["?"] * columns.length).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns.drop(1)
    col_names = columns.join(" = ?, ")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1), attribute_values.first)
    UPDATE
      #{self.class.table_name}
    SET
      #{col_names} = ?
    WHERE
      id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end

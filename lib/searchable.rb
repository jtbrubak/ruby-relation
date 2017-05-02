require_relative 'db_connection'

module Searchable
  def where(params)
    where_statement = params.keys.map { |col| "#{col} = ?"}.join(" AND ")
    values = params.values
    results = DBConnection.execute(<<-SQL, *values)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where_statement}
    SQL
    parse_all(results)
  end
end

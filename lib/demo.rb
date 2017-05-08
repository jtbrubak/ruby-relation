require_relative 'lib/sql_object'

class Song < SQLObject
  self.table_name = "songs"

  belongs_to :album, foreign_key: :album_id
  has_one_through :artist, :album, :artist

  self.finalize!
end

class Album < SQLObject
  self.table_name = "albums"

  belongs_to :artist
  has_many :songs, foreign_key: :album_id

  self.finalize!
end

class Artist < SQLObject
  has_many :albums

  self.finalize!
end

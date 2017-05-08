# RubyRelation

An object-relational mapping tool for Ruby.

## Demo Instructions

DB SCHEMA:
Artists: id, name
Albums: id, title, artist_id
Songs: id, title, album_id

To try out RubyRelation, simply navigate into the repo and load 'demo.rb' in irb or Pry.
```
load 'demo.rb'
```
From here, you can run methods on the sample database's three tables: Artist, Album, and Song.
```
Artist.find(1)
```
You can also chain methods like so:
```
Artist.find(1).albums
Artist.find(1).albums[0].songs
```

##  Features

- Declare SQL Object Classes representing database tables.
- Validates new entries to the database.
- Give classes associations through the has_many and belongs_to methods (check out demo for examples).

## Libraries and Gems
- ActiveSupport::Inflector
- SQLite3

## Methods Available
- ::all - Returns all entries for table.
```
Artist.all # => array of artists
```
- ::find - Returns entry with matching id.
```
Artist.find(1) # => Artist with id of 1
```
- ::where - Search for entries matching specific attributes.
```
Artist.where(name: 'The Beatles') #=> Artist with name attribute matching 'The Beatles'
```
- #insert
- #update
- #save - Inserts or updates depending on whether entry already exists.
- #destroy

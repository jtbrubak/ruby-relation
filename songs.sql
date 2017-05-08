CREATE TABLE songs (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  album_id INTEGER,

  FOREIGN KEY(album_id) REFERENCES album(id)
);

CREATE TABLE albums (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  artist_id INTEGER,

  FOREIGN KEY(artist_id) REFERENCES artist(id)
);

CREATE TABLE artists (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  artists (id, name)
VALUES
  (1, "The Beatles"), (2, "Miles Davis"), (3, "Prince");

INSERT INTO
  albums (id, title, artist_id)
VALUES
  (1, "Magical Mystery Tour", 1),
  (2, "Abbey Road", 1),
  (3, "In a Silent Way", 2),
  (4, "Kind of Blue", 2),
  (5, "Purple Rain", 3),
  (6, "Controversy", 3);

INSERT INTO
  songs (id, title, album_id)
VALUES
  (1, "The Fool on the Hill", 1),
  (2, "Come Together", 2),
  (3, "In a Silent Way", 3),
  (4, "So What", 4),
  (5, "When Doves Cry", 5),
  (6, "Controversy", 6);

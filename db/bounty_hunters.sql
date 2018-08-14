DROP TABLE bounty_hunters;

CREATE TABLE bounty_hunters(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT2,
  collected_by VARCHAR(255)
)

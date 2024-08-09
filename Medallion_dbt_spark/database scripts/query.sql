CREATE TABLE products(
  id         bigint PRIMARY KEY,
  created_at varchar(max),
  category   text,
  ean        bigint,
  price      float,
  quantity   int default(5000),
  rating     float,
  title      text,
  vendor     text
);

CREATE TABLE users(
  id         bigint PRIMARY KEY,
  created_at varchar(max),
  name       text,
  email      text,
  address    text,
  city       text,
  state      text,
  zip        int,
  birth_date text,
  latitude   float,
  longitude  float,
  password   text,
  source     text
);

CREATE TABLE orders(
  id         bigint PRIMARY KEY,
  created_at varchar(max),
  user_id    bigint,
  product_id bigint,
  discount   float,
  quantity   int,
  subtotal   float,
  tax        float,
  total      float
);

CREATE TABLE reviews(
  id         bigint PRIMARY KEY,
  created_at varchar(max),
  reviewer   text,
  product_id bigint,
  rating     int,
  body       text
);

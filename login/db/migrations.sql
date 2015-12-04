CREATE DATABASE bee_crypt;
\c bee_crypt
#bcrypt requires these column names for things pay attention here also ror helpers
  CREATE TABLE accounts (id SERIAL PRIMARY KEY, user_name VARCHAR(255), user_email VARCHAR(255), password_digest VARCHAR(255), is_admin BOOLEAN);
  \dt

-- Delete Already Existing Root User on the Host
DELETE FROM
  mysql.user
WHERE
  User = '$MARIADB_ROOT_USER'
  AND Host NOT IN ('$HOST_NAME', '$HOST_IPV4', '$HOST_IPV6');

-- Set Password of Root User on MariaDB
SET
  PASSWORD FOR '$MARIADB_ROOT_USER'@'$HOST_NAME' = PASSWORD('$MARIADB_ROOT_PASSWORD');

-- Create WordPress Database
CREATE DATABASE IF NOT EXISTS $MARIADB_DB;

-- Create Another User for WordPress
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';

-- Grant Permissions
GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;

-- Apply
FLUSH PRIVILEGES;

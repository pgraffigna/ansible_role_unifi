#!/bin/bash

# === VARIABLES ===
MONGO_AUTHSOURCE="unifi_admin"
MONGO_INITDB_ROOT_USERNAME="mongo_root"
MONGO_INITDB_ROOT_PASSWORD="mongo_password"
MONGO_USER="unifi_user"
MONGO_PASS="unifi_pass"
MONGO_DBNAME="unifi_db"

# === INICIO DE SCRIPT ===
if which mongosh > /dev/null 2>&1; then
  mongo_init_bin='mongosh'
else
  mongo_init_bin='mongo'
fi
"${mongo_init_bin}" <<EOF
use ${MONGO_AUTHSOURCE}
db.auth("${MONGO_INITDB_ROOT_USERNAME}", "${MONGO_INITDB_ROOT_PASSWORD}")
db.createUser({
  user: "${MONGO_USER}",
  pwd: "${MONGO_PASS}",
  roles: [
    { db: "${MONGO_DBNAME}", role: "dbOwner" },
    { db: "${MONGO_DBNAME}_stat", role: "dbOwner" }
  ]
})

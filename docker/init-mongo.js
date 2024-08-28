db.getSiblingDB("unifi").createUser({user: "unifi_user", pwd: "unifi_pass", roles: [{role: "dbOwner", db: "unifi"}]});
db.getSiblingDB("unifi_stat").createUser({user: "unifi_user", pwd: "unifi_pass", roles: [{role: "dbOwner", db: "unifi_stat"}]});



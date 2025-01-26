#!/usr/bin/env bash
# sedes
SEDES=(1 2 3 4 5)
SEDES_ID=(kt bl 23 pc jq)
URL="unifi.home.lab"
USERNAME=unifi_user
PASSWORD=unifi_password

# telegram
API="API"
CHAT_ID="ID"

# autenticando
curl -sk -X POST https://$URL:8443/api/login -H "Content-Type: application/json" \
		-d '{ "username":"$USERNAME","password":"$PASSWORD"}' -c /tmp/cookies.txt

# recorrer arrays por índices
for i in "${!SEDES[@]}"; do
  SEDE="${SEDES[$i]}"
  ID="${SEDES_ID[$i]}"

  # info vouchers por sitio
  STATUS_VOUCHERS=$(curl -sk -X GET "https://$URL:8443/api/s/$ID/stat/voucher" \
              -H "Content-Type: application/json" \
              -b /tmp/cookies.txt | jq -c '.data[]')

  echo "$STATUS_VOUCHERS" | while read -r voucher; do

		# TTL y CODIGO de cada voucher
  	TTL_VOUCHERS=$(echo "$voucher" | jq '.status_expires')
    CODIGO_VOUCHERS=$(echo "$voucher" | jq -r '.code')

	  DIAS=$(($TTL_VOUCHERS / 86400))
    SEGUNDOS_RESTANTES=$(($TTL_VOUCHERS % 86400))

    HORAS=$(($SEGUNDOS_RESTANTES / 3600))
    SEGUNDOS_RESTANTES=$(($SEGUNDOS_RESTANTES % 3600))

    MINUTOS=$(($SEGUNDOS_RESTANTES / 60))
    SEGUNDOS=$(($SEGUNDOS_RESTANTES % 60))

    # condición para alertado
    if [ "$DIAS" -lt 16 ]; then
      /usr/bin/curl -F "text=El voucher $CODIGO_VOUCHERS de la sede $SEDE expira en: $DIAS días, $HORAS horas, $MINUTOS minutos y $SEGUNDOS segundos." \
					"https://api.telegram.org/$API/sendMessage?chat_id=$CHAT_ID"
    fi
  done
done
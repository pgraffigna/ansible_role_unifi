#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
# sedes
SEDES=(1 2 3 4 5)
SEDES_ID=(kt bl ft pc jq)

# telegram
API=API_TELEGRAM
CHAT_ID=CHAT_ID

# autenticando
curl -sk -c /tmp/cookies.txt -X POST https://URL/api/login -H "Content-Type: application/json" \
		-d '{ "username":"USERNAME","password":"PASSWORD"}'

# Recorrer arrays via el índice
for i in "${!SEDES[@]}"; do
  sede="${SEDES[$i]}"
  id="${SEDES_ID[$i]}"

  	TTL_VOUCHER=$(curl -sk -X GET "https://URL:8443/api/s/$id/stat/voucher" \
			-H "Content-Type: application/json" \
			-b /tmp/cookies.txt | jq | grep 'status_expires' | awk '{print $2}')

		CODIGO_VOUCHER=$(curl -sk -X GET "https://URL:8443/api/s/$id/stat/voucher" \
			-H "Content-Type: application/json" \
			-b /tmp/cookies.txt | jq | grep 'code' | awk '{print $2}' | tr -d '",')

		DIAS=$(($TTL_VOUCHER / 86400))
		SEGUNDOS_RESTANTES=$(($TTL_VOUCHER % 86400))

		HORAS=$((SEGUNDOS_RESTANTES / 3600))
		SEGUNDOS_RESTANTES=$((SEGUNDOS_RESTANTES % 3600))

		MINUTOS=$((SEGUNDOS_RESTANTES / 60))
		SEGUNDOS=$((SEGUNDOS_RESTANTES % 60))

		# enviando mensaje con resultados
		/usr/bin/curl -F "text=El voucher $CODIGO_VOUCHER de la sede $sede expira en: ${DIAS} días, ${HORAS} horas, ${MINUTOS} minutos y ${SEGUNDOS} segundos." \
			"https://api.telegram.org/${API}/sendMessage?chat_id=${CHAT_ID}"
done

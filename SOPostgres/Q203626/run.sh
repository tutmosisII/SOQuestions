#!/bin/bash
# Corriendo un Motor de postgresql
docker rm -f q203626-postgres
docker run --name q203626-postgres -p 5432:5432  -d postgres:10.5-alpine
# Creando el procedimiento almacenado y la tabla
sleep 5
psql -h 127.0.0.1 -p 5432  -U postgres  -f storeprocedure.sql
# Validando formato json con jq
cat data.json | jq -e . >/dev/null 2>&1  | echo ${PIPESTATUS[1]}
cat data1.json |jq -e . >/dev/null 2>&1  | echo ${PIPESTATUS[1]}
# Probando Insercion Un Registros
data_json=$(cat data1.json)
echo "JSON: $data_json"
psql -h 127.0.0.1 -p 5432  -U postgres  -c "select sp_insert_update_trabajo_dave_json('$data_json')"

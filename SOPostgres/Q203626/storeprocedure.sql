DROP TABLE IF EXISTS cat_vehicle;
CREATE table cat_vehicle(
     origin_adm integer,
    cve_vehicle integer ,
    vehicle_name varchar(500) ,
    cve_brand integer ,
    vehicle_plate varchar(500) ,
    vehicle_vin varchar(500) ,
    cve_model integer ,
    vehicle_year varchar(500) ,
    cve_color integer ,
    vehicle_capacity integer ,
    cve_type integer ,
    cve_vehicle_cat integer ,
    vehicle_image varchar(500) ,
    status varchar(500) ,
    user_cve varchar(500) ,
    last_update date,
    fec_param_ini date,
    lbase_param_ini integer,
    odo_param_ini integer,
    date_last_man date,
    odo_last_man integer ,
    cve_delivery_route integer) ;

CREATE OR REPLACE FUNCTION public.sp_insert_update_trabajo_dave_json(
    in_json text)
    RETURNS TABLE(var_mensaje character varying, var_success boolean)
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$

DECLARE
jsonData json;
var_count integer;
var_json json;
var_json_fields json;
var_n integer;
var_mensaje varchar;
var_success boolean:=false;
var_counts integer;
BEGIN
    jsonData := in_json:: json;
    FOR var_json_fields IN SELECT * FROM json_array_elements(in_json::json) LOOP
    --SELECT COUNT (*) FROM cat_vehicle
    --where cve_vehicle =(jsonData->>'cve_vehicle'):: integer into var_counts;
       --IF (var_counts >0)THEN
            --UPDATE cat_vehicle SET vehicle_name =(jsonData->>'vehicle_name')
            --WHERE cve_vehicle=(jsonData->>'cve_vehicle'):: integer;
    --END IF;
    --END LOOP;

    --ELSE
    IF(var_json_fields IS NOT NULL)THEN
    RAISE NOTICE 'var_json_fields=%', var_json_fields;
    INSERT INTO cat_vehicle(
        origin_adm,
        cve_vehicle,
        vehicle_name,
        cve_brand,
        vehicle_plate,
        vehicle_vin,
        cve_model,
        vehicle_year,
        cve_color,
        vehicle_capacity,
        cve_type,
        cve_vehicle_cat,
        vehicle_image,
        status,
        user_cve,
        last_update,
        fec_param_ini,
        lbase_param_ini,
        odo_param_ini,
        date_last_man,
        odo_last_man,
        cve_delivery_route) VALUES(
          (var_json->>'origin_adm') :: integer,
               (var_json->>'cve_vehicle'):: integer,
               (var_json->>'vehicle_name'):: character varying,
               (var_json->>'cve_brand'):: integer,
               (var_json->>'vehicle_plate'):: character varying,
               (var_json->>'vehicle_vin'):: character varying,
               (var_json->>'cve_model'):: integer,
               (var_json->>'vehicle_year'):: character varying,
               (var_json->>'cve_color'):: integer,
               (var_json->>'vehicle_capacity'):: integer,
               (var_json->>'cve_type'):: integer,
               (var_json->>'cve_vehicle_cat'):: integer,
               (var_json->>'vehicle_image'):: character varying,
               (var_json->>'status'):: character varying,
                (var_json->>'user_cve'):: character varying,
               (var_json->>'last_update'):: date,
                (var_json->>'fec_param_ini'):: date,
               (var_json->>'lbase_param_ini'):: integer,
               (var_json->>'odo_param_ini'):: integer,
               (var_json->>'date_last_man'):: date,
                (var_json->>'odo_last_man'):: integer,
               (var_json->>'cve_delivery_route'):: integer);
               get diagnostics var_n = row_count;
               RAISE NOTICE 'Diagnostico ROW_COUNT=%', var_n;

             END IF;
           END LOOP;
            IF(var_n > 0) THEN
                var_success:=true;
                var_mensaje:='Registros agregados satisfactoriamente.';
            ELSE
                var_success:=false;
                var_mensaje:='Error en el sistema favor de contactar a su administrador.';
                --var_id:=0;
            END IF;
    --end if;
    RETURN QUERY SELECT var_mensaje, var_success;
END;

$BODY$;

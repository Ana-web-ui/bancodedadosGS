CREATE TABLE calculo_geracao (
    data DATE,
    energia_gerada NUMBER,
    tipo_energia VARCHAR2(50)
);

INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-16', 'YYYY-MM-DD'), 31.014, 'eólica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-17', 'YYYY-MM-DD'), 55.854, 'hidráulica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-18', 'YYYY-MM-DD'), 278.96, 'hidráulica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-19', 'YYYY-MM-DD'), 4.219, 'eólica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-20', 'YYYY-MM-DD'), 108.626, 'eólica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-21', 'YYYY-MM-DD'), 22.541, 'hidráulica');
INSERT INTO calculo_geracao (data, energia_gerada, tipo_energia) VALUES (TO_DATE('2024-11-22', 'YYYY-MM-DD'), 1848.121, 'hidráulica');


SELECT * FROM calculo_geracao;

SELECT
    "A1"."NUMERADOR_B" / "A1"."DENOMINADOR_B"                               "B",
    "A1"."AVG_Y" - "A1"."NUMERADOR_B" / "A1"."DENOMINADOR_B" * "A1"."AVG_X" "A"
FROM
    (
        SELECT
            SUM(("A3"."X" - "A2"."AVG_X") *("A3"."Y" - "A2"."AVG_Y")) "NUMERADOR_B",
            SUM(("A3"."X" - "A2"."AVG_X") *("A3"."X" - "A2"."AVG_X")) "DENOMINADOR_B",
            "A2"."AVG_X"                                              "AVG_X",
            "A2"."AVG_Y"                                              "AVG_Y"
        FROM
            (
                SELECT
                    "A4"."DATA"                                                  "DATA",
                    TO_NUMBER("A4"."DATA" - TO_DATE('2024-11-16', 'YYYY-MM-DD')) "X",
                    "A4"."ENERGIA_GERADA"                                        "Y"
                FROM
                    "RM558885"."CALCULO_GERACAO
                    " "A4"
            ) "A3",
            (
                SELECT
                    AVG("A5"."X") "AVG_X",
                    AVG("A5"."Y") "AVG_Y"
                FROM
                    (
                        SELECT
                            "A6"."DATA"                                                  "DATA",
                            TO_NUMBER("A6"."DATA" - TO_DATE('2024-11-16', 'YYYY-MM-DD')) "X",
                            "A6"."ENERGIA_GERADA"                                        "Y"
                        FROM
                            "RM558885"."CALCULO_GERACAO
                            " "A6"
                    ) "A5"
            ) "A2"
        GROUP BY
            "A2"."AVG_X",
            "A2"."AVG_Y"
    ) "A1";
SELECT
    TO_DATE('2024-11-23', 'YYYY-MM-DD')                                                                        "DATA_PREVISTA",
    "A1"."A" + "A1"."B" * TO_NUMBER(TO_DATE('2024-11-23', 'YYYY-MM-DD') - TO_DATE('2024-11-16', 'YYYY-MM-DD')) "ENERGIA_PREVISTA"
FROM
    (
        SELECT
            "A2"."NUMERADOR_B" / "A2"."DENOMINADOR_B"                               "B",
            "A2"."AVG_Y" - "A2"."NUMERADOR_B" / "A2"."DENOMINADOR_B" * "A2"."AVG_X" "A"
        FROM
            (
                SELECT
                    SUM(("A3"."X_1" - "A3"."AVG_X_3") *("A3"."Y_2" - "A3"."AVG_Y_4")) "NUMERADOR_B",
                    SUM(("A3"."X_1" - "A3"."AVG_X_3") *("A3"."X_1" - "A3"."AVG_X_3")) "DENOMINADOR_B",
                    "A3"."AVG_X_3"                                                    "AVG_X",
                    "A3"."AVG_Y_4"                                                    "AVG_Y"
                FROM
                    (
                        SELECT
                            "A8"."DATA"  "DATA",
                            "A8"."X"     "X_1",
                            "A8"."Y"     "Y_2",
                            "A7"."AVG_X" "AVG_X_3",
                            "A7"."AVG_Y" "AVG_Y_4"
                        FROM
                            (
                                SELECT
                                    "A6"."DATA"                                                  "DATA",
                                    TO_NUMBER("A6"."DATA" - TO_DATE('2024-11-16', 'YYYY-MM-DD')) "X",
                                    "A6"."ENERGIA_GERADA"                                        "Y"
                                FROM
                                    "RM558885"."CALCULO_GERACAO
                                    " "A6"
                            ) "A8",
                            (
                                SELECT
                                    AVG("A4"."X") "AVG_X",
                                    AVG("A4"."Y") "AVG_Y"
                                FROM
                                    (
                                        SELECT
                                            "A5"."DATA"                                                  "DATA",
                                            TO_NUMBER("A5"."DATA" - TO_DATE('2024-11-16', 'YYYY-MM-DD')) "X",
                                            "A5"."ENERGIA_GERADA"                                        "Y"
                                        FROM
                                            "RM558885"."CALCULO_GERACAO
                                            " "A5"
                                    ) "A4"
                            ) "A7"
                    ) "A3"
                GROUP BY
                    "A3"."AVG_X_3",
                    "A3"."AVG_Y_4"
            ) "A2"
    ) "A1";
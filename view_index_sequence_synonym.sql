CREATE OR REPLACE VIEW v_vanzari_complete AS
SELECT v.id_vanzare,
       c.nume || ' ' || c.prenume AS client,
       m.marca || ' ' || m.model AS masina,
       a.nume AS angajat,
       a.functie,
       v.data_vanzare,
       v.pret_final
FROM SR_VANZARI v
JOIN SR_CLIENTI c ON c.id_client = v.id_client
JOIN SR_MASINI m ON m.id_masina = v.id_masina
JOIN SR_ANGAJATI a ON a.id_angajat = v.id_angajat;

SELECT * FROM V_VANZARI_COMPLETE;

CREATE OR REPLACE VIEW v_clienti_contact AS
SELECT id_client, nume, prenume, telefon, email
FROM SR_CLIENTI
WHERE telefon IS NOT NULL AND email IS NOT NULL
WITH READ ONLY;

SELECT view_name, text
FROM USER_VIEWS;

CREATE INDEX index_metoda_plata ON SR_PLATI(metoda_plata);

SELECT * FROM SR_PLATI
WHERE metoda_plata = 'CARD';

CREATE INDEX index_functie ON SR_ANGAJATI(UPPER(functie));

SELECT * FROM SR_ANGAJATI
WHERE UPPER(functie) = 'AGENT VANZARI';

CREATE SEQUENCE seq_vanzari
START WITH 1000
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO SR_VANZARI
(id_vanzare, id_client, id_masina, id_angajat, data_vanzare, pret_final)
VALUES
(seq_vanzari.NEXTVAL, 1, 1, 1, SYSDATE, 18500);

SELECT seq_vanzari.CURRVAL FROM DUAL;

SELECT sequence_name, last_number
FROM USER_SEQUENCES;

CREATE SYNONYM clienti_showroom FOR SR_CLIENTI;

SELECT * FROM clienti_showroom;

DROP SYNONYM clienti_showroom;

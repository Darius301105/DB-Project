/* 1 */
SELECT id_angajat, nume, functie, salariu
FROM SR_ANGAJATI
ORDER BY salariu DESC;

/* 2 */
SELECT id_masina, marca, model, an_fabricatie, pret
FROM SR_MASINI
WHERE status = 'VANDUTA'
ORDER BY pret ASC;

/* 3 */
SELECT id_angajat, nume, functie, salariu
FROM SR_ANGAJATI
WHERE salariu > 6000
ORDER BY functie DESC;

/* 4 */
SELECT id_client, nume || ' ' || prenume AS nume_complet
FROM SR_CLIENTI
ORDER BY nume_complet;

/* 5 */
SELECT id_vanzare, data_vanzare, pret_final
FROM SR_VANZARI
WHERE data_vanzare BETWEEN DATE '2025-12-08' AND DATE '2025-12-31'
ORDER BY data_vanzare;

/* 6 */
SELECT
  (SELECT COUNT(*) FROM SR_CLIENTI)   AS nr_clienti,
  (SELECT COUNT(*) FROM SR_ANGAJATI)  AS nr_angajati,
  (SELECT COUNT(*) FROM SR_MASINI)    AS nr_masini
FROM dual;

/* 7 */
SELECT
  MIN(salariu) AS salariu_min,
  MAX(salariu) AS salariu_max,
  ROUND(AVG(salariu),2) AS salariu_mediu
FROM SR_ANGAJATI;

/* 8 */
SELECT p.*, v.id_vanzare
FROM SR_PLATI p, SR_VANZARI v
WHERE p.id_vanzare = v.id_vanzare
  AND UPPER(p.metoda_plata) = 'CARD'
  AND p.suma > 21000
  AND TO_CHAR(p.data_plata, 'MM') = '12';

/* 9 */
SELECT m.id_masina, m.marca, m.model, m.status, v.id_vanzare, v.pret_final
FROM SR_MASINI m, SR_VANZARI v
WHERE m.id_masina = v.id_masina(+)
  AND m.status = 'DISPONIBILA';

/* 10 */
SELECT t.id_test,
       c.nume || ' ' || c.prenume AS client,
       m.marca || ' ' || m.model AS masina_testata,
       t.data_test
FROM SR_TESTDRIVE t, SR_CLIENTI c, SR_MASINI m
WHERE t.id_client = c.id_client
  AND t.id_masina = m.id_masina
  AND TO_CHAR(t.data_test, 'MM-YYYY') = '11-2025'
ORDER BY t.data_test;

/* 11 */
SELECT v.id_vanzare,
       c.nume || ' ' || c.prenume AS client,
       m.marca || ' ' || m.model AS masina,
       a.nume AS angajat,
       a.functie,
       v.pret_final
FROM SR_VANZARI v
JOIN SR_CLIENTI c ON c.id_client = v.id_client
JOIN SR_MASINI m ON m.id_masina = v.id_masina
JOIN SR_ANGAJATI a ON a.id_angajat = v.id_angajat
ORDER BY v.pret_final DESC;

/* 12 */
SELECT t.id_test,
       c.nume || ' ' || c.prenume AS client,
       m.marca || ' ' || m.model AS masina,
       t.data_test
FROM SR_TESTDRIVE t
JOIN SR_CLIENTI c ON c.id_client = t.id_client
JOIN SR_MASINI m ON m.id_masina = t.id_masina
ORDER BY t.data_test;

/* 13 */
SELECT p.id_plata,
       c.nume || ' ' || c.prenume AS client,
       p.suma,
       p.metoda_plata,
       p.data_plata
FROM SR_PLATI p
JOIN SR_VANZARI v ON v.id_vanzare = p.id_vanzare
JOIN SR_CLIENTI c ON c.id_client = v.id_client
ORDER BY c.nume, p.data_plata;

/* 14 */
SELECT c.id_client,
       c.nume || ' ' || c.prenume AS client,
       v.id_vanzare,
       v.pret_final
FROM SR_CLIENTI c
LEFT JOIN SR_VANZARI v ON v.id_client = c.id_client
ORDER BY c.id_client, v.id_vanzare;

/* 15 */
SELECT a.id_angajat, a.nume, a.functie,
       COUNT(v.id_vanzare) AS nr_vanzari
FROM SR_ANGAJATI a
LEFT JOIN SR_VANZARI v ON v.id_angajat = a.id_angajat
GROUP BY a.id_angajat, a.nume, a.functie
ORDER BY nr_vanzari DESC, a.nume;

/* 16 */
SELECT a.id_angajat, a.nume,
       NVL(SUM(v.pret_final),0) AS total_vandut
FROM SR_ANGAJATI a
LEFT JOIN SR_VANZARI v ON v.id_angajat = a.id_angajat
GROUP BY a.id_angajat, a.nume
ORDER BY total_vandut DESC;

/* 18 */
SELECT c.id_client,
       c.nume || ' ' || c.prenume AS client,
       SUM(v.pret_final) AS total_cheltuit
FROM SR_CLIENTI c
JOIN SR_VANZARI v ON v.id_client = c.id_client
GROUP BY c.id_client, c.nume, c.prenume
HAVING SUM(v.pret_final) > (SELECT AVG(pret_final) FROM SR_VANZARI)
ORDER BY total_cheltuit DESC;

/* 19 */
SELECT m.id_masina, m.marca, m.model
FROM SR_MASINI m
WHERE (SELECT COUNT(DISTINCT t.id_client)
       FROM SR_TESTDRIVE t
       WHERE t.id_masina = m.id_masina) > 1
ORDER BY m.marca, m.model;

/* 20 */
SELECT v.id_vanzare,
       c.nume || ' ' || c.prenume AS client,
       v.pret_final,
       NVL(SUM(p.suma),0) AS total_platit,
       (v.pret_final - NVL(SUM(p.suma),0)) AS rest_de_plata
FROM SR_VANZARI v
JOIN SR_CLIENTI c ON c.id_client = v.id_client
LEFT JOIN SR_PLATI p ON p.id_vanzare = v.id_vanzare
GROUP BY v.id_vanzare, c.nume, c.prenume, v.pret_final
HAVING NVL(SUM(p.suma),0) < v.pret_final
ORDER BY rest_de_plata DESC;

/* 21 */
INSERT INTO SR_CLIENTI (id_client, nume, prenume, telefon, email)
VALUES (99, 'Pop', 'Rares', '0712345678', 'rares.pop@gmail.com');

INSERT INTO SR_TESTDRIVE (id_test, id_client, id_masina, data_test, feedback)
VALUES (99, 99, 1, DATE '2025-11-15', 'Test drive reusit');

SELECT c.id_client, c.nume, c.prenume
FROM SR_CLIENTI c
WHERE c.id_client IN (
  SELECT id_client FROM SR_TESTDRIVE
  MINUS
  SELECT id_client FROM SR_VANZARI
)
ORDER BY c.id_client;

/* 22 */
SELECT id_client, nume, prenume,
  CASE
    WHEN email IS NULL AND telefon IS NULL THEN 'CONTACT LIPSA'
    WHEN email IS NULL OR telefon IS NULL THEN 'CONTACT INCOMPLET'
    ELSE 'CONTACT OK'
  END AS status_contact
FROM SR_CLIENTI
ORDER BY id_client;

/* 23 */
SELECT id_plata, suma,
  CASE
    WHEN suma >= 20000 THEN 'PLATA MARE'
    WHEN suma >= 12000 THEN 'PLATA MEDIE'
    ELSE 'PLATA MICA'
  END AS tip_plata
FROM SR_PLATI
ORDER BY suma ASC;

/* 24 */
SELECT id_plata, suma, metoda_plata,
  DECODE(metoda_plata,
    'CARD', 'Plata electronica',
    'TRANSFER', 'Plata bancara',
    'CASH', 'Plata numerar',
    'Alta'
  ) AS categorie_metoda
FROM SR_PLATI
ORDER BY id_plata;

/* 25 */
SELECT id_angajat, nume, functie, salariu,
  DECODE(functie,
    'Manager Showroom', ROUND(salariu*0.10,2),
    'Agent Vanzari', ROUND(salariu*0.07,2),
    'Consilier Financiar', ROUND(salariu*0.08,2)
  ) AS bonus_estimat
FROM SR_ANGAJATI
ORDER BY bonus_estimat DESC;

/* 26 */
SELECT a.functie,
       COUNT(v.id_vanzare) AS nr_vanzari,
       NVL(SUM(v.pret_final),0) AS total_vandut,
       DECODE(a.functie,
         'Manager Showroom','Conducere',
         'Agent Vanzari','Vanzari',
         'Consilier Financiar','Vanzari'
       ) AS categorie_functie
FROM SR_ANGAJATI a
LEFT JOIN SR_VANZARI v ON v.id_angajat = a.id_angajat
GROUP BY a.functie
ORDER BY total_vandut DESC;

/* 27 (corectat typo: c.nume,.prenume -> c.nume, c.prenume) */
SELECT c.id_client, c.nume, c.prenume
FROM SR_CLIENTI c
WHERE c.id_client IN (
  SELECT id_client FROM SR_TESTDRIVE
  INTERSECT
  SELECT id_client FROM SR_VANZARI
)
ORDER BY c.id_client;

/* 28 */
SELECT a.id_angajat, a.nume, a.functie,
       SUM(v.pret_final) AS total_vandut
FROM SR_ANGAJATI a
JOIN SR_VANZARI v ON v.id_angajat = a.id_angajat
GROUP BY a.id_angajat, a.nume, a.functie
HAVING SUM(v.pret_final) > (
  SELECT AVG(total_pe_angajat)
  FROM (
    SELECT SUM(pret_final) AS total_pe_angajat
    FROM SR_VANZARI
    GROUP BY id_angajat
  )
)
ORDER BY total_vandut DESC;

/* 29 */
SELECT id_client,
       INITCAP(nume) || ' ' || INITCAP(prenume) AS client,
       SUBSTR(telefon, 1, 3) || '****' || SUBSTR(telefon, -2) AS telefon_mascat,
       LOWER(SUBSTR(email, INSTR(email,'@')+1)) AS domeniu_email
FROM SR_CLIENTI
WHERE telefon IS NOT NULL AND email IS NOT NULL
ORDER BY id_client;

/* 30 */
SELECT c.id_client,
       c.nume || ' ' || c.prenume AS client,
       SUM(v.pret_final) AS total_cheltuit
FROM SR_CLIENTI c
JOIN SR_VANZARI v ON v.id_client = c.id_client
GROUP BY c.id_client, c.nume, c.prenume
HAVING SUM(v.pret_final) > (
  SELECT AVG(total_client)
  FROM (
    SELECT SUM(v2.pret_final) AS total_client
    FROM SR_VANZARI v2
    GROUP BY v2.id_client
  )
)
ORDER BY total_cheltuit DESC;

/* 31 */
SELECT LEVEL AS nivel,
       LPAD(' ', (LEVEL-1)*3) || nod AS arbore
FROM (
  SELECT 'MARCA: ' || marca AS nod, NULL AS parinte
  FROM SR_MASINI
  GROUP BY marca
  UNION ALL
  SELECT 'MODEL: ' || model AS nod,
         'MARCA: ' || marca AS parinte
  FROM SR_MASINI
  GROUP BY marca, model
  UNION ALL
  SELECT 'MASINA ID ' || id_masina || ' (' || pret || ' lei)' AS nod,
         'MODEL: ' || model AS parinte
  FROM SR_MASINI
)
START WITH parinte IS NULL
CONNECT BY PRIOR nod = parinte
ORDER SIBLINGS BY nod;

/* 32 */
SELECT m.marca,
       COUNT(m.id_masina) AS nr_masini,
       ROUND(AVG(m.pret), 2) AS pret_mediu
FROM SR_MASINI m
GROUP BY m.marca
ORDER BY pret_mediu ASC;

/* 33 */
SELECT id_angajat, nume, functie, salariu,
       ROUND(salariu, -2) AS salariu_rotunjit,
       CASE
         WHEN salariu >= 10000 THEN 'SALARIU FOARTE MARE'
         WHEN salariu >= 7000  THEN 'SALARIU MARE'
         WHEN salariu >= 5300  THEN 'SALARIU MEDIU'
         ELSE 'SALARIU MIC'
       END AS categorie_salariu
FROM SR_ANGAJATI
ORDER BY salariu DESC;

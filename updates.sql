UPDATE SR_ANGAJATI
SET salariu = salariu * 1.05
WHERE functie = 'Agent Vanzari';

SELECT id_angajat, nume, functie, salariu
FROM SR_ANGAJATI
WHERE functie = 'Agent Vanzari'
ORDER BY id_angajat;

UPDATE SR_PLATI
SET metoda_plata = 'CARD'
WHERE metoda_plata = 'CASH';

SELECT metoda_plata, COUNT(*) AS nr_plati
FROM SR_PLATI
GROUP BY metoda_plata;

UPDATE SR_MASINI
SET pret = pret * 1.1
WHERE an_fabricatie > 2018;

SELECT id_masina, marca, model, an_fabricatie, pret, status
FROM SR_MASINI;

UPDATE SR_ANGAJATI
SET functie = 'Manager Showroom'
WHERE id_angajat = 3;

SELECT id_angajat, nume, functie, salariu
FROM SR_ANGAJATI
WHERE id_angajat = 3;

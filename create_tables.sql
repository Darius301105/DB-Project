CREATE TABLE SR_CLIENTI(
  id_client  NUMBER(10)    NOT NULL,
  nume       VARCHAR2(20)  NOT NULL,
  prenume    VARCHAR2(25)  NOT NULL,
  telefon    VARCHAR2(15),
  email      VARCHAR2(40)
);

CREATE TABLE SR_MASINI(
  id_masina     NUMBER(10)    NOT NULL,
  marca         VARCHAR2(20)  NOT NULL,
  model         VARCHAR2(25)  NOT NULL,
  an_fabricatie NUMBER(4)     NOT NULL,
  pret          NUMBER(10,2)  NOT NULL,
  status        VARCHAR2(20)  DEFAULT 'DISPONIBILA' NOT NULL
);

CREATE TABLE SR_ANGAJATI(
  id_angajat NUMBER(10)    NOT NULL,
  nume       VARCHAR2(40)  NOT NULL,
  functie    VARCHAR2(20)  NOT NULL,
  salariu    NUMBER(8,2)   NOT NULL
);

CREATE TABLE SR_VANZARI(
  id_vanzare  NUMBER(10)   NOT NULL,
  id_client   NUMBER(10)   NOT NULL,
  id_masina   NUMBER(10)   NOT NULL,
  id_angajat  NUMBER(10)   NOT NULL,
  data_vanzare DATE        NOT NULL,
  pret_final  NUMBER(10,2) NOT NULL
);

CREATE TABLE SR_TESTDRIVE(
  id_test   NUMBER(10)   NOT NULL,
  id_client NUMBER(10)   NOT NULL,
  id_masina NUMBER(10)   NOT NULL,
  data_test DATE         NOT NULL,
  feedback  VARCHAR2(200)
);

CREATE TABLE SR_PLATI(
  id_plata     NUMBER(10)   NOT NULL,
  id_vanzare   NUMBER(10)   NOT NULL,
  suma         NUMBER(10,2) NOT NULL,
  metoda_plata VARCHAR2(20) NOT NULL,
  data_plata   DATE         NOT NULL
);

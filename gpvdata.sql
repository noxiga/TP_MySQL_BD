use parking;

INSERT ignore Parking values (1, 'Parking place Jean Bart', 200),(2, 'Parking Pôle Marine', 400);

INSERT ignore Ouverture values (1, 'Monday,Tuesday,Wednesday,Thursday,Friday', '07:00:00', '20:00:00'),(2, 'Saturday', '08:00:00', '23:00:00'),(3, 'Sunday', '10:00:00', '22:00:00');

REPLACE ouvrir values (1,1),(1,2),(1,3),(2,1),(2,2),(2,3);

REPLACE tarif values (1, '0:30', 0.00, '0:00', 'Monday,Tuesday,Wednesday,Thursday,Friday');
REPLACE tarif values (2, '0:30', 0.20, '0:30', 'Monday,Tuesday,Wednesday,Thursday,Friday');

REPLACE Carte (NumC, DateC, HeureDebC, IDP) values (1, CURDATE(),'07:30:00', 1);
REPLACE Carte (NumC, DateC, HeureDebC, IDP) values (2, CURDATE(),'07:32:00', 1);
REPLACE Carte (NumC, DateC, HeureDebC, IDP) values (3, CURDATE(),'07:45:00', 1);q

UPDATE Carte set HeureRegC=SEC_TO_TIME(TIME_TO_SEC(CURTIME())-2*60), EtatC='1' where NumC=2;
UPDATE Carte set HeureRegC=DATE_SUB(CURTIME(), INTERVAL 10 MINUTE), EtatC='1' where NumC=3;
UPDATE Carte set HeureResC=CURTIME(), EtatC='2' where NumC=3;

SELECT * FROM Carte;
SELECT * FROM Parking;
SELECT * FROM Tarif;
SELECT * FROM ouvrir;
SELECT * FROM attribuer;

SELECT COUNT(*) AS 'Combien de parking ' from parking;
SELECT nbpmax AS 'nombres de place occupé dans le parking place Jean Bart' FROM parking WHERE IDP=1;
SELECT nbpmax AS 'nombres de place occupé dans le parking Pôle Marine' FROM parking WHERE IDP=2;
SELECT COUNT(*) AS 'nombres de place disponible dans le parking place Jean Bart' FROM carte WHERE Etatc LIKE '0' AND IDP=1;
SELECT COUNT(*) AS 'nombres de place disponible dans le parking Pôle Marine' FROM carte WHERE Etatc LIKE '0' AND IDP=2;

SELECT COUNT(*) AS 'Carte 1 => 0:Barrière reste fermer, 1:Ouverture de la barrière' from carte where EtatC='1' AND NumC=1;
SELECT COUNT(*) AS 'Carte 2 => 0:Barrière reste fermer, 1:Ouverture de la barrière' from carte where EtatC='1' AND NumC=1;
SELECT COUNT(*) AS 'Carte 3 => 0:Barrière reste fermer, 1:Ouverture de la barrière' from carte where EtatC='1' AND NumC=1;

SELECT COUNT(*) FROM Parking, ouvrir, Ouverture WHERE Parking.IDP = ouvrir.IDP AND ouvrir.IDJS = ouverture.IDJS AND Parking.IDP = 1 AND JourOuv LIKE CONCAT('%', DAYNAME(CURDATE()), '%') AND HeureOuv < CURTIME() AND HeureFerm > CURTIME();
drop database IF EXISTS Parking;
create database Parking;
use Parking;
#Table Section
create table Carte (
                    NumC numeric(10) not null,
                    DateC date not null,
                    HeureDebC time not null,
                    HeureRegC time default '0:00:00' not null,
                    HeureResC time default '0:00:00' not null,
                    EtatC enum('0','1','2') default '0' not null,
                    IDP numeric(2) not null,
                    primary key (Numc));
#EtaC = '0' si la carte est active et non passée à la borne de paiement (la voiture du client est dans le parking).
#EtaC = '1' si la carte est active et passée à la borne de paiement (le client a réglé la facture). 
#EtaC = '2' si la carte a été restituée le client est sortie du Parking.

create table Ouverture (
                        IDJS numeric(5) not null,
                        JourOuv SET('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') not null,
                        HeureOuv time not null,
                        HeureFerm time not null,
                        primary key (IDJS));

create table Parking (
                      IDP numeric(2) not null,
                      DesignP varchar(30) not null,
                      NbPMax numeric(3) not null,
                      primary key (IDP));

create table Tarif (
                    IDT numeric(2) not null,
                    DureeT time not null,
                    PrixT float(4,2) not null,
                    HeureT time not null,
                    JourT SET('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') not null,
                    primary key (IDT));
                    
#DureeT : Durée du tarif corrspondant à PrixT. Ex 15mn commencées valent 0,20E.
#HeureT : Début du tarif. Ex : Après 30mn de présence dans le parking, le tarif vaut 0,20E pour 15mn

create table attribuer (
                        IDP numeric(2) not null,
                        IDT numeric(2) not null,
                        primary key (IDP, IDT));

create table ouvrir (
                     IDP numeric(2) not null,
                     IDJS numeric(5) not null,
                     primary key (IDP, IDJS));

# Constraints Section
alter table attribuer add constraint FKatt_Tar foreign key (IDT) references Tarif(IDT);
alter table attribuer add constraint FKatt_Par foreign key (IDP) references Parking(IDP);
alter table Carte add constraint FKlier foreign key (IDP) references Parking(IDP);
alter table ouvrir add constraint FKouv_Par foreign key (IDP) references Parking(IDP);
alter table ouvrir add constraint FKouv_Ouv foreign key (IDJS) references Ouverture(IDJS);
#alter table Parking add constraint
#     check(exists(select * from ouvrir
#                  where ouvrir.IDP = IDP));
#alter table Parking add constraint
#     check(exists(select * from attribuer
#                  where attribuer.IDP = IDP));

# Index Section
create unique index Idattribuer	on attribuer (IDT, IDP);
create index Fkatt_Tar		on attribuer (IDT);
create index Fkatt_Par		on attribuer (IDP);
create unique index IDCarte	on Carte (NumC);
create index Fklier		on Carte (IDP);
create unique index IDOuverture	on Ouverture (IDJS);
create unique index Idouvrir	on ouvrir (IDJS, IDP);
create index Fkouv_Par		on ouvrir (IDP);
create index Fkouv_Ouv		on ouvrir (IDJS);
create unique index IDParking	on Parking (IDP);
create unique index IDTarif	on Tarif (IDT);

show tables;
desc Carte;
desc Ouverture;
desc Parking;
desc Tarif;
desc attribuer;
desc ouvrir;

SELECT * from Parking;
SELECT * from Carte;
SELECT * from ouverture;
SELECT * from Tarif;
SELECT * from attribuer;
SELECT * from ouvrir;

SELECT 'SELECT * FROM mysql.user;' AS 'Contenu de la table user de la table mysql';
SELECT * FROM mysql.user;
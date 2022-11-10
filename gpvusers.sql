#admingpv
DROP USER IF EXISTS admingpv@localhost , admingpv@'%';
CREATE USER admingpv@localhost IDENTIFIED BY 'admingpv', admingpv@'%' IDENTIFIED BY 'admingpv';
GRANT ALL ON parking.* TO admingpv@localhost , admingpv@'%';

#invitegpv
DROP USER IF EXISTS invitegpv@localhost , invitegpv@'%';
CREATE USER invitegpv@localhost IDENTIFIED BY 'invitegpv', invitegpv@'%' IDENTIFIED BY 'invitegpv';
GRANT SELECT ON parking.* TO invitegpv@localhost , invitegpv@'%';

#gestiongpv
DROP USER IF EXISTS gestiongpv@localhost , gestiongpv@'%';
CREATE USER gestiongpv@localhost IDENTIFIED BY 'gestiongpv', gestiongpv@'%' IDENTIFIED BY 'gestiongpv';
GRANT SELECT, INSERT, UPDATE ON parking.* TO gestiongpv@localhost , gestiongpv@'%';
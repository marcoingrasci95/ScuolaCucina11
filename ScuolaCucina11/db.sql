-- DBTools Manager Professional (Enterprise Edition)
-- Database Dump for: cucina
-- Backup Generated in: 23/04/2010 18:50:33
-- Database Server Version: MySQL 5.1.26

-- USEGO

-- in quale schema? bisogna creare uno schema "cucina"
-- aggiungere dro delle table
-- ripulire lo script: correggere errori tipo ;

use cucina;

SET FOREIGN_KEY_CHECKS=0; -- non voglio fare un check sulle foreign key...
-- GO


--
-- Dumping Tables
--

--
-- Table: amministratori
--
CREATE TABLE `amministratori` 
(
	`id_amministratore` varchar (50) NOT NULL, 
	`password` varchar (50), 
	`nome` varchar (50), 
	`cognome` varchar (50), 
	`dataNascita` date, 
	`email` varchar (50), 
	`telefono` varchar (50),
	PRIMARY KEY (`id_amministratore`)
);

-- Dumping Table Data: amministratori

INSERT INTO `amministratori` (`id_amministratore`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('idutente', 'password', 'Admin', 'Bianchi', '1975-02-25', 'administratorSC@gmail.com', '3331234567');
INSERT INTO `amministratori` (`id_amministratore`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('marco81', 'marco', 'Marco', 'Rossi', '1957-11-22', 'admScuolaCucina@tiscali.it', '3332456178');
COMMIT;

-- Table: calendario
CREATE TABLE `calendario` 
(
	`id_edizione` integer (11) NOT NULL AUTO_INCREMENT , 
	`id_corso` integer (11), 
	`dataInizio` date, 
	`durata` integer (11), 
	`aula` varchar (50), 
	`docente` varchar (50),
	PRIMARY KEY (`id_edizione`)
); 


-- Dumping Table Data: calendario
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(92, 87, '2010-05-07', 2, 'Aula 1', 'C. Amato');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(93, 88, '2010-05-11', 1, 'Aula 2', 'F. Beatini');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(94, 90, '2010-05-19', 1, 'Aula 3', 'T. Mita');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(95, 91, '2010-05-03', 1, 'Aula 2', 'D.Priori');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(96, 92, '2010-05-28', 1, 'Aula 1', 'C. Amato');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(97, 93, '2010-05-30', 7, 'Aula 3', 'C. Amato');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(98, 94, '2010-06-01', 5, 'Aula 2', '    D. Priori');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(99, 95, '2010-05-30', 14, 'Aula 1', 'F. Beatini');
INSERT INTO `calendario` (`id_edizione`, `id_corso`, `dataInizio`, `durata`, `aula`, `docente`) VALUES(100, 90, '2010-04-28', 7, 'Aula3', 'M. Moretti');
COMMIT;
--
-- Index: delCorso
-- indice: possiamo accedere in maniera più rapida alle righe delle tabelle
ALTER TABLE `cucina`.`calendario` ADD INDEX delCorso (id_corso );


-- Table: catalogo
--
CREATE TABLE `catalogo` 
(
	`id_corso` integer (11) NOT NULL AUTO_INCREMENT , 
	`titolo` varchar (50), 
	`id_categoria` integer (11), 
	`numeroMaxPartecipanti` integer (11), 
	`costo` double (13,2), 
	`descrizione` varchar (2000),
	PRIMARY KEY (`id_corso`)
);

-- Dumping Table Data: catalogo
--
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(87, 'Sfiziosità di carne', 50, 15, 100.00, 'Squisiti bocconcini, piccole preparazioni classiche e ricette innovative. Un appetitoso viaggio attraverso i tanti modi di preparare e gustare la carne rossa e bianca, tra fantasia e tradizione, semplicità e raffinatezza.\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \'Calendario Corsi\' e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\nPro: poche calorie, colorati, facili da preparare, appetitosi\r\nContro: una volta assaggiati vi richiederanno sempre porzioni abbondanti. da realizzare\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(88, 'Sfiziosi primi vegetariani', 49, 20, 70.00, 'Pro: poche calorie, colorati, facili da preparare, appetitosi\r\nContro: una volta assaggiati vi richiederanno sempre porzioni abbondanti. da realizzare\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(90, 'Dessert al piatto', 53, 20, 75.00, 'Un dolce deve essere bello, sorprendente, affascinante, intrigante, profumatoal primo boccone dobbiamo desiderare subito il secondo. Ci saranno combinazioni di sapore mai forzate ma che sorprenderanno le vostre papille gustative. Otterrete da semplici ingredienti e da preparazioni del tutto tradizionali, ottimi e innovativi dessert.\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(91, 'Antipastini di mare', 48, 20, 130.00, 'Sfiziosi antipasti, pieni di sapore e profumi, ricette facilmente realizzabili, insolite e gustosissime.\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(92, 'Paste con verdure', 49, 15, 80.00, 'La primavera regala alla pasta soluzioni divertenti di sapore, all\'insegna dell\'originalità. Fave, melanzane, piselli, asparagi e tanti altri si sposeranno con garganelli, orecchiette, tagliolini... un gustoso matrimonio di sapori.\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n\r\n\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(93, 'Corso di cucina (base)', 54, 20, 250.00, 'Un corso fondamentale, a cadenza settimanale, un vero e proprio punto di partenza per conoscere i procedimenti e le lavorazioni indispensabili per cucinare. Ogni incontro sarà l\'occasione per apprendere, attraverso la realizzazione di un menu completo, piccoli segreti sull\'esecuzione di piatti basilari o sull\'acquisto e la scelta degli alimenti, la loro lavorazione e infine i \"trucchi\" dello chef che saranno il vostro asso nella manica. Un corso importante attraverso cui capire e \"provare\" la cucina, che degusterete con l\'abbinamento dei vini. Possibilità di esercitarsi, nel corso della lezione, accanto allo chef. A fine corso sarà rilasciato un attestato.\r\n\r\nImportante!!!\r\nIl  presente corso verrà erogato con una cadenza settimanale a partire dal giorno\r\nindicato nel \"Calendario Corsi\"  e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(94, 'Corso di cucina\r\n(avanzato)\r\n', 55, 20, 260.00, 'Accontentando le numerose richieste di chi ha già superato il livello di base, cinque incontri (a cadenza settimanale) in cui approfondire quegli argomenti che escono dalla conoscenza di base e si avvicinano maggiormente all\'alta cucina. Spazieremo nel mondo delle salse, della cottura a vapore per una cucina leggera ma piena di sapore, dei bolliti fatti ad arte, della pasta fatta in casa con creatività, del cous cous, del pan di Spagna e molte altre ghiottonerie.\r\n\r\nImportante!!!\r\nIl  presente corso verrà erogato con una cadenza settimanale a partire dal giorno\r\nindicato nel \"Calendario Corsi\"  e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(95, 'Corso di cucina per cuochi', 55, 15, 500.00, 'Un corso ben strutturato con teoria e pratica. E\' una guida per acquisire le tecniche base di cucina e apprendere l\'aspetto merceologico degli alimenti, l\'organizzazione di una cucina e le sue figure professionali. Un corso ideato per permettere a tutti, in tempi ristretti, di conoscere attraverso l\'esecuzione di ricette base le nozioni fondamentali del cucinare, la costruzione di un menu e la presentazione del piatto. Ogni argomento verrà trattato con la massima cura e correlato da utili dispense, dalle paste alle verdure, dal pesce alla carne, dagli antipasti alla pasticceria e tante altre informazioni, tutte finalizzate a formare una valida figura professionale. Consegna dell\'attestato di partecipazione con valutazione. La Direzione si riserva, a suo insindacabile giudizio, di far frequentare agli allievi più meritevoli stages formativi gratuiti presso aziende della ristorazione.\r\n\r\nImportante!!!\r\nIl presente corso verrà erogato nel/i giorno/i\r\nindicato/i nel \"Calendario Corsi\" e osserverà la durata di quattro ore (ore 18.00-22.00) per ogni giorno indicato.\r\n\r\n');
INSERT INTO `catalogo` (`id_corso`, `titolo`, `id_categoria`, `numeroMaxPartecipanti`, `costo`, `descrizione`) VALUES(96, 'Corso di cucina indiana', 54, 25, 750.00, 'Un corso da non perdere');
COMMIT;

--
-- Index: categoriaDelCorso
--
ALTER TABLE `cucina`.`catalogo` ADD INDEX categoriaDelCorso (id_categoria );
--
-- Table: categoria
--
CREATE TABLE `categoria` 
(
	`id_categoria` integer (11) NOT NULL AUTO_INCREMENT , 
	`descrizione` varchar (50),
	PRIMARY KEY (`id_categoria`)
); 

--
-- Dumping Table Data: categoria
BEGIN;
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(48, 'Antipasti');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(49, 'Primi piatti');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(50, 'Secondi piatti');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(51, 'Contorni');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(52, 'Frutta');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(53, 'Dolci');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(54, 'Cucina amatoriale');
INSERT INTO `categoria` (`id_categoria`, `descrizione`) VALUES(55, 'Cucina professionale(corsi per cuochi)');
COMMIT;

--
-- Table: feedback
--
CREATE TABLE `feedback` 
(
	`id_feedback` integer (11) NOT NULL AUTO_INCREMENT , 
	`id_edizione` integer (11), 
	`id_utente` varchar (50) NOT NULL, 
	`descrizione` varchar (50), 
	`voto` integer (11),
	PRIMARY KEY (`id_feedback`)
); 

--
-- Dumping Table Data: feedback
--
INSERT INTO `feedback` (`id_feedback`, `id_edizione`, `id_utente`, `descrizione`, `voto`) VALUES(1, 93, 'fausto', 'da consigliare!!!', 8);
INSERT INTO `feedback` (`id_feedback`, `id_edizione`, `id_utente`, `descrizione`, `voto`) VALUES(2, 93, 'mauro', 'veramente interessante.', 9);
INSERT INTO `feedback` (`id_feedback`, `id_edizione`, `id_utente`, `descrizione`, `voto`) VALUES(3, 98, 'davide', 'ottimi contenuti, ottimo insegnante', 10);
INSERT INTO `feedback` (`id_feedback`, `id_edizione`, `id_utente`, `descrizione`, `voto`) VALUES(4, 97, 'Ing_Ruben', 'breve ma ben strutturato', 7);
INSERT INTO `feedback` (`id_feedback`, `id_edizione`, `id_utente`, `descrizione`, `voto`) VALUES(5, 99, 'michele', 'esaustivo!!!', 8);
COMMIT;


--
-- Index: dellEdizione
--
ALTER TABLE `cucina`.`feedback` ADD INDEX dellEdizione (id_edizione );

--
-- Index: dellUtente
--
ALTER TABLE `cucina`.`feedback` ADD INDEX dellUtente (id_utente );

--
-- Table: iscritti
--
CREATE TABLE `iscritti` 
(
	`id_edizione` integer (11) NOT NULL DEFAULT 0, 
	`id_utente` varchar (50) NOT NULL,
	PRIMARY KEY (`id_edizione`, `id_utente`)
); 

--
-- Dumping Table Data: iscritti
--
INSERT INTO `iscritti` (`id_edizione`, `id_utente`) VALUES(93, 'Ing_Ruben');
INSERT INTO `iscritti` (`id_edizione`, `id_utente`) VALUES(100, 'veronica');
COMMIT;

--
-- Index: utenteIscritto
--
ALTER TABLE `cucina`.`iscritti` ADD INDEX utenteIscritto (id_utente );

--
-- Table: mail
--
CREATE TABLE `mail` 
(
	`id` integer (11) NOT NULL AUTO_INCREMENT , 
	`subject` varchar (50), 
	`data` varchar (50), 
	`body` varchar (200),
	PRIMARY KEY (`id`)
); 

--
-- Dumping Table Data: mail
--
COMMIT;
-- GO

--
-- Table: registrati
--
CREATE TABLE `registrati` 
(
	`id_utente` varchar (50) NOT NULL, 
	`password` varchar (50), 
	`nome` varchar (50), 
	`cognome` varchar (50), 
	`dataNascita` date, 
	`email` varchar (50), 
	`telefono` varchar (50),
	PRIMARY KEY (`id_utente`)
); 

--
-- Dumping Table Data: registrati
--
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('davide', 'davide', 'Davide', 'Precetti', '1982-08-12', 'davide.precetti@gmail.com', '3391448087');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('fausto', 'fausto', 'Fausto', 'Paniccia', '1982-03-03', 'pncfausto@libero.it', '3201916480');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('francesco', 'francesco', 'Francesco', 'Valerio', '1982-04-13', 'francesco.valerio@gmail.com', '3386965410');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('Ing_Ruben', 'password', 'Ruben', 'Giaccotto', '1981-03-17', 'ruben@giaccotto.it', '3477011366');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('mar81', '81', 'Marco', 'Rossi', '1981-04-01', 'marcobrucchietti@gmail.com', '33325854118');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('mauro', 'mauro', 'Mauro', 'Bove', '1981-08-19', 'bove.mauro@gmail.com', '3387972613');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('michele', 'michele', 'Michele', 'Fiorentino', '1988-01-09', 'mike.fiorentino@tiscali.it', '3402286606');
INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES('veronica', 'veronica', 'Veronica', 'Romani', '1983-07-24', 'veve-83@hotmail.it', '3336448818');
COMMIT;

--
-- Dumping Tables Foreign Keys
--

--
-- Foreign Key Constraint: delCorso
--
ALTER TABLE `calendario` ADD CONSTRAINT delCorso FOREIGN KEY (id_corso) REFERENCES `catalogo`(id_corso);
-- GO

--
-- Foreign Key Constraint: categoriaDelCorso
--
ALTER TABLE `catalogo` ADD CONSTRAINT categoriaDelCorso FOREIGN KEY (id_categoria) REFERENCES `categoria`(id_categoria);
-- GO

--
-- Foreign Key Constraint: dellUtente
--
ALTER TABLE `feedback` ADD CONSTRAINT dellUtente FOREIGN KEY (id_utente) REFERENCES `registrati`(id_utente);
-- GO

--
-- Foreign Key Constraint: dellEdizione
--
ALTER TABLE `feedback` ADD CONSTRAINT dellEdizione FOREIGN KEY (id_edizione) REFERENCES `calendario`(id_edizione);
-- GO

--
-- Foreign Key Constraint: utenteIscritto
--
ALTER TABLE `iscritti` ADD CONSTRAINT utenteIscritto FOREIGN KEY (id_utente) REFERENCES `registrati`(id_utente);
-- GO

--
-- Foreign Key Constraint: allEdizione
--
ALTER TABLE `iscritti` ADD CONSTRAINT allEdizione FOREIGN KEY (id_edizione) REFERENCES `calendario`(id_edizione);
-- GO

--
-- Dumping Triggers
--
SET FOREIGN_KEY_CHECKS=1;
-- GO


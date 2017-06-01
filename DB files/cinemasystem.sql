-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2017 at 09:14 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinemasystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `bilet`
--

CREATE TABLE `bilet` (
  `BiletID` int(11) NOT NULL,
  `Zamowienie_ZamowienieID` int(11) NOT NULL,
  `Seans_SeansID` int(11) NOT NULL,
  `Seans_Repertuar_RepertuarID` int(11) NOT NULL,
  `Seans_Repertuar_Kino_KinoID` int(10) UNSIGNED NOT NULL,
  `znizka` decimal(2,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `FilmID` int(11) NOT NULL,
  `tytul` varchar(32) NOT NULL,
  `kat_wiekowa` int(11) DEFAULT NULL,
  `jezyk` char(6) DEFAULT NULL,
  `dlugosc` int(10) UNSIGNED DEFAULT NULL,
  `premiera` date DEFAULT NULL,
  `tytul_oryginalny` varchar(32) DEFAULT NULL,
  `rezyser` varchar(32) DEFAULT NULL,
  `opis` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `film_ma_gatunki`
--

CREATE TABLE `film_ma_gatunki` (
  `Film_FilmID` int(11) NOT NULL,
  `Gatunki_GatunkiID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gatunki`
--

CREATE TABLE `gatunki` (
  `GatunkiID` int(11) NOT NULL,
  `gatunek` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kino`
--

CREATE TABLE `kino` (
  `KinoID` int(10) UNSIGNED NOT NULL COMMENT 'Identyfikator kina w sieci',
  `nazwa` varchar(32) NOT NULL,
  `adres` varchar(32) NOT NULL,
  `miasto` varchar(32) NOT NULL,
  `telefon` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `klient`
--

CREATE TABLE `klient` (
  `KlientID` int(11) NOT NULL,
  `login` char(12) NOT NULL,
  `email` char(24) NOT NULL,
  `haslo` binary(60) NOT NULL,
  `salt` char(16) DEFAULT NULL,
  `aktywny` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `miejscesala`
--

CREATE TABLE `miejscesala` (
  `idMiejsceSala` int(11) NOT NULL,
  `Sala_SalaID` int(11) NOT NULL,
  `miejsce` int(10) UNSIGNED NOT NULL,
  `rzad` int(10) UNSIGNED NOT NULL,
  `wolne` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `miejscezamowienie`
--

CREATE TABLE `miejscezamowienie` (
  `idMiejsceZamowienie` int(11) NOT NULL,
  `Zamowienie_ZamowienieID` int(11) NOT NULL,
  `MiejsceSala_idMiejsceSala` int(11) NOT NULL,
  `MiejsceSala_Sala_SalaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pracownicy`
--

CREATE TABLE `pracownicy` (
  `PracownicyID` int(10) UNSIGNED NOT NULL,
  `imie` varchar(45) NOT NULL,
  `nazwisko` varchar(45) NOT NULL,
  `stanowisko` enum('Colleague','Team Leader','Manager') NOT NULL,
  `etat` decimal(3,2) DEFAULT '1.00',
  `kasa` tinyint(1) DEFAULT NULL,
  `ksiazeczka_sanepid` tinyint(1) DEFAULT NULL,
  `Kino_KinoID` int(10) UNSIGNED NOT NULL,
  `haslo` binary(60) DEFAULT NULL,
  `salt` char(16) DEFAULT NULL,
  `aktywny` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `repertuar`
--

CREATE TABLE `repertuar` (
  `RepertuarID` int(11) NOT NULL,
  `Kino_KinoID` int(10) UNSIGNED NOT NULL,
  `Archiwum_ArchiwumID` int(11) NOT NULL,
  `Archiwun` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sala`
--

CREATE TABLE `sala` (
  `nazwa` varchar(16) DEFAULT NULL,
  `SalaID` int(11) NOT NULL,
  `numer` int(11) NOT NULL,
  `Kino_KinoID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `seans`
--

CREATE TABLE `seans` (
  `SeansID` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `cena` decimal(2,2) NOT NULL,
  `rodzaj` enum('2D','3D','4D') NOT NULL,
  `INFO` enum('DUB','SUB') DEFAULT NULL,
  `sprzedaz` tinyint(1) NOT NULL,
  `Film_FilmID` int(11) NOT NULL,
  `Repertuar_RepertuarID` int(11) NOT NULL,
  `Repertuar_Kino_KinoID` int(10) UNSIGNED NOT NULL,
  `Sala_SalaID` int(11) NOT NULL,
  `Sala_Kino_KinoID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `zamowienie`
--

CREATE TABLE `zamowienie` (
  `ZamowienieID` int(11) NOT NULL COMMENT 'ID Zamowienia',
  `Pracownicy_PracownicyID` int(10) UNSIGNED NOT NULL COMMENT ' klucz, gdy zamowienie sklada Pracownik',
  `Klient_KlientID` int(11) NOT NULL COMMENT 'klucz, uzywany gdy Klient sklada Zamowienie',
  `oplacone` tinyint(1) NOT NULL DEFAULT '0',
  `aktywne` tinyint(1) NOT NULL DEFAULT '1',
  `data` datetime NOT NULL,
  `oplacone_PracownicyID` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bilet`
--
ALTER TABLE `bilet`
  ADD PRIMARY KEY (`BiletID`,`Seans_SeansID`,`Seans_Repertuar_RepertuarID`,`Seans_Repertuar_Kino_KinoID`,`Zamowienie_ZamowienieID`),
  ADD KEY `fk_Bilet_Zamowienie1_idx` (`Zamowienie_ZamowienieID`),
  ADD KEY `fk_Bilet_Seans1_idx` (`Seans_SeansID`,`Seans_Repertuar_RepertuarID`,`Seans_Repertuar_Kino_KinoID`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`FilmID`),
  ADD UNIQUE KEY `idFILM_UNIQUE` (`FilmID`);

--
-- Indexes for table `film_ma_gatunki`
--
ALTER TABLE `film_ma_gatunki`
  ADD PRIMARY KEY (`Film_FilmID`,`Gatunki_GatunkiID`),
  ADD KEY `fk_Film_has_Gatunki_Gatunki1_idx` (`Gatunki_GatunkiID`),
  ADD KEY `fk_Film_has_Gatunki_Film1_idx` (`Film_FilmID`);

--
-- Indexes for table `gatunki`
--
ALTER TABLE `gatunki`
  ADD PRIMARY KEY (`GatunkiID`);

--
-- Indexes for table `kino`
--
ALTER TABLE `kino`
  ADD PRIMARY KEY (`KinoID`),
  ADD UNIQUE KEY `ID_KINO_UNIQUE` (`KinoID`);

--
-- Indexes for table `klient`
--
ALTER TABLE `klient`
  ADD PRIMARY KEY (`KlientID`);

--
-- Indexes for table `miejscesala`
--
ALTER TABLE `miejscesala`
  ADD PRIMARY KEY (`idMiejsceSala`,`Sala_SalaID`),
  ADD KEY `fk_MiejsceSala_Sala1_idx` (`Sala_SalaID`);

--
-- Indexes for table `miejscezamowienie`
--
ALTER TABLE `miejscezamowienie`
  ADD PRIMARY KEY (`Zamowienie_ZamowienieID`,`idMiejsceZamowienie`,`MiejsceSala_idMiejsceSala`,`MiejsceSala_Sala_SalaID`),
  ADD KEY `fk_MiejsceZamowienie_Zamowienie1_idx` (`Zamowienie_ZamowienieID`),
  ADD KEY `fk_MiejsceZamowienie_MiejsceSala1_idx` (`MiejsceSala_idMiejsceSala`,`MiejsceSala_Sala_SalaID`);

--
-- Indexes for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`PracownicyID`,`Kino_KinoID`),
  ADD UNIQUE KEY `idPRACOWNICY_UNIQUE` (`PracownicyID`),
  ADD KEY `fk_Pracownicy_Kino1_idx` (`Kino_KinoID`);

--
-- Indexes for table `repertuar`
--
ALTER TABLE `repertuar`
  ADD PRIMARY KEY (`RepertuarID`,`Kino_KinoID`),
  ADD KEY `fk_Repertuar_Kino1_idx` (`Kino_KinoID`);

--
-- Indexes for table `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`SalaID`,`Kino_KinoID`),
  ADD KEY `fk_Sala_Kino1_idx` (`Kino_KinoID`);

--
-- Indexes for table `seans`
--
ALTER TABLE `seans`
  ADD PRIMARY KEY (`SeansID`,`Repertuar_RepertuarID`,`Repertuar_Kino_KinoID`,`Sala_SalaID`,`Sala_Kino_KinoID`,`Film_FilmID`),
  ADD UNIQUE KEY `idSEANS_UNIQUE` (`SeansID`),
  ADD KEY `fk_Seans_Film1_idx` (`Film_FilmID`),
  ADD KEY `fk_Seans_Repertuar1_idx` (`Repertuar_RepertuarID`,`Repertuar_Kino_KinoID`),
  ADD KEY `fk_Seans_Sala1_idx` (`Sala_SalaID`,`Sala_Kino_KinoID`);

--
-- Indexes for table `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD PRIMARY KEY (`ZamowienieID`,`oplacone_PracownicyID`,`Pracownicy_PracownicyID`,`Klient_KlientID`),
  ADD UNIQUE KEY `ZamowienieID_UNIQUE` (`ZamowienieID`),
  ADD KEY `fk_Zamowienie_Pracownicy1_idx` (`Pracownicy_PracownicyID`),
  ADD KEY `fk_Zamowienie_Klient1_idx` (`Klient_KlientID`),
  ADD KEY `fk_Zamowienie_Pracownicy2` (`Pracownicy_PracownicyID`),
  ADD KEY `fk_Zamowienie_Pracownicy3_idx` (`oplacone_PracownicyID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bilet`
--
ALTER TABLE `bilet`
  MODIFY `BiletID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `film`
--
ALTER TABLE `film`
  MODIFY `FilmID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kino`
--
ALTER TABLE `kino`
  MODIFY `KinoID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identyfikator kina w sieci';
--
-- AUTO_INCREMENT for table `klient`
--
ALTER TABLE `klient`
  MODIFY `KlientID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `PracownicyID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `seans`
--
ALTER TABLE `seans`
  MODIFY `SeansID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `zamowienie`
--
ALTER TABLE `zamowienie`
  MODIFY `ZamowienieID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Zamowienia';
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bilet`
--
ALTER TABLE `bilet`
  ADD CONSTRAINT `fk_Bilet_Seans1` FOREIGN KEY (`Seans_SeansID`,`Seans_Repertuar_RepertuarID`,`Seans_Repertuar_Kino_KinoID`) REFERENCES `seans` (`SeansID`, `Repertuar_RepertuarID`, `Repertuar_Kino_KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilet_Zamowienie1` FOREIGN KEY (`Zamowienie_ZamowienieID`) REFERENCES `zamowienie` (`ZamowienieID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `film_ma_gatunki`
--
ALTER TABLE `film_ma_gatunki`
  ADD CONSTRAINT `fk_Film_has_Gatunki_Film1` FOREIGN KEY (`Film_FilmID`) REFERENCES `film` (`FilmID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Film_has_Gatunki_Gatunki1` FOREIGN KEY (`Gatunki_GatunkiID`) REFERENCES `gatunki` (`GatunkiID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `miejscesala`
--
ALTER TABLE `miejscesala`
  ADD CONSTRAINT `fk_MiejsceSala_Sala1` FOREIGN KEY (`Sala_SalaID`) REFERENCES `sala` (`SalaID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `miejscezamowienie`
--
ALTER TABLE `miejscezamowienie`
  ADD CONSTRAINT `fk_MiejsceZamowienie_MiejsceSala1` FOREIGN KEY (`MiejsceSala_idMiejsceSala`,`MiejsceSala_Sala_SalaID`) REFERENCES `miejscesala` (`idMiejsceSala`, `Sala_SalaID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_MiejsceZamowienie_Zamowienie1` FOREIGN KEY (`Zamowienie_ZamowienieID`) REFERENCES `zamowienie` (`ZamowienieID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD CONSTRAINT `fk_Pracownicy_Kino1` FOREIGN KEY (`Kino_KinoID`) REFERENCES `kino` (`KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `repertuar`
--
ALTER TABLE `repertuar`
  ADD CONSTRAINT `fk_Repertuar_Kino1` FOREIGN KEY (`Kino_KinoID`) REFERENCES `kino` (`KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `fk_Sala_Kino1` FOREIGN KEY (`Kino_KinoID`) REFERENCES `kino` (`KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `seans`
--
ALTER TABLE `seans`
  ADD CONSTRAINT `fk_Seans_Film1` FOREIGN KEY (`Film_FilmID`) REFERENCES `film` (`FilmID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Seans_Repertuar1` FOREIGN KEY (`Repertuar_RepertuarID`,`Repertuar_Kino_KinoID`) REFERENCES `repertuar` (`RepertuarID`, `Kino_KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Seans_Sala1` FOREIGN KEY (`Sala_SalaID`,`Sala_Kino_KinoID`) REFERENCES `sala` (`SalaID`, `Kino_KinoID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD CONSTRAINT `fk_Zamowienie_Klient1` FOREIGN KEY (`Klient_KlientID`) REFERENCES `klient` (`KlientID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Zamowienie_Pracownicy1` FOREIGN KEY (`Pracownicy_PracownicyID`) REFERENCES `pracownicy` (`PracownicyID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Zamowienie_Pracownicy3` FOREIGN KEY (`oplacone_PracownicyID`) REFERENCES `pracownicy` (`PracownicyID`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

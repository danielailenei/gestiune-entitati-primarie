-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2026 at 06:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `primarie_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `populeaza_persoane_reale` ()   BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO
        INSERT INTO persoane (
            cnp,
            nume,
            data_nasterii,
            adresa,
            telefon,
            email
        )
        VALUES (
            CONCAT('5000101', LPAD(i, 6, '0')),

            CASE (i MOD 10)
                WHEN 1 THEN CONCAT('Popescu Andrei ', i)
                WHEN 2 THEN CONCAT('Ionescu Maria ', i)
                WHEN 3 THEN CONCAT('Georgescu Elena ', i)
                WHEN 4 THEN CONCAT('Dumitrescu Mihai ', i)
                WHEN 5 THEN CONCAT('Stan Alexandra ', i)
                WHEN 6 THEN CONCAT('Radu Cristian ', i)
                WHEN 7 THEN CONCAT('Marin Ioana ', i)
                WHEN 8 THEN CONCAT('Tudor Gabriel ', i)
                WHEN 9 THEN CONCAT('Constantin Bianca ', i)
                ELSE CONCAT('Ilie Daniel ', i)
            END,

            DATE_ADD('1985-01-01', INTERVAL i DAY),

            CASE (i MOD 8)
                WHEN 1 THEN CONCAT('Strada Lalelelor nr. ', i)
                WHEN 2 THEN CONCAT('Strada Libertatii nr. ', i)
                WHEN 3 THEN CONCAT('Bulevardul Unirii nr. ', i)
                WHEN 4 THEN CONCAT('Strada Florilor nr. ', i)
                WHEN 5 THEN CONCAT('Strada Mihai Viteazu nr. ', i)
                WHEN 6 THEN CONCAT('Strada Independentei nr. ', i)
                WHEN 7 THEN CONCAT('Strada Primaverii nr. ', i)
                ELSE CONCAT('Strada Victoriei nr. ', i)
            END,

            CONCAT('07', LPAD(i, 8, '0')),

            CONCAT('persoana', i, '@primarie.ro')
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `firme`
--

CREATE TABLE `firme` (
  `id` int(11) NOT NULL,
  `cui` varchar(20) NOT NULL,
  `denumire` varchar(100) NOT NULL,
  `numar_angajati` int(11) NOT NULL,
  `domeniu_activitate` varchar(100) DEFAULT NULL,
  `capital_social` decimal(12,2) DEFAULT NULL,
  `cifra_afaceri` decimal(14,2) DEFAULT NULL,
  `profit` decimal(14,2) DEFAULT NULL,
  `an_infiintare` int(11) DEFAULT NULL,
  `adresa` varchar(255) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `firme`
--

INSERT INTO `firme` (`id`, `cui`, `denumire`, `numar_angajati`, `domeniu_activitate`, `capital_social`, `cifra_afaceri`, `profit`, `an_infiintare`, `adresa`, `telefon`, `email`, `created_at`) VALUES
(1, 'RO10000037', 'Alfa Construct SRL 1', 10, 'Comerț', 1250.00, 53750.00, 3850.00, 1991, 'Strada Industriei nr. 1', '0213200149', 'contact@alfaconstruct1.ro', '2026-05-17 13:07:43'),
(2, 'RO10000074', 'Beta Solutions SRL 2', 17, 'IT', 1500.00, 57500.00, 4700.00, 1992, 'Bulevardul Republicii nr. 2', '0314200298', 'office@betasolutions2.ro', '2026-05-17 13:07:43'),
(3, 'RO10000111', 'Delta Transport SRL 3', 24, 'Transport', 1750.00, 61250.00, 5550.00, 1993, 'Strada Fabricii nr. 3', '0744200447', 'contact@deltatransport3.ro', '2026-05-17 13:07:43'),
(4, 'RO10000148', 'Nova Market SRL 4', 31, 'Agricultură', 2000.00, 65000.00, 6400.00, 1994, 'Strada Comerciala nr. 4', '0728200596', 'office@novamarket4.ro', '2026-05-17 13:07:43'),
(5, 'RO10000185', 'Eco Servicii SRL 5', 38, 'Servicii', 2250.00, 68750.00, -4500.00, 1995, 'Strada Constructorilor nr. 5', '0769200745', 'contact@ecoservicii5.ro', '2026-05-17 13:07:43'),
(6, 'RO10000222', 'Urban Design SRL 6', 45, 'Sănătate', 2500.00, 72500.00, 8100.00, 1996, 'Bulevardul Unirii nr. 6', '0213200894', 'office@urbandesign6.ro', '2026-05-17 13:07:43'),
(7, 'RO10000259', 'Metal Pro SRL 7', 52, 'Educație', 2750.00, 76250.00, 8950.00, 1997, 'Strada Depozitelor nr. 7', '0314201043', 'contact@metalpro7.ro', '2026-05-17 13:07:43'),
(8, 'RO10000296', 'Agro Plus SRL 8', 59, 'Producție', 3000.00, 80000.00, 9800.00, 1998, 'Strada Tehnicii nr. 8', '0744201192', 'office@agroplus8.ro', '2026-05-17 13:07:43'),
(9, 'RO10000333', 'Info Tech SRL 9', 66, 'Turism', 3250.00, 83750.00, 10650.00, 1999, 'Strada Energiei nr. 9', '0728201341', 'contact@infotech9.ro', '2026-05-17 13:07:43'),
(10, 'RO10000370', 'Auto Expert SRL 10', 73, 'Construcții', 3500.00, 87500.00, -4000.00, 2000, 'Strada Antreprenorilor nr. 10', '0769201490', 'office@autoexpert10.ro', '2026-05-17 13:07:43'),
(11, 'RO10000407', 'Green Energy SRL 11', 80, 'Comerț', 3750.00, 91250.00, 12350.00, 2001, 'Strada Industriei nr. 11', '0213201639', 'contact@greenenergy11.ro', '2026-05-17 13:07:43'),
(12, 'RO10000444', 'Mobila Art SRL 12', 87, 'IT', 4000.00, 95000.00, 13200.00, 2002, 'Bulevardul Republicii nr. 12', '0314201788', 'office@mobilaart12.ro', '2026-05-17 13:07:43'),
(13, 'RO10000481', 'Rapid Logistic SRL 13', 94, 'Transport', 4250.00, 98750.00, 14050.00, 2003, 'Strada Fabricii nr. 13', '0744201937', 'contact@rapidlogistic13.ro', '2026-05-17 13:07:43'),
(14, 'RO10000518', 'Smart Consult SRL 14', 101, 'Agricultură', 4500.00, 102500.00, 14900.00, 2004, 'Strada Comerciala nr. 14', '0728202086', 'office@smartconsult14.ro', '2026-05-17 13:07:43'),
(15, 'RO10000555', 'Pro Instal SRL 15', 108, 'Servicii', 4750.00, 106250.00, -3500.00, 2005, 'Strada Constructorilor nr. 15', '0769202235', 'contact@proinstal15.ro', '2026-05-17 13:07:43'),
(16, 'RO10000592', 'Clean Service SRL 16', 115, 'Sănătate', 5000.00, 110000.00, 16600.00, 2006, 'Bulevardul Unirii nr. 16', '0213202384', 'office@cleanservice16.ro', '2026-05-17 13:07:43'),
(17, 'RO10000629', 'Top Medical SRL 17', 122, 'Educație', 5250.00, 113750.00, 17450.00, 2007, 'Strada Depozitelor nr. 17', '0314202533', 'contact@topmedical17.ro', '2026-05-17 13:07:43'),
(18, 'RO10000666', 'Media Vision SRL 18', 9, 'Producție', 5500.00, 117500.00, 18300.00, 2008, 'Strada Tehnicii nr. 18', '0744202682', 'office@mediavision18.ro', '2026-05-17 13:07:43'),
(19, 'RO10000703', 'Casa Decor SRL 19', 16, 'Turism', 5750.00, 121250.00, 19150.00, 2009, 'Strada Energiei nr. 19', '0728202831', 'contact@casadecor19.ro', '2026-05-17 13:07:44'),
(20, 'RO10000740', 'Global Trade SRL 20', 23, 'Construcții', 6000.00, 125000.00, -3000.00, 2010, 'Strada Antreprenorilor nr. 20', '0769202980', 'office@globaltrade20.ro', '2026-05-17 13:07:44'),
(21, 'RO10000777', 'Alfa Construct SRL 21', 30, 'Comerț', 6250.00, 128750.00, 20850.00, 2011, 'Strada Industriei nr. 21', '0213203129', 'contact@alfaconstruct21.ro', '2026-05-17 13:07:44'),
(22, 'RO10000814', 'Beta Solutions SRL 22', 37, 'IT', 6500.00, 132500.00, 21700.00, 2012, 'Bulevardul Republicii nr. 22', '0314203278', 'office@betasolutions22.ro', '2026-05-17 13:07:44'),
(23, 'RO10000851', 'Delta Transport SRL 23', 44, 'Transport', 6750.00, 136250.00, 22550.00, 2013, 'Strada Fabricii nr. 23', '0744203427', 'contact@deltatransport23.ro', '2026-05-17 13:07:44'),
(24, 'RO10000888', 'Nova Market SRL 24', 51, 'Agricultură', 7000.00, 140000.00, 23400.00, 2014, 'Strada Comerciala nr. 24', '0728203576', 'office@novamarket24.ro', '2026-05-17 13:07:44'),
(25, 'RO10000925', 'Eco Servicii SRL 25', 58, 'Servicii', 7250.00, 143750.00, -2500.00, 2015, 'Strada Constructorilor nr. 25', '0769203725', 'contact@ecoservicii25.ro', '2026-05-17 13:07:44'),
(26, 'RO10000962', 'Urban Design SRL 26', 65, 'Sănătate', 7500.00, 147500.00, 25100.00, 2016, 'Bulevardul Unirii nr. 26', '0213203874', 'office@urbandesign26.ro', '2026-05-17 13:07:44'),
(27, 'RO10000999', 'Metal Pro SRL 27', 72, 'Educație', 7750.00, 151250.00, 25950.00, 2017, 'Strada Depozitelor nr. 27', '0314204023', 'contact@metalpro27.ro', '2026-05-17 13:07:44'),
(28, 'RO10001036', 'Agro Plus SRL 28', 79, 'Producție', 8000.00, 155000.00, 26800.00, 2018, 'Strada Tehnicii nr. 28', '0744204172', 'office@agroplus28.ro', '2026-05-17 13:07:44'),
(29, 'RO10001073', 'Info Tech SRL 29', 86, 'Turism', 8250.00, 158750.00, 27650.00, 2019, 'Strada Energiei nr. 29', '0728204321', 'contact@infotech29.ro', '2026-05-17 13:07:44'),
(30, 'RO10001110', 'Auto Expert SRL 30', 93, 'Construcții', 8500.00, 162500.00, -2000.00, 2020, 'Strada Antreprenorilor nr. 30', '0769204470', 'office@autoexpert30.ro', '2026-05-17 13:07:44'),
(31, 'RO10001147', 'Green Energy SRL 31', 100, 'Comerț', 8750.00, 166250.00, 29350.00, 2021, 'Strada Industriei nr. 31', '0213204619', 'contact@greenenergy31.ro', '2026-05-17 13:07:44'),
(32, 'RO10001184', 'Mobila Art SRL 32', 107, 'IT', 9000.00, 170000.00, 30200.00, 2022, 'Bulevardul Republicii nr. 32', '0314204768', 'office@mobilaart32.ro', '2026-05-17 13:07:44'),
(33, 'RO10001221', 'Rapid Logistic SRL 33', 114, 'Transport', 9250.00, 173750.00, 31050.00, 2023, 'Strada Fabricii nr. 33', '0744204917', 'contact@rapidlogistic33.ro', '2026-05-17 13:07:44'),
(34, 'RO10001258', 'Smart Consult SRL 34', 121, 'Agricultură', 9500.00, 177500.00, 31900.00, 1990, 'Strada Comerciala nr. 34', '0728205066', 'office@smartconsult34.ro', '2026-05-17 13:07:44'),
(35, 'RO10001295', 'Pro Instal SRL 35', 8, 'Servicii', 9750.00, 181250.00, -1500.00, 1991, 'Strada Constructorilor nr. 35', '0769205215', 'contact@proinstal35.ro', '2026-05-17 13:07:44'),
(36, 'RO10001332', 'Clean Service SRL 36', 15, 'Sănătate', 10000.00, 185000.00, 33600.00, 1992, 'Bulevardul Unirii nr. 36', '0213205364', 'office@cleanservice36.ro', '2026-05-17 13:07:44'),
(37, 'RO10001369', 'Top Medical SRL 37', 22, 'Educație', 10250.00, 188750.00, 34450.00, 1993, 'Strada Depozitelor nr. 37', '0314205513', 'contact@topmedical37.ro', '2026-05-17 13:07:44'),
(38, 'RO10001406', 'Media Vision SRL 38', 29, 'Producție', 10500.00, 192500.00, 35300.00, 1994, 'Strada Tehnicii nr. 38', '0744205662', 'office@mediavision38.ro', '2026-05-17 13:07:44'),
(39, 'RO10001443', 'Casa Decor SRL 39', 36, 'Turism', 10750.00, 196250.00, 36150.00, 1995, 'Strada Energiei nr. 39', '0728205811', 'contact@casadecor39.ro', '2026-05-17 13:07:44'),
(40, 'RO10001480', 'Global Trade SRL 40', 43, 'Construcții', 11000.00, 200000.00, -1000.00, 1996, 'Strada Antreprenorilor nr. 40', '0769205960', 'office@globaltrade40.ro', '2026-05-17 13:07:44'),
(41, 'RO10001517', 'Alfa Construct SRL 41', 50, 'Comerț', 11250.00, 203750.00, 37850.00, 1997, 'Strada Industriei nr. 41', '0213206109', 'contact@alfaconstruct41.ro', '2026-05-17 13:07:44'),
(42, 'RO10001554', 'Beta Solutions SRL 42', 57, 'IT', 11500.00, 207500.00, 38700.00, 1998, 'Bulevardul Republicii nr. 42', '0314206258', 'office@betasolutions42.ro', '2026-05-17 13:07:44'),
(43, 'RO10001591', 'Delta Transport SRL 43', 64, 'Transport', 11750.00, 211250.00, 39550.00, 1999, 'Strada Fabricii nr. 43', '0744206407', 'contact@deltatransport43.ro', '2026-05-17 13:07:44'),
(44, 'RO10001628', 'Nova Market SRL 44', 71, 'Agricultură', 12000.00, 215000.00, 40400.00, 2000, 'Strada Comerciala nr. 44', '0728206556', 'office@novamarket44.ro', '2026-05-17 13:07:44'),
(45, 'RO10001665', 'Eco Servicii SRL 45', 78, 'Servicii', 12250.00, 218750.00, -500.00, 2001, 'Strada Constructorilor nr. 45', '0769206705', 'contact@ecoservicii45.ro', '2026-05-17 13:07:44'),
(46, 'RO10001702', 'Urban Design SRL 46', 85, 'Sănătate', 12500.00, 222500.00, 42100.00, 2002, 'Bulevardul Unirii nr. 46', '0213206854', 'office@urbandesign46.ro', '2026-05-17 13:07:44'),
(47, 'RO10001739', 'Metal Pro SRL 47', 92, 'Educație', 12750.00, 226250.00, 42950.00, 2003, 'Strada Depozitelor nr. 47', '0314207003', 'contact@metalpro47.ro', '2026-05-17 13:07:44'),
(48, 'RO10001776', 'Agro Plus SRL 48', 99, 'Producție', 13000.00, 230000.00, 43800.00, 2004, 'Strada Tehnicii nr. 48', '0744207152', 'office@agroplus48.ro', '2026-05-17 13:07:44'),
(49, 'RO10001813', 'Info Tech SRL 49', 106, 'Turism', 13250.00, 233750.00, 44650.00, 2005, 'Strada Energiei nr. 49', '0728207301', 'contact@infotech49.ro', '2026-05-17 13:07:44'),
(50, 'RO10001850', 'Auto Expert SRL 50', 113, 'Construcții', 13500.00, 237500.00, 0.00, 2006, 'Strada Antreprenorilor nr. 50', '0769207450', 'office@autoexpert50.ro', '2026-05-17 13:07:44'),
(51, 'RO10001887', 'Green Energy SRL 51', 120, 'Comerț', 13750.00, 241250.00, 46350.00, 2007, 'Strada Industriei nr. 51', '0213207599', 'contact@greenenergy51.ro', '2026-05-17 13:07:44'),
(52, 'RO10001924', 'Mobila Art SRL 52', 7, 'IT', 14000.00, 245000.00, 47200.00, 2008, 'Bulevardul Republicii nr. 52', '0314207748', 'office@mobilaart52.ro', '2026-05-17 13:07:44'),
(53, 'RO10001961', 'Rapid Logistic SRL 53', 14, 'Transport', 14250.00, 248750.00, 48050.00, 2009, 'Strada Fabricii nr. 53', '0744207897', 'contact@rapidlogistic53.ro', '2026-05-17 13:07:44'),
(54, 'RO10001998', 'Smart Consult SRL 54', 21, 'Agricultură', 14500.00, 252500.00, 48900.00, 2010, 'Strada Comerciala nr. 54', '0728208046', 'office@smartconsult54.ro', '2026-05-17 13:07:44'),
(55, 'RO10002035', 'Pro Instal SRL 55', 28, 'Servicii', 14750.00, 256250.00, 500.00, 2011, 'Strada Constructorilor nr. 55', '0769208195', 'contact@proinstal55.ro', '2026-05-17 13:07:44'),
(56, 'RO10002072', 'Clean Service SRL 56', 35, 'Sănătate', 15000.00, 260000.00, 50600.00, 2012, 'Bulevardul Unirii nr. 56', '0213208344', 'office@cleanservice56.ro', '2026-05-17 13:07:44'),
(57, 'RO10002109', 'Top Medical SRL 57', 42, 'Educație', 15250.00, 263750.00, 51450.00, 2013, 'Strada Depozitelor nr. 57', '0314208493', 'contact@topmedical57.ro', '2026-05-17 13:07:44'),
(58, 'RO10002146', 'Media Vision SRL 58', 49, 'Producție', 15500.00, 267500.00, 52300.00, 2014, 'Strada Tehnicii nr. 58', '0744208642', 'office@mediavision58.ro', '2026-05-17 13:07:44'),
(59, 'RO10002183', 'Casa Decor SRL 59', 56, 'Turism', 15750.00, 271250.00, 53150.00, 2015, 'Strada Energiei nr. 59', '0728208791', 'contact@casadecor59.ro', '2026-05-17 13:07:44'),
(60, 'RO10002220', 'Global Trade SRL 60', 63, 'Construcții', 16000.00, 275000.00, 1000.00, 2016, 'Strada Antreprenorilor nr. 60', '0769208940', 'office@globaltrade60.ro', '2026-05-17 13:07:44');

-- --------------------------------------------------------

--
-- Table structure for table `persoane`
--

CREATE TABLE `persoane` (
  `id` int(11) NOT NULL,
  `cnp` varchar(13) NOT NULL,
  `nume` varchar(100) NOT NULL,
  `data_nasterii` date NOT NULL,
  `studii` varchar(50) DEFAULT NULL,
  `mediu` varchar(20) DEFAULT NULL,
  `stare_civila` varchar(30) DEFAULT NULL,
  `ocupatie` varchar(50) DEFAULT NULL,
  `adresa` varchar(255) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `persoane`
--

INSERT INTO `persoane` (`id`, `cnp`, `nume`, `data_nasterii`, `studii`, `mediu`, `stare_civila`, `ocupatie`, `adresa`, `telefon`, `email`, `created_at`) VALUES
(1, '6090202000001', 'Popescu Andrei', '2009-02-02', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Florilor nr. 1, Iași', '0745100137', 'andrei.popescu1@gmail.com', '2026-05-19 16:05:18'),
(2, '5100303000002', 'Ionescu Maria', '2010-03-03', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Bulevardul Unirii nr. 2, Iași', '0766100274', 'maria.ionescu2@gmail.com', '2026-05-19 16:05:18'),
(3, '6110404000003', 'Georgescu Elena', '2011-04-04', 'Gimnaziale', 'Rural', 'Necăsătorit/ă', 'Elev', 'Strada Libertății nr. 3, Iași', '0731100411', 'elena.georgescu3@gmail.com', '2026-05-19 16:05:18'),
(4, '5120505000004', 'Dumitrescu Mihai', '2012-05-05', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Victoriei nr. 4, Iași', '0758100548', 'mihai.dumitrescu4@gmail.com', '2026-05-19 16:05:18'),
(5, '6080606000005', 'Stan Alexandra', '2008-06-06', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Primăverii nr. 5, Iași', '0723100685', 'alexandra.stan5@gmail.com', '2026-05-19 16:05:18'),
(6, '5090707000006', 'Radu Cristian', '2009-07-07', 'Gimnaziale', 'Rural', 'Necăsătorit/ă', 'Elev', 'Strada Mihai Viteazu nr. 6, Iași', '0745100822', 'cristian.radu6@gmail.com', '2026-05-19 16:05:18'),
(7, '6100808000007', 'Marin Ioana', '2010-08-08', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Independenței nr. 7,Iași', '0766100959', 'ioana.marin7@gmail.com', '2026-05-19 16:05:18'),
(8, '5110909000008', 'Tudor Gabriel', '2011-09-09', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Bulevardul Republicii nr. 8, Iași', '0731101096', 'gabriel.tudor8@gmail.com', '2026-05-19 16:05:18'),
(9, '6121010000009', 'Constantin Bianca', '2012-10-10', 'Gimnaziale', 'Rural', 'Necăsătorit/ă', 'Elev', 'Strada Lalelelor nr. 9, Iași', '0758101233', 'bianca.constantin9@gmail.com', '2026-05-19 16:05:18'),
(10, '5081111000010', 'Ilie Daniel', '2008-11-11', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Aviatorilor nr. 10, Iași', '0723101370', 'daniel.ilie10@gmail.com', '2026-05-19 16:05:18'),
(11, '6091212000011', 'Voicu Larisa', '2009-12-12', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Florilor nr. 11, Iași', '0745101507', 'larisa.voicu11@gmail.com', '2026-05-19 16:05:18'),
(12, '5100113000012', 'Mihalache Sorin', '2010-01-13', 'Gimnaziale', 'Rural', 'Necăsătorit/ă', 'Elev', 'Bulevardul Unirii nr. 12, Iași', '0766101644', 'sorin.mihalache12@gmail.com', '2026-05-19 16:05:18'),
(13, '6110214000013', 'Dobre Ana', '2011-02-14', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Libertății nr. 13, Iași', '0731101781', 'ana.dobre13@gmail.com', '2026-05-19 16:05:18'),
(14, '5120315000014', 'Nistor Vlad', '2012-03-15', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Elev', 'Strada Victoriei nr. 14, Iași', '0758101918', 'vlad.nistor14@gmail.com', '2026-05-19 16:05:18'),
(15, '6080416000015', 'Enache Teodora', '2008-04-16', 'Gimnaziale', 'Rural', 'Necăsătorit/ă', 'Elev', 'Strada Primăverii nr. 15, Iași', '0723102055', 'teodora.enache15@gmail.com', '2026-05-19 16:05:18'),
(16, '5030517000016', 'Barbu Florin', '2003-05-17', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Mihai Viteazu nr. 16, Iași', '0745102192', 'florin.barbu16@gmail.com', '2026-05-19 16:05:18'),
(17, '6040618000017', 'Preda Camelia', '2004-06-18', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Independenței nr. 17,Iași', '0766102329', 'camelia.preda17@gmail.com', '2026-05-19 16:05:18'),
(18, '5050719000018', 'Munteanu Rares', '2005-07-19', 'Liceale', 'Rural', 'Necăsătorit/ă', 'Student', 'Bulevardul Republicii nr. 18, Iași', '0731102466', 'rares.munteanu18@gmail.com', '2026-05-19 16:05:18'),
(19, '6060820000019', 'Neagu Patricia', '2006-08-20', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Lalelelor nr. 19, Iași', '0758102603', 'patricia.neagu19@gmail.com', '2026-05-19 16:05:18'),
(20, '5070921000020', 'Dragomir Stefan', '2007-09-21', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Aviatorilor nr. 20, Iași', '0723102740', 'stefan.dragomir20@gmail.com', '2026-05-19 16:05:18'),
(21, '6011022000021', 'Popescu Andrei', '2001-10-22', 'Universitare', 'Rural', 'Necăsătorit/ă', 'Student', 'Strada Florilor nr. 21, Iași', '0745102877', 'andrei.popescu21@gmail.com', '2026-05-19 16:05:18'),
(22, '5021123000022', 'Ionescu Maria', '2002-11-23', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Bulevardul Unirii nr. 22, Iași', '0766103014', 'maria.ionescu22@gmail.com', '2026-05-19 16:05:18'),
(23, '6031224000023', 'Georgescu Elena', '2003-12-24', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Libertății nr. 23, Iași', '0731103151', 'elena.georgescu23@gmail.com', '2026-05-19 16:05:18'),
(24, '5040125000024', 'Dumitrescu Mihai', '2004-01-25', 'Liceale', 'Rural', 'Căsătorit/ă', 'Student', 'Strada Victoriei nr. 24, Iași', '0758103288', 'mihai.dumitrescu24@gmail.com', '2026-05-19 16:05:18'),
(25, '6050226000025', 'Stan Alexandra', '2005-02-26', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Primăverii nr. 25, Iași', '0723103425', 'alexandra.stan25@gmail.com', '2026-05-19 16:05:18'),
(26, '5060327000026', 'Radu Cristian', '2006-03-27', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Mihai Viteazu nr. 26, Iași', '0745103562', 'cristian.radu26@gmail.com', '2026-05-19 16:05:18'),
(27, '6070401000027', 'Marin Ioana', '2007-04-01', 'Universitare', 'Rural', 'Necăsătorit/ă', 'Student', 'Strada Independenței nr. 27,Iași', '0766103699', 'ioana.marin27@gmail.com', '2026-05-19 16:05:18'),
(28, '5010502000028', 'Tudor Gabriel', '2001-05-02', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Bulevardul Republicii nr. 28, Iași', '0731103836', 'gabriel.tudor28@gmail.com', '2026-05-19 16:05:18'),
(29, '6020603000029', 'Constantin Bianca', '2002-06-03', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Lalelelor nr. 29, Iași', '0758103973', 'bianca.constantin29@gmail.com', '2026-05-19 16:05:18'),
(30, '5030704000030', 'Ilie Daniel', '2003-07-04', 'Liceale', 'Rural', 'Necăsătorit/ă', 'Student', 'Strada Aviatorilor nr. 30, Iași', '0723104110', 'daniel.ilie30@gmail.com', '2026-05-19 16:05:18'),
(31, '6040805000031', 'Voicu Larisa', '2004-08-05', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Florilor nr. 31, Iași', '0745104247', 'larisa.voicu31@gmail.com', '2026-05-19 16:05:18'),
(32, '5050906000032', 'Mihalache Sorin', '2005-09-06', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Bulevardul Unirii nr. 32, Iași', '0766104384', 'sorin.mihalache32@gmail.com', '2026-05-19 16:05:18'),
(33, '6061007000033', 'Dobre Ana', '2006-10-07', 'Universitare', 'Rural', 'Necăsătorit/ă', 'Student', 'Strada Libertății nr. 33, Iași', '0731104521', 'ana.dobre33@gmail.com', '2026-05-19 16:05:18'),
(34, '5071108000034', 'Nistor Vlad', '2007-11-08', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Victoriei nr. 34, Iași', '0758104658', 'vlad.nistor34@gmail.com', '2026-05-19 16:05:18'),
(35, '6011209000035', 'Enache Teodora', '2001-12-09', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Student', 'Strada Primăverii nr. 35, Iași', '0723104795', 'teodora.enache35@gmail.com', '2026-05-19 16:05:18'),
(36, '5970110000036', 'Barbu Florin', '1997-01-10', 'Universitare', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 36, Iași', '0745104932', 'florin.barbu36@gmail.com', '2026-05-19 16:05:18'),
(37, '6980211000037', 'Preda Camelia', '1998-02-11', 'Masterat', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Independenței nr. 37,Iași', '0766105069', 'camelia.preda37@gmail.com', '2026-05-19 16:05:18'),
(38, '5990312000038', 'Munteanu Rares', '1999-03-12', 'Postliceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Bulevardul Republicii nr. 38, Iași', '0731105206', 'rares.munteanu38@gmail.com', '2026-05-19 16:05:18'),
(39, '6000413000039', 'Neagu Patricia', '2000-04-13', 'Liceale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Lalelelor nr. 39, Iași', '0758105343', 'patricia.neagu39@gmail.com', '2026-05-19 16:05:18'),
(40, '5910514000040', 'Dragomir Stefan', '1991-05-14', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Antreprenor', 'Strada Aviatorilor nr. 40, Iași', '0723105480', 'stefan.dragomir40@gmail.com', '2026-05-19 16:05:18'),
(41, '6920615000041', 'Popescu Andrei', '1992-06-15', 'Masterat', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Florilor nr. 41, Iași', '0745105617', 'andrei.popescu41@gmail.com', '2026-05-19 16:05:18'),
(42, '5930716000042', 'Ionescu Maria', '1993-07-16', 'Postliceale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Bulevardul Unirii nr. 42, Iași', '0766105754', 'maria.ionescu42@gmail.com', '2026-05-19 16:05:18'),
(43, '6940817000043', 'Georgescu Elena', '1994-08-17', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Libertății nr. 43, Iași', '0731105891', 'elena.georgescu43@gmail.com', '2026-05-19 16:05:18'),
(44, '5950918000044', 'Dumitrescu Mihai', '1995-09-18', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Victoriei nr. 44, Iași', '0758106028', 'mihai.dumitrescu44@gmail.com', '2026-05-19 16:05:18'),
(45, '6961019000045', 'Stan Alexandra', '1996-10-19', 'Masterat', 'Rural', 'Căsătorit/ă', 'Antreprenor', 'Strada Primăverii nr. 45, Iași', '0723106165', 'alexandra.stan45@gmail.com', '2026-05-19 16:05:18'),
(46, '5971120000046', 'Radu Cristian', '1997-11-20', 'Postliceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 46, Iași', '0745106302', 'cristian.radu46@gmail.com', '2026-05-19 16:05:18'),
(47, '6981221000047', 'Marin Ioana', '1998-12-21', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Independenței nr. 47,Iași', '0766106439', 'ioana.marin47@gmail.com', '2026-05-19 16:05:18'),
(48, '5990122000048', 'Tudor Gabriel', '1999-01-22', 'Universitare', 'Rural', 'Căsătorit/ă', 'Angajat', 'Bulevardul Republicii nr. 48, Iași', '0731106576', 'gabriel.tudor48@gmail.com', '2026-05-19 16:05:18'),
(49, '6000223000049', 'Constantin Bianca', '2000-02-23', 'Masterat', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Lalelelor nr. 49, Iași', '0758106713', 'bianca.constantin49@gmail.com', '2026-05-19 16:05:18'),
(50, '5910324000050', 'Ilie Daniel', '1991-03-24', 'Postliceale', 'Urban', 'Necăsătorit/ă', 'Antreprenor', 'Strada Aviatorilor nr. 50, Iași', '0723106850', 'daniel.ilie50@gmail.com', '2026-05-19 16:05:18'),
(51, '6920425000051', 'Voicu Larisa', '1992-04-25', 'Liceale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Florilor nr. 51, Iași', '0745106987', 'larisa.voicu51@gmail.com', '2026-05-19 16:05:18'),
(52, '5930526000052', 'Mihalache Sorin', '1993-05-26', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Bulevardul Unirii nr. 52, Iași', '0766107124', 'sorin.mihalache52@gmail.com', '2026-05-19 16:05:18'),
(53, '6940627000053', 'Dobre Ana', '1994-06-27', 'Masterat', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Libertății nr. 53, Iași', '0731107261', 'ana.dobre53@gmail.com', '2026-05-19 16:05:18'),
(54, '5950701000054', 'Nistor Vlad', '1995-07-01', 'Postliceale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Victoriei nr. 54, Iași', '0758107398', 'vlad.nistor54@gmail.com', '2026-05-19 16:05:18'),
(55, '6960802000055', 'Enache Teodora', '1996-08-02', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Antreprenor', 'Strada Primăverii nr. 55, Iași', '0723107535', 'teodora.enache55@gmail.com', '2026-05-19 16:05:18'),
(56, '5970903000056', 'Barbu Florin', '1997-09-03', 'Universitare', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 56, Iași', '0745107672', 'florin.barbu56@gmail.com', '2026-05-19 16:05:18'),
(57, '6981004000057', 'Preda Camelia', '1998-10-04', 'Masterat', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Independenței nr. 57,Iași', '0766107809', 'camelia.preda57@gmail.com', '2026-05-19 16:05:18'),
(58, '5991105000058', 'Munteanu Rares', '1999-11-05', 'Postliceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Bulevardul Republicii nr. 58, Iași', '0731107946', 'rares.munteanu58@gmail.com', '2026-05-19 16:05:18'),
(59, '6001206000059', 'Neagu Patricia', '2000-12-06', 'Liceale', 'Urban', 'Necăsătorit/ă', 'Angajat', 'Strada Lalelelor nr. 59, Iași', '0758108083', 'patricia.neagu59@gmail.com', '2026-05-19 16:05:18'),
(60, '5910107000060', 'Dragomir Stefan', '1991-01-07', 'Universitare', 'Rural', 'Căsătorit/ă', 'Antreprenor', 'Strada Aviatorilor nr. 60, Iași', '0723108220', 'stefan.dragomir60@gmail.com', '2026-05-19 16:05:18'),
(61, '6720208000061', 'Popescu Andrei', '1972-02-08', 'Postliceale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Florilor nr. 61, Iași', '0745108357', 'andrei.popescu61@gmail.com', '2026-05-19 16:05:18'),
(62, '5730309000062', 'Ionescu Maria', '1973-03-09', 'Universitare', 'Urban', 'Căsătorit/ă', 'Angajat', 'Bulevardul Unirii nr. 62, Iași', '0766108494', 'maria.ionescu62@gmail.com', '2026-05-19 16:05:18'),
(63, '6740410000063', 'Georgescu Elena', '1974-04-10', 'Masterat', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Libertății nr. 63, Iași', '0731108631', 'elena.georgescu63@gmail.com', '2026-05-19 16:05:18'),
(64, '5750511000064', 'Dumitrescu Mihai', '1975-05-11', 'Gimnaziale', 'Urban', 'Căsătorit/ă', 'Șomer', 'Strada Victoriei nr. 64, Iași', '0758108768', 'mihai.dumitrescu64@gmail.com', '2026-05-19 16:05:18'),
(65, '6760612000065', 'Stan Alexandra', '1976-06-12', 'Liceale', 'Urban', 'Divorțat/ă', 'Antreprenor', 'Strada Primăverii nr. 65, Iași', '0723108905', 'alexandra.stan65@gmail.com', '2026-05-19 16:05:18'),
(66, '5770713000066', 'Radu Cristian', '1977-07-13', 'Postliceale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 66, Iași', '0745109042', 'cristian.radu66@gmail.com', '2026-05-19 16:05:18'),
(67, '6780814000067', 'Marin Ioana', '1978-08-14', 'Universitare', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Independenței nr. 67,Iași', '0766109179', 'ioana.marin67@gmail.com', '2026-05-19 16:05:18'),
(68, '5790915000068', 'Tudor Gabriel', '1979-09-15', 'Masterat', 'Urban', 'Căsătorit/ă', 'Angajat', 'Bulevardul Republicii nr. 68, Iași', '0731109316', 'gabriel.tudor68@gmail.com', '2026-05-19 16:05:18'),
(69, '6801016000069', 'Constantin Bianca', '1980-10-16', 'Gimnaziale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Lalelelor nr. 69, Iași', '0758109453', 'bianca.constantin69@gmail.com', '2026-05-19 16:05:18'),
(70, '5811117000070', 'Ilie Daniel', '1981-11-17', 'Liceale', 'Urban', 'Divorțat/ă', 'Angajat', 'Strada Aviatorilor nr. 70, Iași', '0723109590', 'daniel.ilie70@gmail.com', '2026-05-19 16:05:18'),
(71, '6821218000071', 'Voicu Larisa', '1982-12-18', 'Postliceale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Florilor nr. 71, Iași', '0745109727', 'larisa.voicu71@gmail.com', '2026-05-19 16:05:18'),
(72, '5830119000072', 'Mihalache Sorin', '1983-01-19', 'Universitare', 'Rural', 'Căsătorit/ă', 'Șomer', 'Bulevardul Unirii nr. 72, Iași', '0766109864', 'sorin.mihalache72@gmail.com', '2026-05-19 16:05:18'),
(73, '6840220000073', 'Dobre Ana', '1984-02-20', 'Masterat', 'Urban', 'Căsătorit/ă', 'Antreprenor', 'Strada Libertății nr. 73, Iași', '0731110001', 'ana.dobre73@gmail.com', '2026-05-19 16:05:18'),
(74, '5850321000074', 'Nistor Vlad', '1985-03-21', 'Gimnaziale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Victoriei nr. 74, Iași', '0758110138', 'vlad.nistor74@gmail.com', '2026-05-19 16:05:18'),
(75, '6860422000075', 'Enache Teodora', '1986-04-22', 'Liceale', 'Rural', 'Divorțat/ă', 'Angajat', 'Strada Primăverii nr. 75, Iași', '0723110275', 'teodora.enache75@gmail.com', '2026-05-19 16:05:18'),
(76, '5870523000076', 'Barbu Florin', '1987-05-23', 'Postliceale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 76, Iași', '0745110412', 'florin.barbu76@gmail.com', '2026-05-19 16:05:18'),
(77, '6880624000077', 'Preda Camelia', '1988-06-24', 'Universitare', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Independenței nr. 77,Iași', '0766110549', 'camelia.preda77@gmail.com', '2026-05-19 16:05:18'),
(78, '5890725000078', 'Munteanu Rares', '1989-07-25', 'Masterat', 'Rural', 'Căsătorit/ă', 'Angajat', 'Bulevardul Republicii nr. 78, Iași', '0731110686', 'rares.munteanu78@gmail.com', '2026-05-19 16:05:18'),
(79, '6900826000079', 'Neagu Patricia', '1990-08-26', 'Gimnaziale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Lalelelor nr. 79, Iași', '0758110823', 'patricia.neagu79@gmail.com', '2026-05-19 16:05:18'),
(80, '5710927000080', 'Dragomir Stefan', '1971-09-27', 'Liceale', 'Urban', 'Divorțat/ă', 'Șomer', 'Strada Aviatorilor nr. 80, Iași', '0723110960', 'stefan.dragomir80@gmail.com', '2026-05-19 16:05:18'),
(81, '6721001000081', 'Popescu Andrei', '1972-10-01', 'Postliceale', 'Rural', 'Căsătorit/ă', 'Antreprenor', 'Strada Florilor nr. 81, Iași', '0745111097', 'andrei.popescu81@gmail.com', '2026-05-19 16:05:18'),
(82, '5731102000082', 'Ionescu Maria', '1973-11-02', 'Universitare', 'Urban', 'Căsătorit/ă', 'Angajat', 'Bulevardul Unirii nr. 82, Iași', '0766111234', 'maria.ionescu82@gmail.com', '2026-05-19 16:05:18'),
(83, '6741203000083', 'Georgescu Elena', '1974-12-03', 'Masterat', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Libertății nr. 83, Iași', '0731111371', 'elena.georgescu83@gmail.com', '2026-05-19 16:05:18'),
(84, '5750104000084', 'Dumitrescu Mihai', '1975-01-04', 'Gimnaziale', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Victoriei nr. 84, Iași', '0758111508', 'mihai.dumitrescu84@gmail.com', '2026-05-19 16:05:18'),
(85, '6760205000085', 'Stan Alexandra', '1976-02-05', 'Liceale', 'Urban', 'Divorțat/ă', 'Angajat', 'Strada Primăverii nr. 85, Iași', '0723111645', 'alexandra.stan85@gmail.com', '2026-05-19 16:05:18'),
(86, '5770306000086', 'Radu Cristian', '1977-03-06', 'Postliceale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Mihai Viteazu nr. 86, Iași', '0745111782', 'cristian.radu86@gmail.com', '2026-05-19 16:05:18'),
(87, '6780407000087', 'Marin Ioana', '1978-04-07', 'Universitare', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Independenței nr. 87,Iași', '0766111919', 'ioana.marin87@gmail.com', '2026-05-19 16:05:18'),
(88, '5790508000088', 'Tudor Gabriel', '1979-05-08', 'Masterat', 'Urban', 'Căsătorit/ă', 'Șomer', 'Bulevardul Republicii nr. 88, Iași', '0731112056', 'gabriel.tudor88@gmail.com', '2026-05-19 16:05:18'),
(89, '6800609000089', 'Constantin Bianca', '1980-06-09', 'Gimnaziale', 'Urban', 'Căsătorit/ă', 'Antreprenor', 'Strada Lalelelor nr. 89, Iași', '0758112193', 'bianca.constantin89@gmail.com', '2026-05-19 16:05:18'),
(90, '5810710000090', 'Ilie Daniel', '1981-07-10', 'Liceale', 'Rural', 'Divorțat/ă', 'Angajat', 'Strada Aviatorilor nr. 90, Iași', '0723112330', 'daniel.ilie90@gmail.com', '2026-05-19 16:05:18'),
(91, '6820811000091', 'Voicu Larisa', '1982-08-11', 'Postliceale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Florilor nr. 91, Iași', '0745112467', 'larisa.voicu91@gmail.com', '2026-05-19 16:05:18'),
(92, '5830912000092', 'Mihalache Sorin', '1983-09-12', 'Universitare', 'Urban', 'Căsătorit/ă', 'Angajat', 'Bulevardul Unirii nr. 92, Iași', '0766112604', 'sorin.mihalache92@gmail.com', '2026-05-19 16:05:18'),
(93, '6841013000093', 'Dobre Ana', '1984-10-13', 'Masterat', 'Rural', 'Căsătorit/ă', 'Angajat', 'Strada Libertății nr. 93, Iași', '0731112741', 'ana.dobre93@gmail.com', '2026-05-19 16:05:18'),
(94, '5851114000094', 'Nistor Vlad', '1985-11-14', 'Gimnaziale', 'Urban', 'Căsătorit/ă', 'Angajat', 'Strada Victoriei nr. 94, Iași', '0758112878', 'vlad.nistor94@gmail.com', '2026-05-19 16:05:19'),
(95, '6861215000095', 'Enache Teodora', '1986-12-15', 'Liceale', 'Urban', 'Divorțat/ă', 'Angajat', 'Strada Primăverii nr. 95, Iași', '0723113015', 'teodora.enache95@gmail.com', '2026-05-19 16:05:19'),
(96, '5670116000096', 'Barbu Florin', '1967-01-16', 'Gimnaziale', 'Rural', 'Văduv/ă', 'Pensionar', 'Strada Mihai Viteazu nr. 96, Iași', '0745113152', 'florin.barbu96@gmail.com', '2026-05-19 16:05:19'),
(97, '6680217000097', 'Preda Camelia', '1968-02-17', 'Liceale', 'Urban', 'Căsătorit/ă', 'Pensionar', 'Strada Independenței nr. 97,Iași', '0766113289', 'camelia.preda97@gmail.com', '2026-05-19 16:05:19'),
(98, '5690318000098', 'Munteanu Rares', '1969-03-18', 'Postliceale', 'Urban', 'Divorțat/ă', 'Pensionar', 'Bulevardul Republicii nr. 98, Iași', '0731113426', 'rares.munteanu98@gmail.com', '2026-05-19 16:05:19'),
(99, '6700419000099', 'Neagu Patricia', '1970-04-19', 'Universitare', 'Rural', 'Divorțat/ă', 'Pensionar', 'Strada Lalelelor nr. 99, Iași', '0758113563', 'patricia.neagu99@gmail.com', '2026-05-19 16:05:19'),
(100, '5460520000100', 'Dragomir Stefan', '1946-05-20', 'Gimnaziale', 'Urban', 'Văduv/ă', 'Angajat', 'Strada Aviatorilor nr. 100, Iași', '0723113700', 'stefan.dragomir100@gmail.com', '2026-05-19 16:05:19'),
(101, '6470621000101', 'Popescu Andrei', '1947-06-21', 'Liceale', 'Urban', 'Căsătorit/ă', 'Pensionar', 'Strada Florilor nr. 101, Iași', '0745113837', 'andrei.popescu101@gmail.com', '2026-05-19 16:05:19'),
(102, '5480722000102', 'Ionescu Maria', '1948-07-22', 'Postliceale', 'Rural', 'Divorțat/ă', 'Pensionar', 'Bulevardul Unirii nr. 102, Iași', '0766113974', 'maria.ionescu102@gmail.com', '2026-05-19 16:05:19'),
(103, '6490823000103', 'Georgescu Elena', '1949-08-23', 'Universitare', 'Urban', 'Divorțat/ă', 'Pensionar', 'Strada Libertății nr. 103, Iași', '0731114111', 'elena.georgescu103@gmail.com', '2026-05-19 16:05:19'),
(104, '5500924000104', 'Dumitrescu Mihai', '1950-09-24', 'Gimnaziale', 'Urban', 'Văduv/ă', 'Pensionar', 'Strada Victoriei nr. 104, Iași', '0758114248', 'mihai.dumitrescu104@gmail.com', '2026-05-19 16:05:19'),
(105, '6511025000105', 'Stan Alexandra', '1951-10-25', 'Liceale', 'Rural', 'Căsătorit/ă', 'Pensionar', 'Strada Primăverii nr. 105, Iași', '0723114385', 'alexandra.stan105@gmail.com', '2026-05-19 16:05:19'),
(106, '5521126000106', 'Radu Cristian', '1952-11-26', 'Postliceale', 'Urban', 'Divorțat/ă', 'Pensionar', 'Strada Mihai Viteazu nr. 106, Iași', '0745114522', 'cristian.radu106@gmail.com', '2026-05-19 16:05:19'),
(107, '6531227000107', 'Marin Ioana', '1953-12-27', 'Universitare', 'Urban', 'Divorțat/ă', 'Pensionar', 'Strada Independenței nr. 107,Iași', '0766114659', 'ioana.marin107@gmail.com', '2026-05-19 16:05:19'),
(108, '5540101000108', 'Tudor Gabriel', '1954-01-01', 'Gimnaziale', 'Rural', 'Văduv/ă', 'Pensionar', 'Bulevardul Republicii nr. 108, Iași', '0731114796', 'gabriel.tudor108@gmail.com', '2026-05-19 16:05:19'),
(109, '6550202000109', 'Constantin Bianca', '1955-02-02', 'Liceale', 'Urban', 'Căsătorit/ă', 'Pensionar', 'Strada Lalelelor nr. 109, Iași', '0758114933', 'bianca.constantin109@gmail.com', '2026-05-19 16:05:19'),
(110, '5560303000110', 'Ilie Daniel', '1956-03-03', 'Postliceale', 'Urban', 'Divorțat/ă', 'Angajat', 'Strada Aviatorilor nr. 110, Iași', '0723115070', 'daniel.ilie110@gmail.com', '2026-05-19 16:05:19'),
(111, '6570404000111', 'Voicu Larisa', '1957-04-04', 'Universitare', 'Rural', 'Divorțat/ă', 'Pensionar', 'Strada Florilor nr. 111, Iași', '0745115207', 'larisa.voicu111@gmail.com', '2026-05-19 16:05:19'),
(112, '5580505000112', 'Mihalache Sorin', '1958-05-05', 'Gimnaziale', 'Urban', 'Văduv/ă', 'Pensionar', 'Bulevardul Unirii nr. 112, Iași', '0766115344', 'sorin.mihalache112@gmail.com', '2026-05-19 16:05:19'),
(113, '6590606000113', 'Dobre Ana', '1959-06-06', 'Liceale', 'Urban', 'Căsătorit/ă', 'Pensionar', 'Strada Libertății nr. 113, Iași', '0731115481', 'ana.dobre113@gmail.com', '2026-05-19 16:05:19'),
(114, '5600707000114', 'Nistor Vlad', '1960-07-07', 'Postliceale', 'Rural', 'Divorțat/ă', 'Pensionar', 'Strada Victoriei nr. 114, Iași', '0758115618', 'vlad.nistor114@gmail.com', '2026-05-19 16:05:19'),
(115, '6610808000115', 'Enache Teodora', '1961-08-08', 'Universitare', 'Urban', 'Divorțat/ă', 'Pensionar', 'Strada Primăverii nr. 115, Iași', '0723115755', 'teodora.enache115@gmail.com', '2026-05-19 16:05:19'),
(116, '5620909000116', 'Barbu Florin', '1962-09-09', 'Gimnaziale', 'Urban', 'Văduv/ă', 'Pensionar', 'Strada Mihai Viteazu nr. 116, Iași', '0745115892', 'florin.barbu116@gmail.com', '2026-05-19 16:05:19'),
(117, '6631010000117', 'Preda Camelia', '1963-10-10', 'Liceale', 'Rural', 'Căsătorit/ă', 'Pensionar', 'Strada Independenței nr. 117,Iași', '0766116029', 'camelia.preda117@gmail.com', '2026-05-19 16:05:19'),
(118, '5641111000118', 'Munteanu Rares', '1964-11-11', 'Postliceale', 'Urban', 'Divorțat/ă', 'Pensionar', 'Bulevardul Republicii nr. 118, Iași', '0731116166', 'rares.munteanu118@gmail.com', '2026-05-19 16:05:19'),
(119, '6651212000119', 'Neagu Patricia', '1965-12-12', 'Universitare', 'Urban', 'Divorțat/ă', 'Pensionar', 'Strada Lalelelor nr. 119, Iași', '0758116303', 'patricia.neagu119@gmail.com', '2026-05-19 16:05:19'),
(120, '5660113000120', 'Dragomir Stefan', '1966-01-13', 'Gimnaziale', 'Rural', 'Văduv/ă', 'Angajat', 'Strada Aviatorilor nr. 120, Iași', '0723116440', 'stefan.dragomir120@gmail.com', '2026-05-19 16:05:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `firme`
--
ALTER TABLE `firme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cui` (`cui`);

--
-- Indexes for table `persoane`
--
ALTER TABLE `persoane`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnp` (`cnp`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `firme`
--
ALTER TABLE `firme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `persoane`
--
ALTER TABLE `persoane`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

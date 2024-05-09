-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2024 at 08:44 PM
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
-- Database: `pokemon_project_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `attacks`
--

CREATE TABLE `attacks` (
  `AttackID` int(11) NOT NULL,
  `CardID` int(11) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Damage` int(11) DEFAULT NULL,
  `Cost` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `CardID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `HP` int(11) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `RarityID` int(11) DEFAULT NULL,
  `ExpansionID` int(11) DEFAULT NULL,
  `CardNumber` varchar(50) DEFAULT NULL,
  `Illustrator` varchar(100) DEFAULT NULL,
  `CardFormat` enum('Standard','Expanded','Unlimited','Other') DEFAULT NULL,
  `RegulationMark` char(1) DEFAULT NULL,
  `RetreatCost` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collectioncards`
--

CREATE TABLE `collectioncards` (
  `CollectionID` int(11) NOT NULL,
  `CardID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collections`
--

CREATE TABLE `collections` (
  `CollectionID` int(11) NOT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Public` tinyint(1) DEFAULT 1,
  `CreationDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CommentID` int(11) NOT NULL,
  `CollectionID` int(11) DEFAULT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `Comment` text DEFAULT NULL,
  `CommentDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `energytypes`
--

CREATE TABLE `energytypes` (
  `EnergyTypeID` int(11) NOT NULL,
  `TypeName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expansions`
--

CREATE TABLE `expansions` (
  `ExpansionID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Abbreviation` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `MemberID` int(11) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `MessageID` int(11) NOT NULL,
  `SenderID` int(11) DEFAULT NULL,
  `ReceiverID` int(11) DEFAULT NULL,
  `Message` text DEFAULT NULL,
  `SentDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rarity`
--

CREATE TABLE `rarity` (
  `RarityID` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `RatingID` int(11) NOT NULL,
  `CollectionID` int(11) DEFAULT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `Rating` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resistances`
--

CREATE TABLE `resistances` (
  `ResistanceID` int(11) NOT NULL,
  `CardID` int(11) DEFAULT NULL,
  `TypeName` varchar(50) DEFAULT NULL,
  `Reduction` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weaknesses`
--

CREATE TABLE `weaknesses` (
  `WeaknessID` int(11) NOT NULL,
  `CardID` int(11) DEFAULT NULL,
  `TypeName` varchar(50) DEFAULT NULL,
  `Multiplier` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `MemberID` int(11) NOT NULL,
  `CardID` int(11) NOT NULL,
  `Liked` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attacks`
--
ALTER TABLE `attacks`
  ADD PRIMARY KEY (`AttackID`),
  ADD KEY `CardID` (`CardID`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`CardID`),
  ADD KEY `RarityID` (`RarityID`),
  ADD KEY `ExpansionID` (`ExpansionID`);

--
-- Indexes for table `collectioncards`
--
ALTER TABLE `collectioncards`
  ADD PRIMARY KEY (`CollectionID`,`CardID`),
  ADD KEY `CardID` (`CardID`);

--
-- Indexes for table `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`CollectionID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`CommentID`),
  ADD KEY `CollectionID` (`CollectionID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- Indexes for table `energytypes`
--
ALTER TABLE `energytypes`
  ADD PRIMARY KEY (`EnergyTypeID`);

--
-- Indexes for table `expansions`
--
ALTER TABLE `expansions`
  ADD PRIMARY KEY (`ExpansionID`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`MemberID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`MessageID`),
  ADD KEY `SenderID` (`SenderID`),
  ADD KEY `ReceiverID` (`ReceiverID`);

--
-- Indexes for table `rarity`
--
ALTER TABLE `rarity`
  ADD PRIMARY KEY (`RarityID`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`RatingID`),
  ADD KEY `CollectionID` (`CollectionID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- Indexes for table `resistances`
--
ALTER TABLE `resistances`
  ADD PRIMARY KEY (`ResistanceID`),
  ADD KEY `CardID` (`CardID`);

--
-- Indexes for table `weaknesses`
--
ALTER TABLE `weaknesses`
  ADD PRIMARY KEY (`WeaknessID`),
  ADD KEY `CardID` (`CardID`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`MemberID`,`CardID`),
  ADD KEY `CardID` (`CardID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attacks`
--
ALTER TABLE `attacks`
  MODIFY `AttackID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `CardID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collections`
--
ALTER TABLE `collections`
  MODIFY `CollectionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `CommentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `energytypes`
--
ALTER TABLE `energytypes`
  MODIFY `EnergyTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expansions`
--
ALTER TABLE `expansions`
  MODIFY `ExpansionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `MemberID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `MessageID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rarity`
--
ALTER TABLE `rarity`
  MODIFY `RarityID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `RatingID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resistances`
--
ALTER TABLE `resistances`
  MODIFY `ResistanceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weaknesses`
--
ALTER TABLE `weaknesses`
  MODIFY `WeaknessID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attacks`
--
ALTER TABLE `attacks`
  ADD CONSTRAINT `attacks_ibfk_1` FOREIGN KEY (`CardID`) REFERENCES `cards` (`CardID`);

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_ibfk_1` FOREIGN KEY (`RarityID`) REFERENCES `rarity` (`RarityID`),
  ADD CONSTRAINT `cards_ibfk_2` FOREIGN KEY (`ExpansionID`) REFERENCES `expansions` (`ExpansionID`);

--
-- Constraints for table `collectioncards`
--
ALTER TABLE `collectioncards`
  ADD CONSTRAINT `collectioncards_ibfk_1` FOREIGN KEY (`CollectionID`) REFERENCES `collections` (`CollectionID`),
  ADD CONSTRAINT `collectioncards_ibfk_2` FOREIGN KEY (`CardID`) REFERENCES `cards` (`CardID`);

--
-- Constraints for table `collections`
--
ALTER TABLE `collections`
  ADD CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`CollectionID`) REFERENCES `collections` (`CollectionID`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`SenderID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`ReceiverID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`CollectionID`) REFERENCES `collections` (`CollectionID`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `resistances`
--
ALTER TABLE `resistances`
  ADD CONSTRAINT `resistances_ibfk_1` FOREIGN KEY (`CardID`) REFERENCES `cards` (`CardID`);

--
-- Constraints for table `weaknesses`
--
ALTER TABLE `weaknesses`
  ADD CONSTRAINT `weaknesses_ibfk_1` FOREIGN KEY (`CardID`) REFERENCES `cards` (`CardID`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`CardID`) REFERENCES `cards` (`CardID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

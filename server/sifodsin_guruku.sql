-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 05, 2024 at 08:17 PM
-- Server version: 8.0.37-0ubuntu0.22.04.3
-- PHP Version: 8.1.2-1ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sifodsin_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int NOT NULL,
  `id_siswa` int NOT NULL,
  `id_guru` int NOT NULL,
  `nama_siswa` varchar(64) NOT NULL,
  `nama_guru` varchar(64) NOT NULL,
  `mata_pelajaran` varchar(20) NOT NULL,
  `tarif` int NOT NULL,
  `tanggal` varchar(256) NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `id_siswa`, `id_guru`, `nama_siswa`, `nama_guru`, `mata_pelajaran`, `tarif`, `tanggal`, `status`) VALUES
(8, 4, 6, 'Novan', 'Guru gembul', 'Ilmu Komputer', 175000, '2024-08-05 18:25', 'Sedang berjalan');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` int NOT NULL,
  `id_guru` int NOT NULL,
  `tanggal` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `id_guru`, `tanggal`) VALUES
(2, 6, '2024-08-04 03:10'),
(5, 6, '2024-08-05 18:25');

-- --------------------------------------------------------

--
-- Table structure for table `mata_pelajaran`
--

CREATE TABLE `mata_pelajaran` (
  `id` int NOT NULL,
  `deskripsi` varchar(45) NOT NULL,
  `tarif` int NOT NULL,
  `icon` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mata_pelajaran`
--

INSERT INTO `mata_pelajaran` (`id`, `deskripsi`, `tarif`, `icon`) VALUES
(7, 'Ilmu Komputer', 175000, 'http://sifodsinterflour.my.id/api/uploads/Ilmu Komputer.png');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `notification_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `mata_pelajaran` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Belum disetel',
  `nama` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` text NOT NULL,
  `password` varchar(64) NOT NULL,
  `nohp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Belum disetel',
  `kualifikasi` int DEFAULT NULL,
  `alamat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Belum disetel',
  `foto_profil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `mata_pelajaran`, `nama`, `email`, `role`, `password`, `nohp`, `kualifikasi`, `alamat`, `foto_profil`) VALUES
(4, 'Matematika', 'Novan', 'novan@gmail.com', 'Siswa', '$2b$10$PiM9kdGE2ocqVu.1Z6KLxumGZL0t36el3OeCeIoNpEH3MR5hP2AG.', '0857123213', NULL, 'Bengkong sadai', 'http://sifodsinterflour.my.id/api/uploads/novan@gmail.com.png'),
(5, 'Belum disetel', 'Admin', 'admin', 'Admin', '$2b$10$SAvjmp9DzNtIdDQxcXiVyuDrP7FMHYV2N0VrzXWD/Jtp/HA9hF.kW', 'Belum disetel', NULL, 'Belum disetel', 'default'),
(6, 'Ilmu Komputer', 'Guru gembul', 'gembul@gmail.com', 'Guru', '$2b$10$N5ft8aSPz3Pb/MHnYXlB9OYeADHpsRKcTC3A7tHGg4VO9wC4/2sfe', '086732133', NULL, 'Bengkong', 'http://sifodsinterflour.my.id/api/uploads/gembul@gmail.com.png'),
(7, 'Ilmu Komputer', 'Saprul', 'novan2@gmail.com', 'Siswa', '$2b$10$3LUSYavKlvkmUUkd4N9x9edaUEN7gwV0PGdejFFmv4CSNqo4Ywh8S', 'Belum disetel', NULL, 'Belum disetel', 'http://sifodsinterflour.my.id/api/uploads/novan2@gmail.com.png'),
(8, 'Belum disetel', 'Guru metal', 'guru666@gmail.com', 'Guru', '$2b$10$ajUIeSoUrJER3svD/QvItupS00gk7eQg1SXnSdMBMedIYMSQEqzDa', 'Belum disetel', NULL, 'Belum disetel', 'default');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

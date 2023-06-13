-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2023 at 06:22 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `invoice`
--

-- --------------------------------------------------------

--
-- Table structure for table `counters`
--

CREATE TABLE `counters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `prefix` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `counters`
--

INSERT INTO `counters` (`id`, `key`, `prefix`, `value`, `created_at`, `updated_at`) VALUES
(1, 'invoice', 'INV-', '20000', '2023-06-12 07:35:22', '2023-06-12 07:35:22');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `firstname`, `lastname`, `email`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Jamal Harvey', 'Ms. Lavonne Goyette V', 'josie83@yahoo.com', '25315 Keanu Isle\nStrosinfurt, CA 51690', '2023-06-12 07:37:21', '2023-06-12 07:37:21'),
(2, 'Paul Okuneva', 'Christiana Parisian I', 'candida.spinka@hotmail.com', '17918 Powlowski Glens Apt. 958\nEast Garett, NV 75068', '2023-06-12 07:37:21', '2023-06-12 07:37:21'),
(3, 'Prof. Earline Batz', 'Miss Florence Gleichner PhD', 'mohamed.robel@yahoo.com', '8990 Stroman Plaza\nSouth Aracelyland, PA 02755-1515', '2023-06-12 07:37:21', '2023-06-12 07:37:21'),
(4, 'Dr. Isabell Berge PhD', 'Darius Wuckert', 'devon85@mohr.com', '288 Simonis Station Suite 685\nWest Danika, NE 82059-9382', '2023-06-12 07:37:21', '2023-06-12 07:37:21'),
(5, 'Macie Simonis', 'Mr. Thad Ebert PhD', 'golda28@hotmail.com', '9320 Tromp Knolls Apt. 119\nDickinsonchester, ID 44543', '2023-06-12 07:37:21', '2023-06-12 07:37:21');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `number` varchar(255) NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `term_and_conditions` text NOT NULL,
  `sub_total` double NOT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `number`, `customer_id`, `date`, `due_date`, `reference`, `term_and_conditions`, `sub_total`, `discount`, `total`, `created_at`, `updated_at`) VALUES
(1, '279', 10, '1985-09-18', '1989-06-24', 'REF-24', 'Modi laborum veniam minima natus delectus maxime. Veniam est quis placeat molestiae et.', 814, 100, 1706, '2023-06-12 07:37:36', '2023-06-12 07:37:36'),
(2, '405', 1, '1974-10-07', '1980-02-19', 'REF-349', 'Voluptatum itaque deleniti ad unde. Quasi possimus recusandae sint eum nemo eius ut.', 930, 100, 1957, '2023-06-12 07:37:36', '2023-06-12 07:37:36'),
(3, '839', 7, '2014-06-12', '1989-12-30', 'REF-41', 'Vel repellendus harum et cupiditate numquam vel. Illo sit dolore veritatis et est culpa beatae.', 369, 100, 755, '2023-06-12 07:37:36', '2023-06-12 07:37:36'),
(4, '715', 11, '1999-06-21', '1979-04-11', 'REF-228', 'Omnis minima quis molestias et sunt. Quod labore dolorem dolor voluptate quia ratione iusto.', 430, 100, 1038, '2023-06-12 07:37:36', '2023-06-12 07:37:36'),
(5, '815', 8, '1975-08-10', '1994-09-18', 'REF-490', 'Aut dolorem tempore ut placeat et repellendus. Et rem voluptas quia debitis vero harum. Nihil quia delectus possimus qui et.', 111, 100, 1481, '2023-06-12 07:37:36', '2023-06-12 07:37:36'),
(6, 'INV-20006', 4, '2023-06-13', '2023-06-14', 'sdasdasd', 'asdasdasd', 2515, 5, 5020, '2023-06-13 08:09:18', '2023-06-13 08:09:18'),
(7, 'INV-20007', 2, '2023-06-13', '2023-06-14', 'asdasdasdas', 'asdasdsada', 3238, 8, 6460, '2023-06-13 08:10:36', '2023-06-13 08:10:36');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit_price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_id`, `unit_price`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 437, 100, 4121, 3, '2023-06-12 07:36:42', '2023-06-12 07:36:42'),
(2, 932, 100, 4034, 4, '2023-06-12 07:36:42', '2023-06-12 07:36:42'),
(3, 926, 100, 3792, 5, '2023-06-12 07:36:42', '2023-06-12 07:36:42'),
(4, 364, 100, 3335, 5, '2023-06-12 07:36:42', '2023-06-12 07:36:42'),
(5, 105, 100, 3208, 5, '2023-06-12 07:36:42', '2023-06-12 07:36:42'),
(6, 20, 20, 377, 4, '2023-06-13 08:10:36', '2023-06-13 08:10:36'),
(7, 16, 16, 346, 5, '2023-06-13 08:10:36', '2023-06-13 08:10:36');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_06_12_111157_create_counters_table', 1),
(6, '2023_06_12_111945_create_products_table', 1),
(7, '2023_06_12_112545_create_customers_table', 1),
(8, '2023_06_12_113037_create_invoices_table', 1),
(9, '2023_06_12_113907_create_invoice_items_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `unit_price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `item_code`, `description`, `unit_price`, `created_at`, `updated_at`) VALUES
(1, 'IC-100082', 'Name of Product253', 932, '2023-06-12 07:35:32', '2023-06-12 07:35:32'),
(2, 'IC-1000436', 'Name of Product313', 477, '2023-06-12 07:35:32', '2023-06-12 07:35:32'),
(3, 'IC-1000467', 'Name of Product171', 847, '2023-06-12 07:35:32', '2023-06-12 07:35:32'),
(4, 'IC-100058', 'Name of Product319', 952, '2023-06-12 07:35:32', '2023-06-12 07:35:32'),
(5, 'IC-100024', 'Name of Product395', 782, '2023-06-12 07:35:32', '2023-06-12 07:35:32'),
(6, 'IC-1000481', 'Name of Product362', 692, '2023-06-12 07:35:38', '2023-06-12 07:35:38'),
(7, 'IC-1000130', 'Name of Product193', 502, '2023-06-12 07:35:38', '2023-06-12 07:35:38'),
(8, 'IC-1000277', 'Name of Product229', 787, '2023-06-12 07:35:38', '2023-06-12 07:35:38'),
(9, 'IC-1000109', 'Name of Product81', 177, '2023-06-12 07:35:38', '2023-06-12 07:35:38'),
(10, 'IC-1000105', 'Name of Product203', 992, '2023-06-12 07:35:38', '2023-06-12 07:35:38'),
(11, 'IC-1000291', 'Name of Product329', 197, '2023-06-12 07:35:45', '2023-06-12 07:35:45'),
(12, 'IC-1000143', 'Name of Product354', 159, '2023-06-12 07:35:45', '2023-06-12 07:35:45'),
(13, 'IC-1000444', 'Name of Product73', 323, '2023-06-12 07:35:45', '2023-06-12 07:35:45'),
(14, 'IC-1000370', 'Name of Product411', 707, '2023-06-12 07:35:45', '2023-06-12 07:35:45'),
(15, 'IC-100099', 'Name of Product405', 330, '2023-06-12 07:35:45', '2023-06-12 07:35:45'),
(16, 'IC-1000172', 'Name of Product406', 346, '2023-06-12 07:35:51', '2023-06-12 07:35:51'),
(17, 'IC-1000131', 'Name of Product99', 731, '2023-06-12 07:35:51', '2023-06-12 07:35:51'),
(18, 'IC-1000231', 'Name of Product156', 575, '2023-06-12 07:35:51', '2023-06-12 07:35:51'),
(19, 'IC-1000117', 'Name of Product36', 967, '2023-06-12 07:35:51', '2023-06-12 07:35:51'),
(20, 'IC-100052', 'Name of Product178', 377, '2023-06-12 07:35:51', '2023-06-12 07:35:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `counters`
--
ALTER TABLE `counters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `counters_key_unique` (`key`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoices_numer_unique` (`number`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_item_code_unique` (`item_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `counters`
--
ALTER TABLE `counters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

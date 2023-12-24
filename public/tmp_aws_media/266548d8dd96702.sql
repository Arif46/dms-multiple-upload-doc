-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table file_management.activity_logs
CREATE TABLE IF NOT EXISTS `activity_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `folder_id` int DEFAULT NULL,
  `activity` text COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table file_management.activity_logs: ~0 rows (approximately)

-- Dumping structure for table file_management.aws_media
CREATE TABLE IF NOT EXISTS `aws_media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` int unsigned DEFAULT NULL,
  `document_type` enum('not_specified','enrollment_application','application_form','passport','education','work_history','test_score','additional_doc','transcript','certificate','visa_refusal','payment_receipt','conditional_offer','unconditional_offer','visa_letter','enrollment_rejection','enrollment_condition','previous_study','others','study_gap','prev_study_abroad','work_experience','reference','passport_details','visa_history') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_id` int unsigned DEFAULT NULL,
  `lead_id` int unsigned DEFAULT NULL,
  `enrollment_id` int unsigned DEFAULT NULL,
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` double(24,2) DEFAULT NULL COMMENT 'Size Unit Is Bytes',
  `creator_type` enum('admin','agent','sub_agent','applyuser','student','franchise') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table file_management.aws_media: ~10 rows (approximately)
INSERT INTO `aws_media` (`id`, `model`, `model_id`, `document_type`, `company_id`, `lead_id`, `enrollment_id`, `original_name`, `folder_path`, `file`, `extension`, `type`, `size`, `creator_type`, `creator_id`, `created_at`, `updated_at`) VALUES
	(8, 'App\\Models\\Folder', 12, NULL, NULL, NULL, NULL, 'in folder 12 -file 01', 'aws_media', '86524fa453254b.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:16:21', '2023-10-10 01:16:21'),
	(9, 'App\\Models\\Folder', 12, NULL, NULL, NULL, NULL, 'in folder 12 -file 02', 'aws_media', '96524fe3007030.png', 'png', 'image/png', 490851.00, NULL, NULL, '2023-10-10 01:33:04', '2023-10-10 01:33:04'),
	(10, 'App\\Models\\Folder', 12, NULL, NULL, NULL, NULL, 'in 12 file 03', 'aws_media', '106524fe9448e65.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:34:44', '2023-10-10 01:34:44'),
	(11, 'App\\Models\\Folder', 16, NULL, NULL, NULL, NULL, 'foinn 01', 'aws_media', '116524fef6e29aa.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:36:22', '2023-10-10 01:36:23'),
	(12, 'App\\Models\\Folder', 16, NULL, NULL, NULL, NULL, 'sdfsdf', 'aws_media', '12652500f36b694.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:44:51', '2023-10-10 01:44:52'),
	(13, 'App\\Models\\Folder', 16, NULL, NULL, NULL, NULL, 'sdfsdf', 'aws_media', '13652500f67036e.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:44:54', '2023-10-10 01:44:54'),
	(14, 'App\\Models\\Folder', 16, NULL, NULL, NULL, NULL, 'sdfds', 'aws_media', '1465250145a3cee.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 01:46:13', '2023-10-10 01:46:14'),
	(15, 'App\\Models\\Folder', 12, NULL, NULL, NULL, NULL, '011', 'aws_media', '15652510e1ac368.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 02:52:49', '2023-10-10 02:52:50'),
	(16, 'App\\Models\\Folder', 30, NULL, NULL, NULL, NULL, 'test file 001-002', 'aws_media', '1665251e7463310.png', 'png', 'image/png', 579013.00, NULL, NULL, '2023-10-10 03:50:44', '2023-10-10 03:50:44'),
	(17, 'App\\Models\\Folder', 35, NULL, NULL, NULL, NULL, 'textt', 'aws_media', '176525230728256.xlsx', 'xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 53078.00, NULL, NULL, '2023-10-10 04:10:15', '2023-10-10 04:10:15');

-- Dumping structure for table file_management.folders
CREATE TABLE IF NOT EXISTS `folders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `level_id` int NOT NULL DEFAULT '0',
  `url` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` int DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table file_management.folders: ~26 rows (approximately)
INSERT INTO `folders` (`id`, `name`, `parent_id`, `level_id`, `url`, `status`, `created_at`, `created_by`, `deleted_at`) VALUES
	(12, 'Folder One', 0, 0, NULL, 1, '2023-10-08 06:06:24', 5, NULL),
	(13, 'Folder Two', 0, 0, NULL, 1, '2023-10-08 07:01:51', 5, NULL),
	(14, 'Folder THree', 0, 0, NULL, 1, '2023-10-08 07:42:35', 5, NULL),
	(15, 'folder three', 0, 0, NULL, 1, '2023-10-08 08:35:39', 5, NULL),
	(16, 'File one -folder one', 12, 0, NULL, 1, NULL, NULL, NULL),
	(17, 'folder one -one', 12, 0, NULL, 1, NULL, NULL, NULL),
	(18, 'folder two-one', 12, 0, NULL, 1, NULL, NULL, NULL),
	(19, 'file 2-1-1', 17, 0, NULL, 1, NULL, NULL, NULL),
	(20, 'folder 2-1-1', 17, 0, NULL, 1, NULL, NULL, NULL),
	(21, 'folder there - one', 12, 0, NULL, 1, '2023-10-08 09:32:24', 5, NULL),
	(22, 'folder 3-1-1', 17, 0, NULL, 1, '2023-10-08 09:33:28', 5, NULL),
	(23, 'folder 4-1-1', 17, 0, NULL, 1, '2023-10-08 09:33:42', 5, NULL),
	(24, 'test 001', 20, 0, NULL, 1, '2023-10-08 13:17:28', 5, NULL),
	(25, 'test 002', 20, 0, NULL, 1, '2023-10-09 06:24:54', 5, NULL),
	(26, 'folder 5-1-1', 12, 0, NULL, 1, '2023-10-09 09:17:29', 5, NULL),
	(27, 'test 003', 12, 0, NULL, 1, '2023-10-09 09:24:19', 5, NULL),
	(28, 'folder 5-1-1', 17, 0, NULL, 1, '2023-10-09 09:44:54', 5, NULL),
	(29, 'test 003', 20, 0, NULL, 1, '2023-10-09 09:45:10', 5, NULL),
	(30, 'ttess pp 01', 24, 0, NULL, 1, '2023-10-09 09:45:24', 5, NULL),
	(31, 'tesss 02', 24, 0, NULL, 1, '2023-10-09 09:45:40', 5, NULL),
	(32, 'folder 001', 18, 0, NULL, 1, '2023-10-09 13:37:11', 5, NULL),
	(33, 'fionn01', 16, 0, NULL, 1, '2023-10-10 07:36:06', 5, NULL),
	(34, 'folder two 2', 13, 0, NULL, 1, '2023-10-10 09:48:47', 5, NULL),
	(35, 'tess 00154', 30, 0, NULL, 1, '2023-10-10 10:09:52', 5, NULL),
	(36, 'Kala Manush', 0, 0, NULL, 1, '2023-10-10 10:16:54', 5, NULL),
	(37, 'Valo Manush', 36, 0, NULL, 1, '2023-10-10 10:17:21', 5, NULL);

-- Dumping structure for table file_management.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`) USING BTREE,
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table file_management.personal_access_tokens: ~62 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 5, 'token-name', '3dc70f64eb1a121a606a72a3d8847134c470bb2801a1e4738cc0ed919937a830', '["*"]', NULL, '2023-10-02 07:22:11', '2023-10-02 07:22:11'),
	(2, 'App\\Models\\User', 5, 'token-name', '80da5ee859b2a5f68efe331636bcaf1c0a83dc9d71f2ce9fd5b5743061c3cc26', '["*"]', NULL, '2023-10-02 07:27:42', '2023-10-02 07:27:42'),
	(3, 'App\\Models\\User', 5, 'token-name', '95580a7f550240e95cc9050616db0b27e10060adb41491d4e091b41682ed7eea', '["*"]', NULL, '2023-10-02 07:27:45', '2023-10-02 07:27:45'),
	(4, 'App\\Models\\User', 5, 'token-name', '48709d1cfca6ddc8472157f8dfbcb24a58e0a98264678f964792ec0127040bd7', '["*"]', NULL, '2023-10-02 07:27:50', '2023-10-02 07:27:50'),
	(5, 'App\\Models\\User', 5, 'token-name', '32a53648d60f22889e2fca88ed4946d294c05dc10dd95375c7e91c543ce2150d', '["*"]', NULL, '2023-10-03 04:33:24', '2023-10-03 04:33:24'),
	(6, 'App\\Models\\User', 5, 'token-name', '87f6ad0e4e31de666893988677bd41a43952dc4c60ee604aa536b327f78f0c19', '["*"]', NULL, '2023-10-03 04:36:32', '2023-10-03 04:36:32'),
	(7, 'App\\Models\\User', 5, 'token-name', '7ee1c511ba435d67212b4aedbacb62d93b169904e73daae1cb887e91837b9259', '["*"]', NULL, '2023-10-03 04:41:54', '2023-10-03 04:41:54'),
	(8, 'App\\Models\\User', 5, 'token-name', 'bea558d4c5aa20c24dc4c1095eb3df438f6488392dc3e786a7e278cb74aeb627', '["*"]', NULL, '2023-10-03 04:42:38', '2023-10-03 04:42:38'),
	(9, 'App\\Models\\User', 5, 'token-name', '6477688e093cf613a542a6db35b403aa2d4c4c069889cfb2a7e963ce300434a6', '["*"]', NULL, '2023-10-03 04:43:33', '2023-10-03 04:43:33'),
	(10, 'App\\Models\\User', 5, 'token-name', '7791ddbdd309ab89d3a7d93f05133c56b6351469e681de3ac03f0643894c2cab', '["*"]', NULL, '2023-10-03 04:46:36', '2023-10-03 04:46:36'),
	(11, 'App\\Models\\User', 5, 'token-name', '8af388ec36d84f4c290e4c6fcdac2513265f34355941b98f892b916953b5a1c1', '["*"]', NULL, '2023-10-03 04:49:33', '2023-10-03 04:49:33'),
	(12, 'App\\Models\\User', 5, 'token-name', 'b98281c062f4a0f9580ddc7c4a21ee9decbccd92fd136076ad2c41296ee3c244', '["*"]', NULL, '2023-10-03 04:51:35', '2023-10-03 04:51:35'),
	(13, 'App\\Models\\User', 5, 'token-name', 'd80936e64363a17513149f5505119cbb031e95b037697ae143356e40e5732f26', '["*"]', NULL, '2023-10-03 04:51:44', '2023-10-03 04:51:44'),
	(14, 'App\\Models\\User', 5, 'token-name', '2b99141537b2cb94613f96c9ff13ef65503e3f57c62d69bdba9a2427baf6296f', '["*"]', NULL, '2023-10-03 05:14:09', '2023-10-03 05:14:09'),
	(15, 'App\\Models\\User', 5, 'token-name', '702f9a21bb5d61d6e639c1e940e7e56698ee40f111200454ea20d70983310b2c', '["*"]', NULL, '2023-10-03 05:23:05', '2023-10-03 05:23:05'),
	(16, 'App\\Models\\User', 5, 'token-name', '024ce398257546b7eb5ac15aa999c0d8cb78181ff9df47c6ff05090640d8479d', '["*"]', NULL, '2023-10-03 05:23:29', '2023-10-03 05:23:29'),
	(17, 'App\\Models\\User', 5, 'token-name', 'ec6c5cfe9dcaab1b603f9166b260f5ad63273d63470f941281e3c0228853fbca', '["*"]', NULL, '2023-10-03 05:58:50', '2023-10-03 05:58:50'),
	(18, 'App\\Models\\User', 5, 'token-name', 'c9b50990b0e8b0b892427f6c0cd844c5d6ddaac528dd7c9e597311e3229cc035', '["*"]', NULL, '2023-10-03 06:31:53', '2023-10-03 06:31:53'),
	(19, 'App\\Models\\User', 5, 'token-name', '12256bf790cd2f20d7b1a8bd9d0f5bc1a92ccced5956aa1016f18eace110f9e2', '["*"]', NULL, '2023-10-03 06:32:32', '2023-10-03 06:32:32'),
	(20, 'App\\Models\\User', 5, 'token-name', 'bea57c607c70fdbfc362d63bf125c9cacaba95e5aa1d868e5a9d5797ee8d43a7', '["*"]', NULL, '2023-10-03 06:33:01', '2023-10-03 06:33:01'),
	(21, 'App\\Models\\User', 5, 'token-name', '6142b2740e894459c66a0e06849c1adea3c4a0640a5c8ac59c7095ac6eb708a6', '["*"]', NULL, '2023-10-03 06:34:59', '2023-10-03 06:34:59'),
	(22, 'App\\Models\\User', 5, 'token-name', '8629669bddec2c0f7b71179704f59cd7acfbe560636922fdb2755133e5e06c6b', '["*"]', NULL, '2023-10-03 06:35:18', '2023-10-03 06:35:18'),
	(23, 'App\\Models\\User', 5, 'token-name', '151fc1ed8745cf06abf7dfb9bebdf09f6aa8a4e4ad375203356907b9a541a907', '["*"]', NULL, '2023-10-03 06:38:01', '2023-10-03 06:38:01'),
	(24, 'App\\Models\\User', 5, 'token-name', '9b712a50e15f724e2e28879093ca5c23a07a1c72f2b61b623b58927baab8b1e9', '["*"]', NULL, '2023-10-03 06:42:21', '2023-10-03 06:42:21'),
	(25, 'App\\Models\\User', 5, 'token-name', '964b87ac3a727272f94e013c629cd7a840065ce4c87e542d5b8813be8d82ee36', '["*"]', NULL, '2023-10-03 06:44:43', '2023-10-03 06:44:43'),
	(26, 'App\\Models\\User', 5, 'token-name', 'd79802997d3bafc6f81e065f67a6ea023ba04749e7a8378eea9ce72e27b5132c', '["*"]', NULL, '2023-10-03 06:50:55', '2023-10-03 06:50:55'),
	(27, 'App\\Models\\User', 5, 'token-name', 'a56f9f2c9bfd19c8845ae82ae971b964ce6fa6134214b6333c6f37d3da0823b2', '["*"]', NULL, '2023-10-03 06:55:31', '2023-10-03 06:55:31'),
	(28, 'App\\Models\\User', 5, 'token-name', '17db9e5c422d6abeb291a6451b852c35151361f1c99e1be651be05c37512ce27', '["*"]', NULL, '2023-10-03 06:56:20', '2023-10-03 06:56:20'),
	(29, 'App\\Models\\User', 5, 'token-name', 'cee7751d1782971f1449abf584d9a1546b535923413c05b147cd1c8451aa43ba', '["*"]', NULL, '2023-10-03 07:13:14', '2023-10-03 07:13:14'),
	(30, 'App\\Models\\User', 5, 'token-name', '2e421ebecbf6ebf29d5f5d77bb1f9931e623cdb87925b00dd0f25559574bfc87', '["*"]', NULL, '2023-10-03 07:16:14', '2023-10-03 07:16:14'),
	(31, 'App\\Models\\User', 5, 'token-name', '1a876dfd02f054f35d4491b9ce2ff114fb6b94a6775e6dfbf6533d59328b9daa', '["*"]', NULL, '2023-10-03 07:18:47', '2023-10-03 07:18:47'),
	(32, 'App\\Models\\User', 5, 'token-name', '7a1532fbad3af1e7bfdadb710f87149ae29ed432a83569d0d538422e3da83a06', '["*"]', NULL, '2023-10-03 07:19:28', '2023-10-03 07:19:28'),
	(33, 'App\\Models\\User', 5, 'token-name', 'c3f3e2181e05447ac01a3ba0e76f8debc044f72dcc3f810a454ea992ac793c04', '["*"]', NULL, '2023-10-03 07:19:43', '2023-10-03 07:19:43'),
	(34, 'App\\Models\\User', 5, 'token-name', '68532cec3439eccf45b54b969e7e8b1f677264b0089882dc3c55dabc98844bd8', '["*"]', NULL, '2023-10-03 23:27:17', '2023-10-03 23:27:17'),
	(35, 'App\\Models\\User', 5, 'token-name', 'e499dba056e2fdf3f87dca4ad552e9cdde07b3b216881bc5151dbf3110e8c263', '["*"]', '2023-10-04 05:14:04', '2023-10-04 02:44:10', '2023-10-04 05:14:04'),
	(36, 'App\\Models\\User', 5, 'token-name', '94a0a51bc9eff0e2cbd2941fd19783f9c3009e27046ffa008ea3b49f92b2ed66', '["*"]', NULL, '2023-10-04 02:44:10', '2023-10-04 02:44:10'),
	(37, 'App\\Models\\User', 5, 'token-name', '2ea8a0db8d4c5aea55a4865b5c9e0fbad00a49fa2d6712e598258f1a72010159', '["*"]', NULL, '2023-10-04 03:52:02', '2023-10-04 03:52:02'),
	(38, 'App\\Models\\User', 5, 'token-name', '5d007dfd55a36ec2b1e2bc991fc0ae3311acf9004b9c54dc96cf12fb947b0126', '["*"]', '2023-10-05 06:14:01', '2023-10-04 04:33:02', '2023-10-05 06:14:01'),
	(39, 'App\\Models\\User', 5, 'token-name', '74bcbd1714265fee72660ce1210ec2e8345a074c65824c7caf529c84898d77bd', '["*"]', '2023-10-04 07:02:05', '2023-10-04 05:14:35', '2023-10-04 07:02:05'),
	(40, 'App\\Models\\User', 5, 'token-name', '05181042620d56aaa96cbdf9b6295e4e12b8e01d75de86996291d5cab5316572', '["*"]', '2023-10-04 07:05:26', '2023-10-04 07:02:23', '2023-10-04 07:05:26'),
	(41, 'App\\Models\\User', 5, 'token-name', '53a28eb9baecb939749cb03135c162a9adb68ba83b6ac825f682f44cf4816dbd', '["*"]', '2023-10-05 07:44:01', '2023-10-05 04:31:55', '2023-10-05 07:44:01'),
	(42, 'App\\Models\\User', 5, 'token-name', '343e2a5db98e785ca904235cc337a5bd7a05703e209ece893638a605b41b560f', '["*"]', NULL, '2023-10-05 04:31:55', '2023-10-05 04:31:55'),
	(43, 'App\\Models\\User', 5, 'token-name', '178e0e9a4c555f8ab3099705c76a0d6967bbc8dc0f4a780e24797bee1729e2ba', '["*"]', '2023-10-05 07:34:47', '2023-10-05 05:03:09', '2023-10-05 07:34:47'),
	(44, 'App\\Models\\User', 5, 'token-name', 'fb7750459c6895728bd795ae592acf7616c202b86e15b5afbc948998f156dd80', '["*"]', '2023-10-05 07:36:19', '2023-10-05 06:11:35', '2023-10-05 07:36:19'),
	(45, 'App\\Models\\User', 5, 'token-name', '5a7dfb4224a4868e940ce8fe04b3fbc8cc4212facb90c42e475dd8f60496d385', '["*"]', '2023-10-05 07:58:42', '2023-10-05 07:49:59', '2023-10-05 07:58:42'),
	(46, 'App\\Models\\User', 5, 'token-name', 'ac9699193bfae14b3ad7597262c0ef3600dc82300c1c0114bbcd24dea9818f2f', '["*"]', '2023-10-06 06:47:54', '2023-10-05 23:37:25', '2023-10-06 06:47:54'),
	(47, 'App\\Models\\User', 5, 'token-name', 'bfb915512e6acfb26d5c010b19999a6f9385e851548f1442387441faa59fe1cf', '["*"]', '2023-10-06 06:27:55', '2023-10-06 04:10:48', '2023-10-06 06:27:55'),
	(48, 'App\\Models\\User', 5, 'token-name', '25a1b54d70e92db97b30a2a809531a96eea2a9e69a27ace2c069649c20544989', '["*"]', NULL, '2023-10-06 07:02:08', '2023-10-06 07:02:08'),
	(49, 'App\\Models\\User', 5, 'token-name', 'd5b2184b4ac91ce5929fd5e912239bca23b1e880005b66b56bb49e96ae9df2f3', '["*"]', NULL, '2023-10-06 07:24:50', '2023-10-06 07:24:50'),
	(50, 'App\\Models\\User', 5, 'token-name', '609f37ea1a9e02cf7bed3207e3788b0b1809202b53aaf6d966ec863a28c48af1', '["*"]', NULL, '2023-10-06 07:25:34', '2023-10-06 07:25:34'),
	(51, 'App\\Models\\User', 5, 'token-name', 'fad153a3ab4f3984f3642667e9a7d63521ec7877c7e6085002cc7e0ea3b70980', '["*"]', NULL, '2023-10-06 07:26:25', '2023-10-06 07:26:25'),
	(52, 'App\\Models\\User', 5, 'token-name', 'd6b32f7a11d69711fb1ec59c2dcf9dc3ad6ec429df7a5d6929231968c955c9d4', '["*"]', '2023-10-08 02:42:19', '2023-10-06 07:29:01', '2023-10-08 02:42:19'),
	(53, 'App\\Models\\User', 5, 'token-name', 'fb4614ce3e81cb8e44016ff49b1e84e6a08ecf3b1a63035f8de4642e3d4aa924', '["*"]', NULL, '2023-10-08 00:10:15', '2023-10-08 00:10:15'),
	(54, 'App\\Models\\User', 5, 'token-name', '60755739004716bfad6c1c0749fce1a3555489244eada56c09347f8c3723d77c', '["*"]', NULL, '2023-10-08 00:37:11', '2023-10-08 00:37:11'),
	(55, 'App\\Models\\User', 5, 'token-name', '686cf73bf3868508a218eadcc2e6fd076cf012e86c2dd2394fdb9672613cb945', '["*"]', NULL, '2023-10-08 00:43:02', '2023-10-08 00:43:02'),
	(56, 'App\\Models\\User', 5, 'token-name', 'b35f3e3fbcb4883db23b5e07b30efd956c66251cd50dca246855f35cae59ae2e', '["*"]', '2023-10-08 03:11:06', '2023-10-08 02:49:32', '2023-10-08 03:11:06'),
	(57, 'App\\Models\\User', 5, 'token-name', '1873938b81be55cfeb05b685d9b24e915bd30cc304f051505bdcad7f9a13c1f9', '["*"]', '2023-10-09 02:30:28', '2023-10-08 03:11:24', '2023-10-09 02:30:28'),
	(58, 'App\\Models\\User', 5, 'token-name', '111b6a7d5090af5352540e044eea6741af2cb91b02f3df3286b407c5d88e3a0d', '["*"]', '2023-10-09 02:31:01', '2023-10-09 02:30:38', '2023-10-09 02:31:01'),
	(59, 'App\\Models\\User', 5, 'token-name', 'd8e93f388b0b758a906754186f5998c05764f747ee4204b1198e29b9fe295cd7', '["*"]', '2023-10-09 02:31:19', '2023-10-09 02:31:15', '2023-10-09 02:31:19'),
	(60, 'App\\Models\\User', 5, 'token-name', 'cf0aa005c135cb2910f8fe2d5e61350e368f152191ece06261e71f9c9a8a1f79', '["*"]', '2023-10-10 07:21:09', '2023-10-09 02:31:31', '2023-10-10 07:21:09'),
	(61, 'App\\Models\\User', 5, 'token-name', '6bb45abe71052b0fcdc129d52481afb64e059d552f93b9cd5f9dc66235f0b5ea', '["*"]', '2023-10-09 05:43:05', '2023-10-09 05:02:18', '2023-10-09 05:43:05'),
	(62, 'App\\Models\\User', 5, 'token-name', 'ad1dc92918e28f52a94c1bf3434fd6215a50e1ea991dd0b09a5f246c64835eb4', '["*"]', '2023-10-10 02:34:09', '2023-10-09 23:18:51', '2023-10-10 02:34:09');

-- Dumping structure for table file_management.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table file_management.users: ~4 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `google_id`, `facebook_id`, `image_url`, `remember_token`, `active_status`, `status`, `created_at`, `updated_at`) VALUES
	(5, 'Sakib', 'sakib@gmail.com', '789654', '$2y$10$JUSMFE9rDrItv28Lsub4UuFTiR4PJr1Bg89ML0jkJEz4TTSPYzNEa', NULL, NULL, NULL, NULL, 0, 1, '2023-08-29 06:38:07', '2023-10-06 04:05:05'),
	(20, 'Arif', 'arif@gmail.com', '25411', '$2y$10$0HsmLO8EuHfxQLS8CGnfyOGNGU3pcNaDver0C7XyHLsNZJfc0Aply', NULL, NULL, NULL, NULL, 0, 1, '2023-10-06 00:55:09', '2023-10-06 00:55:09'),
	(23, 'Ashraf', 'ashraf@gmail.com', '123456', '$2y$10$6SMlvUt8b0Nlnryy0bjZ/OFRbwdAa5Uez/WDdEwi.7wydkfqYPtOm', NULL, NULL, NULL, NULL, 0, 1, '2023-10-06 04:58:19', '2023-10-06 04:58:19'),
	(24, 'Mostafiz', 'mostafiz2@gmail.com', '123456', '$2y$10$H.fLFtSp3wgffzEcuaYKPO/tUOUpamOkuOyhKloJ.KQnWt7z4IegK', NULL, NULL, NULL, NULL, 0, 1, '2023-10-06 04:58:37', '2023-10-06 04:58:46');

-- Dumping structure for table file_management.user_folder_relationships
CREATE TABLE IF NOT EXISTS `user_folder_relationships` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `folder_id` int DEFAULT NULL,
  `level_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table file_management.user_folder_relationships: ~26 rows (approximately)
INSERT INTO `user_folder_relationships` (`id`, `user_id`, `folder_id`, `level_id`) VALUES
	(1, 5, 12, 0),
	(2, 5, 13, 0),
	(3, 5, 14, 0),
	(4, 5, 15, 0),
	(5, 5, 16, NULL),
	(6, 5, 17, NULL),
	(7, 5, 18, NULL),
	(8, 5, 19, NULL),
	(9, 5, 20, NULL),
	(10, 5, 21, 0),
	(11, 5, 22, 0),
	(12, 5, 23, 0),
	(13, 5, 24, 0),
	(14, 5, 25, 0),
	(15, 5, 26, 0),
	(16, 5, 27, 0),
	(17, 5, 28, 0),
	(18, 5, 29, 0),
	(19, 5, 30, 0),
	(20, 5, 31, 0),
	(21, 5, 32, 0),
	(22, 5, 33, 0),
	(23, 5, 34, 0),
	(24, 5, 35, 0),
	(25, 5, 36, 0),
	(26, 5, 37, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

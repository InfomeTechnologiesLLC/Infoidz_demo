-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 06, 2025 at 10:15 AM
-- Server version: 5.7.44-log
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `infomeglobal_infoidzdemo`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add cards', 7, 'add_cards'),
(26, 'Can change cards', 7, 'change_cards'),
(27, 'Can delete cards', 7, 'delete_cards'),
(28, 'Can view cards', 7, 'view_cards'),
(29, 'Can add contact entries', 8, 'add_contactentries'),
(30, 'Can change contact entries', 8, 'change_contactentries'),
(31, 'Can delete contact entries', 8, 'delete_contactentries'),
(32, 'Can view contact entries', 8, 'view_contactentries'),
(33, 'Can add organizations', 9, 'add_organizations'),
(34, 'Can change organizations', 9, 'change_organizations'),
(35, 'Can delete organizations', 9, 'delete_organizations'),
(36, 'Can view organizations', 9, 'view_organizations'),
(37, 'Can add profile', 10, 'add_profile'),
(38, 'Can change profile', 10, 'change_profile'),
(39, 'Can delete profile', 10, 'delete_profile'),
(40, 'Can view profile', 10, 'view_profile'),
(41, 'Can add social medias', 11, 'add_socialmedias'),
(42, 'Can change social medias', 11, 'change_socialmedias'),
(43, 'Can delete social medias', 11, 'delete_socialmedias'),
(44, 'Can view social medias', 11, 'view_socialmedias'),
(45, 'Can add contact entry social medias', 12, 'add_contactentrysocialmedias'),
(46, 'Can change contact entry social medias', 12, 'change_contactentrysocialmedias'),
(47, 'Can delete contact entry social medias', 12, 'delete_contactentrysocialmedias'),
(48, 'Can view contact entry social medias', 12, 'view_contactentrysocialmedias'),
(49, 'Can add cutomized card', 13, 'add_cutomizedcard'),
(50, 'Can change cutomized card', 13, 'change_cutomizedcard'),
(51, 'Can delete cutomized card', 13, 'delete_cutomizedcard'),
(52, 'Can view cutomized card', 13, 'view_cutomizedcard');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$lcQBpLJK2Yi4KxpXfooFqB$gEoS7eVH5lquXaFgOtmYTwIkGejVOWycqAujgSdaiEY=', '2025-02-04 14:04:25.760985', 1, 'infome', '', '', '', 1, 1, '2024-12-10 04:31:07.648413'),
(2, 'pbkdf2_sha256$390000$ttJfbeHGI0daAEcGJjoidM$DEOmIOcdrFC2XmOY/ZfoOSKkvjbeXGWWoudgbQlPadY=', '2025-02-03 04:43:52.428231', 1, 'admin', '', '', '', 1, 1, '2024-12-10 04:39:16.121615'),
(3, 'pbkdf2_sha256$260000$JDKj9IRa6PVCSRJ1nlgOlL$gCG3FyN9AU5rb93YwBRshqk6BKsBI/GO4bVztXEh0GI=', '2024-12-13 04:46:02.077418', 1, 'vishnu', '', '', '', 1, 1, '2024-12-13 04:45:52.373666'),
(4, 'pbkdf2_sha256$390000$ARbO6qAQKhsBEdg0zFnrz5$oRhv1l8CGTrOrd8aYw87OhetI9cLdk9Ba6TIoUqjc0w=', '2025-01-24 04:10:56.687206', 1, 'demo', '', '', '', 1, 1, '2025-01-14 12:30:55.791594');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `temp_image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `name`, `active`, `temp_image`) VALUES
(1, 'basic', 1, 'card/template/basic.jpeg'),
(2, 'palm leaf', 1, 'card/template/palm-leaf.jpg'),
(3, 'template1', 0, 'card/template/template1.jpg'),
(4, 'template2', 0, 'card/template/template2.jpg'),
(5, 'template3', 0, 'card/template/template3.jpg'),
(6, 'template4', 0, 'card/template/template4.jpg'),
(7, 'alfa', 1, 'card/template/Alfa.jpeg'),
(8, 'beta', 1, 'card/template/beta.jpeg'),
(9, 'sigma', 1, 'card/template/sigma.jpeg'),
(10, 'elegant', 1, 'card/template/elegant.jpeg'),
(11, 'professional', 1, 'card/template/business.jpeg'),
(12, 'business', 1, 'card/template/professional.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `ContactEntries`
--

CREATE TABLE `ContactEntries` (
  `id` bigint(20) NOT NULL,
  `name` longtext,
  `personal_number` varchar(20) DEFAULT NULL,
  `company_name` longtext,
  `designation` longtext,
  `office_number` varchar(20) DEFAULT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `email` longtext,
  `website` longtext,
  `location` longtext,
  `address` longtext,
  `profile_pic` varchar(100) DEFAULT NULL,
  `profile_pic_thumbnail` varchar(100) DEFAULT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `url_slug` varchar(1000) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `card_id` bigint(20) NOT NULL,
  `email2` longtext,
  `about_me` longtext,
  `background_image` varchar(100) DEFAULT NULL,
  `company_logo` varchar(100) DEFAULT NULL,
  `business_card` text,
  `writed` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ContactEntries`
--

INSERT INTO `ContactEntries` (`id`, `name`, `personal_number`, `company_name`, `designation`, `office_number`, `whatsapp_number`, `email`, `website`, `location`, `address`, `profile_pic`, `profile_pic_thumbnail`, `cover_image`, `url_slug`, `created_at`, `updated_at`, `active`, `created_by_id`, `card_id`, `email2`, `about_me`, `background_image`, `company_logo`, `business_card`, `writed`) VALUES
(1, 'Vishnu vp', '7012733192', NULL, 'Software Developer', '7012733192', '7012733192', 'vishnuprabhakar014@gmail.com', 'https://www.infomeuae.com/', 'Kochi, Kerala', 'Pavizhakkunnu, Mudappallur', 'profile/profile_pic_FOPvZmZ.png', 'profile/thubnail/profile_pic_uumxm87.png', '', '14b5905224', '2025-01-15', '2025-02-05', 1, 2, 8, NULL, NULL, '', '', '', 0),
(2, 'ghfsdfjkf', '45545645', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '54d0abb800', '2025-02-04', '2025-02-04', 1, 1, 9, NULL, NULL, '', '', '', 0),
(3, 'test', '676989820', NULL, 'test designation', '88898099', '87989490909', 'test@gmail.com', 'www.test.com', 'test location', 'test address', '', '', '', 'a784de01b7', '2025-02-05', '2025-02-05', 0, 1, 1, NULL, NULL, '', '', '', 0),
(4, 'ram', '983093000', NULL, 'developer', '8898929099', '909843382', 'ram@gmail.com', 'www.ram.com', 'kochi,India', 'kochi', '', '', '', '3826e95773', '2025-02-05', '2025-02-05', 0, 1, 1, NULL, NULL, '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ContactEntries_social_medias`
--

CREATE TABLE `ContactEntries_social_medias` (
  `id` bigint(20) NOT NULL,
  `contactentries_id` bigint(20) NOT NULL,
  `contactentrysocialmedias_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contact_entry_social_medias`
--

CREATE TABLE `contact_entry_social_medias` (
  `id` bigint(20) NOT NULL,
  `link` longtext NOT NULL,
  `active` tinyint(1) NOT NULL,
  `social_media_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_details`
--

CREATE TABLE `customer_details` (
  `id` bigint(20) NOT NULL,
  `name` text,
  `email` text,
  `phone` varchar(20) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_details`
--

INSERT INTO `customer_details` (`id`, `name`, `email`, `phone`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Vishnu vp', 'vishnuprabhakar014@gmail.com', '7012733192', 1, '2025-01-27', '2025-01-27'),
(2, 'Athul V SABU', 'athulvsabu@gmail.com', '09656130814', 1, '2025-02-04', '2025-02-04'),
(3, 'Athul V SABU', 'test@gmail.com', '09656130814', 1, '2025-02-04', '2025-02-04');

-- --------------------------------------------------------

--
-- Table structure for table `customized_card_contact`
--

CREATE TABLE `customized_card_contact` (
  `id` bigint(20) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `styles` longtext,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'app', 'cards'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'portal', 'contactentries'),
(12, 'portal', 'contactentrysocialmedias'),
(13, 'portal', 'cutomizedcard'),
(9, 'portal', 'organizations'),
(10, 'portal', 'profile'),
(11, 'portal', 'socialmedias'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-12-09 13:00:15.913199'),
(2, 'auth', '0001_initial', '2024-12-09 13:00:16.165573'),
(3, 'admin', '0001_initial', '2024-12-09 13:00:16.227049'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-12-09 13:00:16.235723'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-09 13:00:16.242970'),
(6, 'app', '0001_initial', '2024-12-09 13:00:16.253881'),
(7, 'app', '0002_cards_active_cards_temp_image', '2024-12-09 13:00:16.286938'),
(8, 'contenttypes', '0002_remove_content_type_name', '2024-12-09 13:00:16.330877'),
(9, 'auth', '0002_alter_permission_name_max_length', '2024-12-09 13:00:16.341019'),
(10, 'auth', '0003_alter_user_email_max_length', '2024-12-09 13:00:16.351200'),
(11, 'auth', '0004_alter_user_username_opts', '2024-12-09 13:00:16.358992'),
(12, 'auth', '0005_alter_user_last_login_null', '2024-12-09 13:00:16.381680'),
(13, 'auth', '0006_require_contenttypes_0002', '2024-12-09 13:00:16.383479'),
(14, 'auth', '0007_alter_validators_add_error_messages', '2024-12-09 13:00:16.392268'),
(15, 'auth', '0008_alter_user_username_max_length', '2024-12-09 13:00:16.402324'),
(16, 'auth', '0009_alter_user_last_name_max_length', '2024-12-09 13:00:16.412308'),
(17, 'auth', '0010_alter_group_name_max_length', '2024-12-09 13:00:16.422523'),
(18, 'auth', '0011_update_proxy_permissions', '2024-12-09 13:00:16.430534'),
(19, 'auth', '0012_alter_user_first_name_max_length', '2024-12-09 13:00:16.440611'),
(20, 'portal', '0001_initial', '2024-12-09 13:00:16.525682'),
(21, 'portal', '0002_organizations_userdetails_name', '2024-12-09 13:00:16.559339'),
(22, 'portal', '0003_userdetails_organization', '2024-12-09 13:00:16.591164'),
(23, 'portal', '0004_alter_userdetails_user', '2024-12-09 13:00:16.637156'),
(24, 'portal', '0005_rename_userdetails_profile', '2024-12-09 13:00:16.655882'),
(25, 'portal', '0006_rename_profile_pic_thubnail_contactentries_profile_pic_thumbnail', '2024-12-09 13:00:16.668747'),
(26, 'portal', '0007_socialmedias', '2024-12-09 13:00:16.680192'),
(27, 'portal', '0008_socialmedias_active', '2024-12-09 13:00:16.698223'),
(28, 'portal', '0009_contactentrysocialmedias_and_more', '2024-12-09 13:00:16.700011'),
(29, 'portal', '0010_contactentrysocialmedias_and_more', '2024-12-09 13:00:16.701849'),
(30, 'portal', '0011_contactentrysocialmedias_and_more', '2024-12-09 13:00:16.803892'),
(31, 'portal', '0012_contactentries_card', '2024-12-09 13:00:16.840135'),
(32, 'portal', '0013_contactentries_email2', '2024-12-09 13:00:16.868937'),
(33, 'portal', '0014_auto_20241204_0923', '2024-12-09 13:00:17.065002'),
(34, 'sessions', '0001_initial', '2024-12-09 13:00:17.084754');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0l9ypp7al8c27lls2eky5nbdotz6pq2f', '.eJxVjMsOwiAQRf-FtSEgj4BL934DGWYGqRpISrtq_Hdt0oVu7znnbiLButS0Dp7TROIizuL0u2XAJ7cd0APavUvsbZmnLHdFHnTIWyd-XQ_376DCqN9aWQVs0FgNAcEho0YfqNisILpsMbjiStbRROOxWE-aVGanyHEAsOL9AfzKOLA:1tcOkr:SL-VwfpARiVcRBgsE1Gk-fFeOvs4PmbKxG5jDK5IX2A', '2025-02-10 13:02:17.725529'),
('3cwcq011bjmeivh4rh3cn269ttqyw5lo', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tfJXN:3V-Dj0pyjnzVP1HIrph1kneCQjJm2QuOOFotfwlYbBI', '2025-02-18 14:04:25.764340'),
('6bwc9dq3ocm81hn92lx760n5kkz2z4st', '.eJxVjMsOwiAQRf-FtSEgj4BL934DGWYGqRpISrtq_Hdt0oVu7znnbiLButS0Dp7TROIizuL0u2XAJ7cd0APavUvsbZmnLHdFHnTIWyd-XQ_376DCqN9aWQVs0FgNAcEho0YfqNisILpsMbjiStbRROOxWE-aVGanyHEAsOL9AfzKOLA:1tXzJu:MtWi-7Ucvhz1UuDjnRiFzi1P5epzpMK6jQgn23Upa88', '2025-01-29 09:04:14.540258'),
('6dwaxeqp52jq2uywpeb0zdm6pj8g2j2b', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tcLPE:jN6CI2AbVDsGS2FCc2F0gtsVKQpADZ3KwKNQKq5Y67A', '2025-02-10 09:27:44.620055'),
('do77p4nq1y5bb5jty7h06oftru20pahi', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tfGUf:KniNlZCbS6eTC66Ka5gQ3ETRsArCNR8DSMFZ24bZgag', '2025-02-18 10:49:25.412398'),
('dzoyrmpd1j3ugy8luuenrs12t0hguhk9', '.eJxVjEEOgjAQRe_StWlKpR3GpXvO0MxMB0FNSSisjHdXEha6_e-9_zKJtnVMW9UlTdlcjDen341JHlp2kO9UbrOVuazLxHZX7EGr7eesz-vh_h2MVMdv7VoE7JRD26BTBGJg5x1nCYNCoxrO0HmPCEOQBgO3IjHngSKDKEXz_gDX0jhL:1tKs4o:Wew-Hv5Cbw4KUZFaMiVDoZIu_SqbGtEPLrKnn6wqDf4', '2024-12-24 04:42:26.382791'),
('khpfql0ntfg3ctlgqvwt5jtpm2bhe9l5', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tdqK5:6kY3r-rzmzmJI7_D41XxP2RlgnM3p2BFkYiwMlCGWV0', '2025-02-14 12:40:37.035895'),
('mysia2qgucohtc1lyqv6rnp25ee7m3ut', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tfAYo:PXjsmLPFrVg3hgpLDUSh69H2SarntLcl4BHFZKXDOuw', '2025-02-18 04:29:18.179526'),
('p24uh9erz24prrdf1s21n2n3cqgaey0q', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tf9yc:5dYUVIH3iF9Du3gC82TG3q_z_9ulJZnScQKi7z8ooNE', '2025-02-18 03:51:54.628780'),
('stu6fjjwe2wadglb5fdr6vfx6gwonp5l', '.eJxVjEEOwiAQRe_C2hAoI6Uu3fcMZIYZpGpoUtqV8e7apAvd_vfef6mI21ri1mSJE6uLcur0uxGmh9Qd8B3rbdZprusykd4VfdCmx5nleT3cv4OCrXxr8sA-22AwAxtAI3ZwmSmD73MHwRk0VoIXBOIUBBN5PJs-EwzchaTeH_jeOLg:1tLxYw:Z863Zo7yXDhBMYhOvzYaIp7wl_WaFdWK8dTZr82VT1A', '2024-12-27 04:46:02.082375'),
('wtspcvr1bzj5w8bbmbg09163er0fbw9t', '.eJxVjMsOwiAQRf-FtSEgj4BL934DGWYGqRpISrtq_Hdt0oVu7znnbiLButS0Dp7TROIizuL0u2XAJ7cd0APavUvsbZmnLHdFHnTIWyd-XQ_376DCqN9aWQVs0FgNAcEho0YfqNisILpsMbjiStbRROOxWE-aVGanyHEAsOL9AfzKOLA:1tXzJW:5j1Tsd4qVNd986QsDzI5L7TzhPIqyg4DdSqVQD4tweU', '2025-01-29 09:03:50.201565'),
('x6yxfu6pp80mzq8aecwqdf3qev24x77l', '.eJxVjMsOwiAQRf-FtSFDS3m4dO83EJgZpGogKe3K-O_apAvd3nPOfYkQt7WErfMSZhJnocTpd0sRH1x3QPdYb01iq-syJ7kr8qBdXhvx83K4fwcl9vKtByawk8FobPbgHQCChmxxMCOjZxhTZKdRkfWcKSfF2o2WHZkpOVLi_QHjljhA:1tcOao:estdojXwCwLeFSK9War6l70H8_kYM1O2Wc3FfeADKcU', '2025-02-10 12:51:54.990272');

-- --------------------------------------------------------

--
-- Table structure for table `Organizations`
--

CREATE TABLE `Organizations` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `contact_limit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Organizations`
--

INSERT INTO `Organizations` (`id`, `name`, `active`, `expiry_date`, `contact_limit`) VALUES
(1, 'INFOME', 1, '2030-12-31', 120);

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

CREATE TABLE `social_medias` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `social_medias`
--

INSERT INTO `social_medias` (`id`, `name`, `icon`, `active`) VALUES
(1, 'Facebook', 'fa-brands fa-facebook', 1),
(2, 'Instagram', 'fa-brands fa-instagram', 1),
(3, 'Linkedin', 'fa-brands fa-linkedin', 1),
(4, 'Twitter', 'fa-brands fa-twitter', 1),
(5, 'Threads', 'bi bi-threads', 1);

-- --------------------------------------------------------

--
-- Table structure for table `UserDetails`
--

CREATE TABLE `UserDetails` (
  `id` bigint(20) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `organization_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserDetails`
--

INSERT INTO `UserDetails` (`id`, `active`, `created_at`, `user_id`, `name`, `organization_id`) VALUES
(1, 1, '2024-12-10', 1, 'Infome', 1),
(2, 1, '2024-12-10', 2, 'Admin', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ContactEntries`
--
ALTER TABLE `ContactEntries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ContactEntries_created_by_id_933f5a14_fk_auth_user_id` (`created_by_id`),
  ADD KEY `ContactEntries_card_id_7aaf656f_fk_cards_id` (`card_id`);

--
-- Indexes for table `ContactEntries_social_medias`
--
ALTER TABLE `ContactEntries_social_medias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ContactEntries_social_me_contactentries_id_contac_14c998b7_uniq` (`contactentries_id`,`contactentrysocialmedias_id`),
  ADD KEY `ContactEntries_socia_contactentrysocialme_00116a89_fk_contact_e` (`contactentrysocialmedias_id`);

--
-- Indexes for table `contact_entry_social_medias`
--
ALTER TABLE `contact_entry_social_medias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contact_entry_social_social_media_id_bb4ca6fc_fk_social_me` (`social_media_id`);

--
-- Indexes for table `customer_details`
--
ALTER TABLE `customer_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customized_card_contact`
--
ALTER TABLE `customized_card_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `Organizations`
--
ALTER TABLE `Organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_medias`
--
ALTER TABLE `social_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `UserDetails`
--
ALTER TABLE `UserDetails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UserDetails_user_id_f3c37232_uniq` (`user_id`),
  ADD KEY `UserDetails_organization_id_2260585a_fk_Organizations_id` (`organization_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ContactEntries`
--
ALTER TABLE `ContactEntries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ContactEntries_social_medias`
--
ALTER TABLE `ContactEntries_social_medias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_entry_social_medias`
--
ALTER TABLE `contact_entry_social_medias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_details`
--
ALTER TABLE `customer_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customized_card_contact`
--
ALTER TABLE `customized_card_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `Organizations`
--
ALTER TABLE `Organizations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `social_medias`
--
ALTER TABLE `social_medias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `UserDetails`
--
ALTER TABLE `UserDetails`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `ContactEntries`
--
ALTER TABLE `ContactEntries`
  ADD CONSTRAINT `ContactEntries_card_id_7aaf656f_fk_cards_id` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`),
  ADD CONSTRAINT `ContactEntries_created_by_id_933f5a14_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `ContactEntries_social_medias`
--
ALTER TABLE `ContactEntries_social_medias`
  ADD CONSTRAINT `ContactEntries_socia_contactentries_id_2e5d3145_fk_ContactEn` FOREIGN KEY (`contactentries_id`) REFERENCES `ContactEntries` (`id`),
  ADD CONSTRAINT `ContactEntries_socia_contactentrysocialme_00116a89_fk_contact_e` FOREIGN KEY (`contactentrysocialmedias_id`) REFERENCES `contact_entry_social_medias` (`id`);

--
-- Constraints for table `contact_entry_social_medias`
--
ALTER TABLE `contact_entry_social_medias`
  ADD CONSTRAINT `contact_entry_social_social_media_id_bb4ca6fc_fk_social_me` FOREIGN KEY (`social_media_id`) REFERENCES `social_medias` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `UserDetails`
--
ALTER TABLE `UserDetails`
  ADD CONSTRAINT `UserDetails_organization_id_2260585a_fk_Organizations_id` FOREIGN KEY (`organization_id`) REFERENCES `Organizations` (`id`),
  ADD CONSTRAINT `UserDetails_user_id_f3c37232_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

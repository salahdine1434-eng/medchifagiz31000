-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 11 mai 2026 à 11:49
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `medchifagiz`
--

-- --------------------------------------------------------

--
-- Structure de la table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `status` enum('pending','confirmed','cancelled','completed','no_show') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `patient_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `case_type` enum('عادية','مستعجلة','مزمنة') DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `doctor_id`, `status`, `created_at`, `patient_name`, `phone`, `case_type`, `appointment_date`, `appointment_time`) VALUES
(48, 76, 49, 'confirmed', '2026-05-07 16:31:00', 'kiko', '06554432118', 'مستعجلة', '2026-05-07', '08:08:00'),
(49, 76, 49, 'confirmed', '2026-05-09 14:31:52', 'njet', '06554432118', 'عادية', '2026-05-09', '10:00:00'),
(59, 0, 49, 'confirmed', '2026-05-09 23:59:57', NULL, NULL, NULL, '2026-05-11', '22:02:00'),
(60, 80, 50, 'confirmed', '2026-05-10 01:14:23', 'naji', '06554432118', 'عادية', '2026-05-10', '22:02:00'),
(61, 62, 55, 'confirmed', '2026-05-10 11:28:19', 'kheira', '06554432118', 'عادية', '2026-05-10', '08:00:00'),
(63, 76, 49, 'confirmed', '2026-05-10 11:32:57', 'sara', '097542287', 'عادية', '2026-05-10', '08:08:00'),
(64, 62, 49, 'confirmed', '2026-05-10 22:58:39', 'najt', '06554432118', 'عادية', '2026-05-11', '22:02:00');

-- --------------------------------------------------------

--
-- Structure de la table `associations`
--

CREATE TABLE `associations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `associations`
--

INSERT INTO `associations` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Association El Ihsane', 35.1905, -0.6319, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Association Kafil El Yatim', 35.1925, -0.637, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Association Amarnas Solidaire', 35.1526, -0.7002, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Association Sidi Lahcene Khir', 35.2052, -0.6868, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Association Main dans la Main', 35.1879, -0.6282, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Association El Amal', 35.191, -0.6325, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Association Enour', 35.1932, -0.638, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Association Solidarité Plus', 35.187, -0.6285, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Association Rahma Aid', 35.1555, -0.701, 'Sidi Bel Abbes', 'Amarnas'),
(10, 'Association Sidi Djilali', 35.207, -0.689, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(11, 'Association El Baraka', 35.1885, -0.6275, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(12, 'Association Aide Médicale', 35.1902, -0.6338, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(13, 'Association Main dans la Main 2', 35.1928, -0.636, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `civil_protection`
--

CREATE TABLE `civil_protection` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `civil_protection`
--

INSERT INTO `civil_protection` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Protection Civile Sidi Bel Abbes 1', 35.1899, -0.6333, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Protection Civile Centre', 35.1918, -0.6375, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Protection Civile Amarnas', 35.1545, -0.7025, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Protection Civile Sidi Lahcene', 35.2055, -0.687, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Unité Secours Ouest', 35.1872, -0.627, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Protection Civile SBA Nord', 35.1905, -0.634, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Protection Civile SBA Est', 35.1922, -0.6365, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Protection Civile SBA Sud', 35.188, -0.629, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Unité Secours Amarnas 2', 35.1565, -0.7045, 'Sidi Bel Abbes', 'Amarnas'),
(10, 'Centre Intervention Amarnas', 35.158, -0.706, 'Sidi Bel Abbes', 'Amarnas'),
(11, 'Protection Civile Sidi Lahcene 2', 35.2075, -0.6895, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(12, 'Unité Secours Lahcene', 35.209, -0.691, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(13, 'Protection Civile Ouest 2', 35.1865, -0.6265, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(14, 'Centre Secours Central', 35.1898, -0.6312, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(15, 'Unité Intervention Rapide', 35.1915, -0.6335, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `clinics`
--

CREATE TABLE `clinics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clinics`
--

INSERT INTO `clinics` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Clinique El Rahma', 35.1908, -0.6328, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Clinique Ibn Rochd', 35.1922, -0.6368, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Clinique Amarnas', 35.1528, -0.7008, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Clinique Sidi Lahcene', 35.2038, -0.6848, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Clinique Echifa', 35.188, -0.629, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Clinique El Nour', 35.1895, -0.6315, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Clinique El Baraka', 35.1918, -0.6338, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Clinique El Hikma', 35.1935, -0.6355, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Clinique Amarnas Plus', 35.1545, -0.7025, 'Sidi Bel Abbes', 'Amarnas'),
(10, 'Clinique Chifa Amarnas', 35.1562, -0.7042, 'Sidi Bel Abbes', 'Amarnas'),
(11, 'Clinique Sidi Lahcene Care', 35.2065, -0.6875, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(12, 'Clinique Rahma Lahcene', 35.2082, -0.6892, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(13, 'Clinique Centrale Plus', 35.1875, -0.6275, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(14, 'Clinique El Amal Care', 35.1888, -0.6288, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(15, 'Clinique Ibn Sina Plus', 35.1902, -0.6302, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `communes`
--

CREATE TABLE `communes` (
  `id` int(11) NOT NULL,
  `wilaya_id` int(11) NOT NULL,
  `name_fr` varchar(100) NOT NULL,
  `name_ar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `communes`
--

INSERT INTO `communes` (`id`, `wilaya_id`, `name_fr`, `name_ar`) VALUES
(1, 1, 'Adrar', 'أدرار'),
(2, 1, 'Tamest', 'تامست'),
(3, 1, 'Charouine', 'شروين'),
(4, 1, 'Reggane', 'رقان'),
(5, 1, 'In Zghmir', 'إن زغمير'),
(6, 1, 'Tit', 'تيت'),
(7, 1, 'Ksar Kaddour', 'قصر قدور'),
(8, 1, 'Tsabit', 'تسابيت'),
(9, 1, 'Timimoun', 'تيميمون'),
(10, 1, 'Ouled Said', 'أولاد سعيد'),
(11, 1, 'Zaouiet Kounta', 'زاوية كنتة'),
(12, 1, 'Aoulef', 'أولف'),
(13, 1, 'Timokten', 'تيموكتن'),
(14, 1, 'Tinerkouk', 'تينركوك'),
(15, 1, 'Deldoul', 'دلدول'),
(16, 1, 'Sali', 'صالي'),
(17, 1, 'Akabli', 'أقبلي'),
(18, 1, 'Metarfa', 'مطارفة'),
(19, 1, 'Ouled Ahmed Timmi', 'أولاد أحمد تيمي'),
(20, 1, 'Bouda', 'بودة'),
(21, 1, 'Aougrout', 'أوقروت'),
(22, 1, 'Talmine', 'تالمين'),
(23, 1, 'Bordj Badji Mokhtar', 'برج باجي مختار'),
(24, 1, 'Sbaa', 'سبع'),
(25, 1, 'Ouled Aissa', 'أولاد عيسى'),
(26, 1, 'Timiaouine', 'تيميياوين'),
(27, 2, 'Chlef', 'الشلف'),
(28, 2, 'Ténès', 'تنس'),
(29, 2, 'Benairia', 'بنايرية'),
(30, 2, 'El Karimia', 'الكريمية'),
(31, 2, 'Tadjna', 'تاجنة'),
(32, 2, 'Taougrite', 'تاوقريت'),
(33, 2, 'Beni Haoua', 'بني حواء'),
(34, 2, 'Sobha', 'صبحة'),
(35, 2, 'Harchoun', 'هارشون'),
(36, 2, 'Ouled Fares', 'أولاد فارس'),
(37, 2, 'Sidi Akacha', 'سيدي عكاشة'),
(38, 2, 'Boukadir', 'بوقادير'),
(39, 2, 'Beni Rached', 'بني راشد'),
(40, 2, 'Talassa', 'تلعصة'),
(41, 2, 'Herenfa', 'هرنفة'),
(42, 2, 'Oued Goussine', 'وادي قوسين'),
(43, 2, 'Djendel', 'جندل'),
(44, 2, 'El Marsa', 'المرسى'),
(45, 2, 'Oum Drou', 'أم الدروع'),
(46, 2, 'Abou El Hassan', 'أبو الحسن'),
(47, 2, 'Sendjas', 'سنجاس'),
(48, 2, 'Zeboudja', 'الزبوجة'),
(49, 2, 'Ain Merane', 'عين مران'),
(50, 2, 'Ouled Abbes', 'أولاد عباس'),
(51, 2, 'Chorfa', 'الشرفاء'),
(52, 2, 'Labiod Medjadja', 'العبيد مجاجة'),
(53, 2, 'El Hadjadj', 'الحجاج'),
(54, 2, 'Moussadek', 'موساديق'),
(55, 2, 'El Oued', 'الوادي'),
(56, 2, 'Bouzghaia', 'بوزغاية'),
(57, 2, 'Ain Tarma', 'عين طارمة'),
(58, 2, 'Beni Bouattab', 'بني بوعتاب'),
(59, 2, 'Ibn Badis', 'ابن باديس'),
(60, 2, 'Chettia', 'الشطية'),
(61, 2, 'Sidi Abderrahmane', 'سيدي عبد الرحمان'),
(62, 2, 'Remila', 'الرميلة'),
(63, 3, 'Laghouat', 'الأغواط'),
(64, 3, 'Ksar El Hirane', 'قصر الحيران'),
(65, 3, 'Benoud', 'بنود'),
(66, 3, 'Brida', 'بريدة'),
(67, 3, 'Gueltat Sidi Saad', 'قلتة سيدي سعد'),
(68, 3, 'Ain Mahdi', 'عين ماضي'),
(69, 3, 'Tadjemout', 'تاجموت'),
(70, 3, 'Kheneg', 'الخنق'),
(71, 3, 'Hassi Delaa', 'حاسي دلاعة'),
(72, 3, 'Hassi R Mel', 'حاسي الرمل'),
(73, 3, 'Ain Sidi Ali', 'عين سيدي علي'),
(74, 3, 'Beidha', 'البيضاء'),
(75, 3, 'Aflou', 'أفلو'),
(76, 3, 'El Ghicha', 'الغيشة'),
(77, 3, 'Hadj Mechri', 'الحاج المشري'),
(78, 3, 'Sebgag', 'سبقاق'),
(79, 3, 'Taouiala', 'تاويالة'),
(80, 3, 'Tadjrouna', 'تاجرونة'),
(81, 3, 'El Houaita', 'الحويطة'),
(82, 3, 'Sidi Makhlouf', 'سيدي مخلوف'),
(83, 3, 'Oued Morra', 'وادي مرة'),
(84, 3, 'Oued M Zi', 'وادي مزي'),
(85, 3, 'El Assafia', 'الصفيصفة'),
(86, 3, 'Ain Touta', 'عين التوتة'),
(87, 4, 'Oum El Bouaghi', 'أم البواقي'),
(88, 4, 'Ain Babouche', 'عين بابوش'),
(89, 4, 'Berriche', 'بريش'),
(90, 4, 'Ain Zitoun', 'عين الزيتون'),
(91, 4, 'Ouled Zouai', 'أولاد زواي'),
(92, 4, 'Behir Chergui', 'بهير الشرقي'),
(93, 4, 'Ksar Sbahi', 'قصر صباحي'),
(94, 4, 'Ain Kercha', 'عين كرشة'),
(95, 4, 'Hanchir Toumghani', 'هنشير التومغني'),
(96, 4, 'El Amiria', 'الأميرية'),
(97, 4, 'Ain Fakroun', 'عين فكرون'),
(98, 4, 'Rahia', 'الراحية'),
(99, 4, 'Meskiana', 'مسكيانة'),
(100, 4, 'Ain Babouche', 'عين بابوش'),
(101, 4, 'Souk Naamane', 'سوق نعمان'),
(102, 4, 'Zorg', 'زرق'),
(103, 4, 'El Fedjoudj', 'الفجوج'),
(104, 4, 'Ouled Gacem', 'أولاد قاسم'),
(105, 4, 'El Harmilia', 'الحرملية'),
(106, 5, 'Batna', 'باتنة'),
(107, 5, 'Ghassira', 'غسيرة'),
(108, 5, 'Maafa', 'معافة'),
(109, 5, 'Merouana', 'مروانة'),
(110, 5, 'Seriana', 'سريانة'),
(111, 5, 'Menaa', 'منعة'),
(112, 5, 'El Madher', 'المعذر'),
(113, 5, 'Tazoult', 'تازولت'),
(114, 5, 'N Gaous', 'نقاوس'),
(115, 5, 'Guigba', 'قيقبة'),
(116, 5, 'Inoughissen', 'إينوغيسن'),
(117, 5, 'Ouyoun El Assafir', 'عيون العصافير'),
(118, 5, 'Djerma', 'جرمة'),
(119, 5, 'Bitam', 'بيطام'),
(120, 5, 'Metkaouak', 'متكاوك'),
(121, 5, 'Ouled Aouf', 'أولاد عوف'),
(122, 5, 'Boulhilat', 'بولحيلات'),
(123, 5, 'Lazrou', 'لازرو'),
(124, 5, 'Timgad', 'تيمقاد'),
(125, 5, 'Ras El Aioun', 'رأس العيون'),
(126, 5, 'Chir', 'شير'),
(127, 5, 'Ouled Sellam', 'أولاد سلام'),
(128, 5, 'Tigherghar', 'تيغرغار'),
(129, 5, 'Aïn Djasser', 'عين جاسر'),
(130, 5, 'Ouled Si Slimane', 'أولاد سي سليمان'),
(131, 5, 'Ghoufi', 'غوفي'),
(132, 5, 'Aïn Yagout', 'عين ياقوت'),
(133, 5, 'Fesdis', 'فسديس'),
(134, 5, 'El Hassi', 'الحاسي'),
(135, 5, 'Oued El Ma', 'وادي الماء'),
(136, 5, 'Bouzina', 'بوزينة'),
(137, 5, 'Chemorra', 'شمورة'),
(138, 5, 'Barika', 'بريكة'),
(139, 5, 'Djezzar', 'الجزار'),
(140, 5, 'Larbaa', 'الأربعاء'),
(141, 5, 'Boumagueur', 'بومقور'),
(142, 5, 'Ain Touta', 'عين التوتة'),
(143, 5, 'Tilatou', 'تيلاطو'),
(144, 5, 'Ichmoul', 'إيشمول'),
(145, 5, 'Foum Toub', 'فم الطوب'),
(146, 5, 'Boulhaf Dyr', 'بولحاف الدير'),
(147, 5, 'Hidoussa', 'حيدوسة'),
(148, 5, 'Arris', 'آريس'),
(149, 5, 'Kimmel', 'كيمل'),
(150, 5, 'Teniet El Abed', 'تنيت العابد'),
(151, 5, 'Oued Chaaba', 'وادي الشعبة'),
(152, 5, 'Taxlent', 'تكسلنت'),
(153, 5, 'Gosbat', 'قصبة'),
(154, 5, 'Ouled Fadel', 'أولاد فاضل'),
(155, 5, 'Rahbat', 'رحبة'),
(156, 5, 'Talkhamt', 'تلخمت'),
(157, 5, 'Lemsane', 'لمسان'),
(158, 5, 'Ksar Bellezma', 'قصر بلزمة'),
(159, 5, 'Seggana', 'سقانة'),
(160, 5, 'Ain Skhouna', 'عين سخونة'),
(161, 5, 'Zanat El Beida', 'ذانات البيضاء'),
(162, 5, 'Boumia', 'بومية'),
(163, 5, 'Oued El Maadi', 'وادي المعادي'),
(164, 5, 'Bitam', 'بيطام'),
(165, 5, 'Abdelkader Azil', 'عبد القادر عزيل'),
(166, 5, 'El Korichi', 'القريشي'),
(167, 6, 'Béjaïa', 'بجاية'),
(168, 6, 'Amizour', 'أميزور'),
(169, 6, 'Ferraouen', 'فراون'),
(170, 6, 'Taourirt Ighil', 'تاوريرت إغيل'),
(171, 6, 'Chellata', 'شلاطة'),
(172, 6, 'Tamokra', 'تاموقرة'),
(173, 6, 'Timezrit', 'تيمزريت'),
(174, 6, 'Souk El Tenine', 'سوق الإثنين'),
(175, 6, 'Melbou', 'ملبو'),
(176, 6, 'Akbou', 'أقبو'),
(177, 6, 'Seddouk', 'صدوق'),
(178, 6, 'Tazmalt', 'تازمالت'),
(179, 6, 'Ighil Ali', 'إغيل علي'),
(180, 6, 'Feraoun', 'فرعون'),
(181, 6, 'Tizi N Berber', 'تيزي نبربر'),
(182, 6, 'Chemini', 'شميني'),
(183, 6, 'Souk Oufella', 'سوق أوفلة'),
(184, 6, 'Taskriout', 'تاسقريوت'),
(185, 6, 'Tibane', 'تيبان'),
(186, 6, 'El Kseur', 'القصر'),
(187, 6, 'Barbacha', 'بربشة'),
(188, 6, 'Beni Djellil', 'بني جليل'),
(189, 6, 'Aït Smail', 'آيت إسماعيل'),
(190, 6, 'Ouzellaguen', 'أوزلاقن'),
(191, 6, 'Ighrem', 'أغرم'),
(192, 6, 'Aokas', 'أوقاس'),
(193, 6, 'Beni Maouche', 'بني معوش'),
(194, 6, 'Darguina', 'درقينة'),
(195, 6, 'Sidi Aich', 'سيدي عيش'),
(196, 6, 'Aït Rzine', 'آيت رزين'),
(197, 6, 'Adekar', 'أدكار'),
(198, 6, 'Akfadou', 'أكفادو'),
(199, 6, 'Leflaye', 'لفلاي'),
(200, 6, 'Kherrata', 'خراطة'),
(201, 6, 'Draa El Caïd', 'ضرع القايد'),
(202, 6, 'Tizi Ghennif', 'تيزي غنيف'),
(203, 6, 'Kendira', 'كنديرة'),
(204, 6, 'Tifra', 'تيفرة'),
(205, 6, 'Ighil Bazin', 'إغيل بازن'),
(206, 6, 'Bouhamza', 'بوحمزة'),
(207, 6, 'Beni Ksila', 'بني قسيلة'),
(208, 6, 'Oued Ghir', 'وادي غير'),
(209, 6, 'Boukhelifa', 'بوخليفة'),
(210, 6, 'Tala Hamza', 'تالة حمزة'),
(211, 6, 'Aït Smail', 'آيت إسماعيل'),
(212, 6, 'Fritissa', 'فريتيسة'),
(213, 6, 'Beni Mellikeche', 'بني مليكاش'),
(214, 6, 'Semaoun', 'سمعون'),
(215, 6, 'Sidi Aich', 'سيدي عيش'),
(216, 6, 'Aït Smail', 'آيت إسماعيل'),
(217, 6, 'Meghaier', 'مغاير'),
(218, 7, 'Biskra', 'بسكرة'),
(219, 7, 'Oumache', 'أوماش'),
(220, 7, 'Branis', 'براني'),
(221, 7, 'El Kantara', 'القنطرة'),
(222, 7, 'Sidi Okba', 'سيدي عقبة'),
(223, 7, 'Ain Naga', 'عين ناقة'),
(224, 7, 'Zeribet El Oued', 'زريبة الوادي'),
(225, 7, 'El Haouch', 'الحوش'),
(226, 7, 'Lichana', 'ليشانة'),
(227, 7, 'Ourlal', 'أورلال'),
(228, 7, 'Tolga', 'طولقة'),
(229, 7, 'Bouchagroun', 'بوشقرون'),
(230, 7, 'M Chounech', 'مشونش'),
(231, 7, 'El Ghrous', 'الغروس'),
(232, 7, 'Foughala', 'فوغالة'),
(233, 7, 'Bordj Ben Azzouz', 'برج بن عزوز'),
(234, 7, 'Djemorah', 'جمورة'),
(235, 7, 'Ain Ben Naoui', 'عين بن ناوي'),
(236, 7, 'Lioua', 'ليوة'),
(237, 7, 'Chetma', 'شتمة'),
(238, 7, 'Xeria', 'خيري'),
(239, 7, 'Sidi Khaled', 'سيدي خالد'),
(240, 7, 'Doucen', 'دوسن'),
(241, 7, 'Ras El Miad', 'رأس الميعاد'),
(242, 7, 'El Feidh', 'الفيض'),
(243, 7, 'Besbes', 'الببس'),
(244, 7, 'El Hadjeb', 'الحاجب'),
(245, 7, 'Sidi Ghzel', 'سيدي غزال'),
(246, 7, 'Ain Zaatout', 'عين زعطوط'),
(247, 7, 'El Outaya', 'العوطاية'),
(248, 7, 'Oued El Djia', 'وادي الجيا'),
(249, 7, 'Mekhadma', 'مخادمة'),
(250, 8, 'Béchar', 'بشار'),
(251, 8, 'Erg Ferradj', 'عرق فراج'),
(252, 8, 'Lahmar', 'لحمر'),
(253, 8, 'Meridja', 'المريجة'),
(254, 8, 'Igli', 'إقلي'),
(255, 8, 'Beni Ounif', 'بني ونيف'),
(256, 8, 'Boukais', 'بوكايس'),
(257, 8, 'Mogheul', 'مقرة'),
(258, 8, 'Ain Skhouna', 'عين سخونة'),
(259, 8, 'Ouled Khoudir', 'أولاد خدير'),
(260, 8, 'Tabelbala', 'تبلبالة'),
(261, 8, 'Taghit', 'تاغيت'),
(262, 8, 'Timoudi', 'تيمودي'),
(263, 8, 'Kerzaz', 'كرزاز'),
(264, 8, 'Oulad Khodeir', 'أولاد خدير'),
(265, 8, 'Abadla', 'عبادلة'),
(266, 8, 'Beni Abbes', 'بني عباس'),
(267, 8, 'El Ouata', 'الواطة'),
(268, 8, 'Kenedsa', 'كنادسة'),
(269, 8, 'Mechraa Houari Boumediene', 'مشرع هواري بومدين'),
(270, 9, 'Blida', 'البليدة'),
(271, 9, 'Chebli', 'الشبلي'),
(272, 9, 'Mouzaia', 'الموزاية'),
(273, 9, 'Oued El Alleug', 'وادي العلايق'),
(274, 9, 'Chrea', 'الشريعة'),
(275, 9, 'Bougara', 'بوغار'),
(276, 9, 'Larbaatache', 'الأربعطاش'),
(277, 9, 'Ouled Slama', 'أولاد سلامة'),
(278, 9, 'El Affroun', 'الأفرون'),
(279, 9, 'Beni Tamou', 'بني تامو'),
(280, 9, 'Hammam Melouane', 'حمام الملوان'),
(281, 9, 'Ben Khellil', 'بن خليل'),
(282, 9, 'Souhane', 'سوحان'),
(283, 9, 'Meftah', 'المفتاح'),
(284, 9, 'Guerrouaou', 'قروواو'),
(285, 9, 'Ain Romana', 'عين الرمانة'),
(286, 9, 'Bougara', 'بوغار'),
(287, 9, 'Beni Mered', 'بني مراد'),
(288, 9, 'Bouarfa', 'بوعرفة'),
(289, 9, 'Boufarik', 'بوفاريك'),
(290, 9, 'El Afroun', 'الأفرون'),
(291, 9, 'Oued Djer', 'وادي جر'),
(292, 9, 'Ouled Yaich', 'أولاد يعيش'),
(293, 9, 'Beni Mered', 'بني مراد'),
(294, 10, 'Bouira', 'البويرة'),
(295, 10, 'Ain Bessem', 'عين بسام'),
(296, 10, 'El Asnam', 'الأصنام'),
(297, 10, 'Guerrouma', 'قروما'),
(298, 10, 'Souk El Khemis', 'سوق الخميس'),
(299, 10, 'El Hakimia', 'الحاكمية'),
(300, 10, 'Taguedit', 'تاقديت'),
(301, 10, 'El Khabouzia', 'الخابوزية'),
(302, 10, 'Oued El Berdi', 'وادي البردي'),
(303, 10, 'Bordj Okhriss', 'برج أخريص'),
(304, 10, 'El Adjiba', 'العجيبة'),
(305, 10, 'El Esnam', 'الأصنام'),
(306, 10, 'Dirah', 'ديرة'),
(307, 10, 'Ain Laloui', 'عين لالوي'),
(308, 10, 'Chorfa', 'الشرفاء'),
(309, 10, 'Bouderbala', 'بودربالة'),
(310, 10, 'Haizer', 'هيزر'),
(311, 10, 'Kadiria', 'قادرية'),
(312, 10, 'Maala', 'معلى'),
(313, 10, 'Taghzout', 'تاغزوت'),
(314, 10, 'Ridane', 'ريدان'),
(315, 10, 'Beni Korsi', 'بني كرسي'),
(316, 10, 'Hadjera Zerga', 'حجرة الزرقاء'),
(317, 10, 'Aghbalou', 'أغبالو'),
(318, 10, 'Ahl El Kseur', 'أهل القصر'),
(319, 10, 'Mchedallah', 'مشدالة'),
(320, 10, 'Saharidj', 'صحاريج'),
(321, 10, 'Maalou', 'معلو'),
(322, 10, 'Bechloul', 'بشلول'),
(323, 10, 'Bir Ghbalou', 'بئر غبالو'),
(324, 10, 'M Chedallah', 'مشدالة'),
(325, 10, 'Draa El Diss', 'ضرع الديس'),
(326, 10, 'Ait Laaziz', 'آيت لعزيز'),
(327, 10, 'Aomar', 'عمار'),
(328, 10, 'Oued Lakhdhar', 'وادي الأخضر'),
(329, 10, 'Lakhdaria', 'الأخضرية'),
(330, 10, 'Sour El Ghouzlane', 'سور الغزلان'),
(331, 10, 'Zbarbar', 'زبار'),
(332, 10, 'Kherbouche', 'خربوشة'),
(333, 10, 'Mezdour', 'مزدور'),
(334, 10, 'El Hachimia', 'الهاشمية'),
(335, 10, 'Ath Mansour', 'آث منصور'),
(336, 10, 'Ouled Rached', 'أولاد راشد'),
(337, 10, 'Dechmia', 'الدشمية'),
(338, 10, 'Ain El Hadjar', 'عين الحجر'),
(339, 10, 'Haniff', 'حنيف'),
(340, 10, 'Maamora', 'معمورة'),
(341, 10, 'Boukram', 'بوكرام'),
(342, 10, 'Ain Touila', 'عين توتة'),
(343, 11, 'Tamanrasset', 'تمنراست'),
(344, 11, 'Abalessa', 'أبالسة'),
(345, 11, 'In Ghar', 'إن قار'),
(346, 11, 'In Guezzam', 'إن قزام'),
(347, 11, 'Tazrouk', 'تازروك'),
(348, 11, 'Tin Zaouatine', 'تين زواتين'),
(349, 11, 'Idless', 'إيدلس'),
(350, 11, 'Ain Salah', 'عين صالح'),
(351, 11, 'Ain Guezzam', 'عين قزام'),
(352, 11, 'Foggaret Ez Zoua', 'فقارة الزوى'),
(353, 12, 'Tébessa', 'تبسة'),
(354, 12, 'Bir El Ater', 'بئر العاتر'),
(355, 12, 'Cheria', 'الشريعة'),
(356, 12, 'Ain Zerga', 'عين الزرقاء'),
(357, 12, 'El Ogla', 'العقلة'),
(358, 12, 'Morsott', 'المرصاط'),
(359, 12, 'El Malabiod', 'الملابيض'),
(360, 12, 'Oum Ali', 'أم علي'),
(361, 12, 'Bir Dheheb', 'بئر الذهب'),
(362, 12, 'Negrine', 'نقرين'),
(363, 12, 'Bekkaria', 'البكارية'),
(364, 12, 'Boukhadra', 'بوخضرة'),
(365, 12, 'Ouenza', 'وانزة'),
(366, 12, 'El Houidjbet', 'الحويجبات'),
(367, 12, 'El Ogla El Malha', 'العقلة الملحاء'),
(368, 12, 'Safsaf El Ouesra', 'صفصاف الوسرة'),
(369, 12, 'El Meridj', 'المريج'),
(370, 12, 'Thlidjene', 'ثليجان'),
(371, 12, 'Hammamet', 'حمامات'),
(372, 12, 'El Kouif', 'الكويف'),
(373, 12, 'Tébessa', 'تبسة'),
(374, 12, 'Ain Chennacheune', 'عين شنشان'),
(375, 13, 'Tlemcen', 'تلمسان'),
(376, 13, 'Beni Mester', 'بني مستار'),
(377, 13, 'Aïn Tallout', 'عين تالوت'),
(378, 13, 'Remchi', 'الرمشي'),
(379, 13, 'El Fehoul', 'الفحول'),
(380, 13, 'Sebdou', 'سبدو'),
(381, 13, 'Beni Snous', 'بني سنوس'),
(382, 13, 'Beni Boussaid', 'بني بوسعيد'),
(383, 13, 'Ain Ghoraba', 'عين الغرابة'),
(384, 13, 'Chetouane', 'شتوان'),
(385, 13, 'Mansourah', 'المنصورة'),
(386, 13, 'Béni Semiel', 'بني سميل'),
(387, 13, 'Amieur', 'عميور'),
(388, 13, 'Ain Youcef', 'عين يوسف'),
(389, 13, 'Zidoune', 'زيدون'),
(390, 13, 'Fellaoucene', 'فلاوسن'),
(391, 13, 'Azails', 'عزايل'),
(392, 13, 'Beni Ouarsous', 'بني وارسوس'),
(393, 13, 'Sidi Medjahed', 'سيدي المجاهد'),
(394, 13, 'Beni Khellad', 'بني خلاد'),
(395, 13, 'Ain Nehala', 'عين النهالة'),
(396, 13, 'Ghazaouet', 'الغزوات'),
(397, 13, 'Souahlia', 'صواحلية'),
(398, 13, 'Msirda Fouaga', 'مسيردة الفواقة'),
(399, 13, 'Ain Ferroukh', 'عين فروخة'),
(400, 13, 'Bab El Assa', 'باب العسة'),
(401, 13, 'Dar Yaghmouracen', 'دار يغمراسن'),
(402, 13, 'Ain Kebira', 'عين الكبيرة'),
(403, 13, 'Nedroma', 'ندرومة'),
(404, 13, 'El Gor', 'الغور'),
(405, 13, 'Honaïne', 'هنين'),
(406, 13, 'Tienet', 'تيانت'),
(407, 13, 'Oued Chouly', 'وادي الشولي'),
(408, 13, 'Ain Bouzekri', 'عين بوزكري'),
(409, 13, 'El Aricha', 'العريشة'),
(410, 13, 'Souk Tleta', 'سوق الثلاثاء'),
(411, 13, 'Sidi Abdelli', 'سيدي عبدلي'),
(412, 13, 'Sebaa Chioukh', 'سبعة شيوخ'),
(413, 13, 'Oued Issem', 'وادي الإسم'),
(414, 13, 'Bensekrane', 'بن سكران'),
(415, 13, 'El Bouihi', 'البويهي'),
(416, 13, 'Hammam Boughrara', 'حمام بوغرارة'),
(417, 13, 'Sidi Djillali', 'سيدي جيلالي'),
(418, 13, 'Beni Bahdel', 'بني بهدل'),
(419, 13, 'Ouled Riyah', 'أولاد رياح'),
(420, 13, 'Terny Beni Hdiel', 'ترني بني هديل'),
(421, 13, 'Zenata', 'زناتة'),
(422, 13, 'Ain Fezza', 'عين فزة'),
(423, 13, 'Ouled Mimoun', 'أولاد ميمون'),
(424, 14, 'Tiaret', 'تيارت'),
(425, 14, 'Mehdia', 'مهدية'),
(426, 14, 'Ain Dheb', 'عين الذهب'),
(427, 14, 'Rahouia', 'راهوية'),
(428, 14, 'Medroussa', 'مدروسة'),
(429, 14, 'Hamadia', 'حمادية'),
(430, 14, 'Ain Kermes', 'عين كرمس'),
(431, 14, 'Ksar Chellala', 'قصر الشلالة'),
(432, 14, 'Mellakou', 'ملاكو'),
(433, 14, 'Dahmouni', 'دحموني'),
(434, 14, 'Oued Lilli', 'وادي ليلي'),
(435, 14, 'Mahia', 'ماهية'),
(436, 14, 'Sidi Hosni', 'سيدي حسني'),
(437, 14, 'Djillali Ben Amar', 'جيلالي بن عمار'),
(438, 14, 'Frenda', 'فرندة'),
(439, 14, 'Ain El Hadid', 'عين الحديد'),
(440, 14, 'Ouled Djellal', 'أولاد جلال'),
(441, 14, 'Nadorah', 'النادور'),
(442, 14, 'Guertoufa', 'قرطوفة'),
(443, 14, 'Sidi Ali Mellal', 'سيدي علي ملال'),
(444, 14, 'Meghila', 'مغيلة'),
(445, 14, 'Rechaiga', 'رشايقة'),
(446, 14, 'Naima', 'نعيمة'),
(447, 14, 'Serghine', 'سرغين'),
(448, 14, 'El Hamadna', 'الحمادنة'),
(449, 14, 'Ain El Hadid', 'عين الحديد'),
(450, 14, 'Tagdempt', 'تاقدمت'),
(451, 14, 'Takhemaret', 'تاخمرت'),
(452, 14, 'Zmalet El Emir Abdelkader', 'زمالة الأمير عبد القادر'),
(453, 14, 'Sougueur', 'سوقر'),
(454, 14, 'Sidi Bakhti', 'سيدي بختي'),
(455, 14, 'Sebaine', 'سبعين'),
(456, 14, 'Ain Bouchekif', 'عين بوشقيف'),
(457, 14, 'Sidi Abderrahmane', 'سيدي عبد الرحمان'),
(458, 14, 'Medrissa', 'مدريسة'),
(459, 14, 'Bougara', 'بوغار'),
(460, 14, 'Aïn Zarit', 'عين زاريت'),
(461, 14, 'Beni Djaad', 'بني جعاد'),
(462, 14, 'Sebaïne', 'سبعين'),
(463, 14, 'Tousnina', 'توسنينة'),
(464, 14, 'Rosfa', 'روسفة'),
(465, 14, 'Faidja', 'فيضة'),
(466, 14, 'Chehaima', 'الشهيمة'),
(467, 15, 'Tizi Ouzou', 'تيزي وزو'),
(468, 15, 'Aïn El Hammam', 'عين الحمام'),
(469, 15, 'Akbil', 'أقبيل'),
(470, 15, 'Ait Agouacha', 'آيت أقواش'),
(471, 15, 'Beni Douala', 'بني دوالة'),
(472, 15, 'Beni Zmenzer', 'بني زمنزر'),
(473, 15, 'Iferhounene', 'إيفرحونان'),
(474, 15, 'Yatafen', 'يطافن'),
(475, 15, 'Beni Yenni', 'بني يني'),
(476, 15, 'Ain Zaouia', 'عين الزاوية'),
(477, 15, 'Tizi Rached', 'تيزي راشد'),
(478, 15, 'Bouzeguene', 'بوزقن'),
(479, 15, 'Illoula Oumalou', 'إيلولة أومالو'),
(480, 15, 'Ait Boumahdi', 'آيت بومهدي'),
(481, 15, 'Ouadhias', 'الواضية'),
(482, 15, 'Ait Yahia', 'آيت يحيى'),
(483, 15, 'Ait Yahia Moussa', 'آيت يحيى موسى'),
(484, 15, 'Ait Mahmoud', 'آيت محمود'),
(485, 15, 'Maatkas', 'معاتقة'),
(486, 15, 'Ait Bouyoucef', 'آيت بو يوسف'),
(487, 15, 'Ait Toudert', 'آيت تودرت'),
(488, 15, 'Abi Youcef', 'آبي يوسف'),
(489, 15, 'Tala Ata', 'تالة عطة'),
(490, 15, 'Boghni', 'بوغني'),
(491, 15, 'Frikat', 'فريقات'),
(492, 15, 'Assi Youcef', 'عيسى يوسف'),
(493, 15, 'Aghribs', 'أغريب'),
(494, 15, 'Iflissen', 'إيفليسن'),
(495, 15, 'Timizart', 'تيميزارت'),
(496, 15, 'Sidi Naamane', 'سيدي نعمان'),
(497, 15, 'Azzazga', 'عزازقة'),
(498, 15, 'Semaoune', 'سماعن'),
(499, 15, 'Freha', 'فريحة'),
(500, 15, 'Tigzirt', 'تيقزيرت'),
(501, 15, 'Dra El Mizan', 'ذراع الميزان'),
(502, 15, 'Ouguenoun', 'أوقنون'),
(503, 15, 'Tizi Ghennif', 'تيزي غنيف'),
(504, 15, 'Ait Oumalou', 'آيت أومالو'),
(505, 15, 'Iboudraren', 'إيبودرارن'),
(506, 15, 'Irdjen', 'إيردجن'),
(507, 15, 'Tirourda', 'تيرورة'),
(508, 15, 'Akerrou', 'أكرو'),
(509, 15, 'Zekri', 'زكري'),
(510, 15, 'Larbaa Nath Irathen', 'الأربعاء ناث إيراثن'),
(511, 15, 'Tizi Rached', 'تيزي راشد'),
(512, 15, 'Ait Khelili', 'آيت خليلي'),
(513, 15, 'Souk El Tnine Ait El Hadj', 'سوق الإثنين آيت الحاج'),
(514, 15, 'Ait Ouacifs', 'آيت واسيف'),
(515, 15, 'Souamaa', 'سواماع'),
(516, 15, 'Ait Aggouacha', 'آيت أقواش'),
(517, 15, 'Mekla', 'مكلى'),
(518, 15, 'Ouaguenoun', 'أوقنون'),
(519, 15, 'Ait Chafaa', 'آيت شفعة'),
(520, 15, 'Imsouhel', 'إيمسوحل'),
(521, 15, 'Beni Aissi', 'بني عيسى'),
(522, 15, 'Beni Ziki', 'بني زيكي'),
(523, 15, 'Sidi Naâmane', 'سيدي نعمان'),
(524, 15, 'Draa Ben Khedda', 'ذراع بن خدة'),
(525, 15, 'Souk El Djemaa', 'سوق الجمعة'),
(526, 15, 'Tirmitine', 'تيرميتين'),
(527, 15, 'Makouda', 'مقودة'),
(528, 15, 'Douaouda', 'دواودة'),
(529, 15, 'Redjaouna', 'رجاونة'),
(530, 15, 'Tadmaït', 'تادمايت'),
(531, 16, 'Alger Centre', 'الجزائر الوسطى'),
(532, 16, 'Sidi M Hamed', 'سيدي امحمد'),
(533, 16, 'El Madania', 'المدنية'),
(534, 16, 'Belouizdad', 'بلوزداد'),
(535, 16, 'Bab El Oued', 'باب الوادي'),
(536, 16, 'Bologhine', 'بولوغين'),
(537, 16, 'Casbah', 'القصبة'),
(538, 16, 'Oued Koriche', 'وادي قريش'),
(539, 16, 'Bir Mourad Rais', 'بئر مراد رايس'),
(540, 16, 'El Biar', 'البيار'),
(541, 16, 'Bouzareah', 'بوزريعة'),
(542, 16, 'Birkhadem', 'بئر خادم'),
(543, 16, 'El Harrach', 'الحراش'),
(544, 16, 'Baraki', 'براقي'),
(545, 16, 'Oued Smar', 'وادي سمار'),
(546, 16, 'Bachdjerrah', 'باش جراح'),
(547, 16, 'Hussein Dey', 'حسين داي'),
(548, 16, 'Kouba', 'كوبا'),
(549, 16, 'Bourouba', 'بروبة'),
(550, 16, 'Dar El Beida', 'دار البيضاء'),
(551, 16, 'Bab Ezzouar', 'باب الزوار'),
(552, 16, 'Ben Aknoun', 'بن عكنون'),
(553, 16, 'Dely Ibrahim', 'دالي إبراهيم'),
(554, 16, 'Hammamet', 'حمامات'),
(555, 16, 'Raïs Hamidou', 'رايس حميدو'),
(556, 16, 'Djasr El Maarouf', 'جسر المعروف'),
(557, 16, 'Mohammadia', 'المحمدية'),
(558, 16, 'Bordj El Bahri', 'برج البحري'),
(559, 16, 'El Marsa', 'المرسى'),
(560, 16, 'Ain Taya', 'عين طاية'),
(561, 16, 'Bordj El Kiffan', 'برج الكيفان'),
(562, 16, 'El Magharia', 'المقرية'),
(563, 16, 'Birkhadem', 'بئر خادم'),
(564, 16, 'El Mouradia', 'المرادية'),
(565, 16, 'Hydra', 'حيدرة'),
(566, 16, 'Mossapeau', 'موسابو'),
(567, 16, 'Bains Romains', 'الحمامات الرومانية'),
(568, 16, 'Cheraga', 'الشراقة'),
(569, 16, 'Ain Benian', 'عين بنيان'),
(570, 16, 'Staoueli', 'الصطاولي'),
(571, 16, 'Zeralda', 'زرالدة'),
(572, 16, 'Mahelma', 'ماهلمة'),
(573, 16, 'Rahmania', 'الرحمانية'),
(574, 16, 'Souidania', 'الصويدانية'),
(575, 16, 'Ouled Fayet', 'أولاد فايت'),
(576, 16, 'Draria', 'الدرارية'),
(577, 16, 'El Achour', 'الأشور'),
(578, 16, 'Tessala El Merdja', 'تسالة المرجة'),
(579, 16, 'Sidi Moussa', 'سيدي موسى'),
(580, 16, 'Ain Taya', 'عين طاية'),
(581, 16, 'Rouiba', 'الرويبة'),
(582, 16, 'Reghaïa', 'الرغاية'),
(583, 16, 'Ain El Benian', 'عين البنيان'),
(584, 16, 'Douera', 'دويرة'),
(585, 16, 'Birtouta', 'بئر توتة'),
(586, 16, 'Tessala El Merdja', 'تسالة المرجة'),
(587, 17, 'Djelfa', 'الجلفة'),
(588, 17, 'Moudjbara', 'موجبارة'),
(589, 17, 'El Idrissia', 'الإدريسية'),
(590, 17, 'Aïn El Ibel', 'عين البيل'),
(591, 17, 'Charef', 'الشارف'),
(592, 17, 'Birine', 'بيرين'),
(593, 17, 'Bouira Lahdeb', 'بويرة الأحداب'),
(594, 17, 'Zaccar', 'زكار'),
(595, 17, 'El Guedid', 'الجديد'),
(596, 17, 'Hassi El Euch', 'حاسي العش'),
(597, 17, 'Messaad', 'مسعد'),
(598, 17, 'Guernini', 'الغرنيني'),
(599, 17, 'Selmana', 'سلمانة'),
(600, 17, 'Ain Oussara', 'عين وسارة'),
(601, 17, 'Benhar', 'بنهار'),
(602, 17, 'El Malah', 'الملح'),
(603, 17, 'El Hassi', 'الحاسي'),
(604, 17, 'Douis', 'دويس'),
(605, 17, 'Dar Chioukh', 'دار شيوخ'),
(606, 17, 'Chouileh', 'الشويلح'),
(607, 17, 'El Khemis', 'الخميس'),
(608, 17, 'Beni Yacoub', 'بني يعقوب'),
(609, 17, 'Guettara', 'قطارة'),
(610, 17, 'Sidi Baizid', 'سيدي بيزيد'),
(611, 17, 'Leksour', 'القصور'),
(612, 17, 'Faidh El Botma', 'فيض البطمة'),
(613, 17, 'Bordj Ain Naâm', 'برج عين النعام'),
(614, 17, 'Ain El Maabed', 'عين المعابد'),
(615, 17, 'Had Sahary', 'الحد الصحاري'),
(616, 17, 'Zaâfrane', 'الزعفران'),
(617, 17, 'Boukhezana', 'بوخزانة'),
(618, 17, 'Hassi Fedoul', 'حاسي فدول'),
(619, 17, 'Aïn Chouhada', 'عين الشهداء'),
(620, 17, 'Oum Laadham', 'أم الأذهام'),
(621, 17, 'Znaghia', 'الزناغية'),
(622, 17, 'Sidi Ladjel', 'سيدي لجدل'),
(623, 17, 'Hassi El Euch', 'حاسي العش'),
(624, 17, 'El Idrissia', 'الإدريسية'),
(625, 17, 'M Liliha', 'مليلحة'),
(626, 17, 'Ain Feka', 'عين فكة'),
(627, 17, 'Deldoul', 'دلدول'),
(628, 17, 'Ain Oussera', 'عين وسارة'),
(629, 18, 'Jijel', 'جيجل'),
(630, 18, 'Erraguene', 'الراقنة'),
(631, 18, 'El Aouana', 'العوانة'),
(632, 18, 'Ziama Mansouriah', 'ضيامة منصورية'),
(633, 18, 'Taher', 'الطاهير'),
(634, 18, 'Emir Abdelkader', 'الأمير عبد القادر'),
(635, 18, 'Chahna', 'الشحنة'),
(636, 18, 'El Milia', 'الميلية'),
(637, 18, 'Sidi Maarouf', 'سيدي معروف'),
(638, 18, 'Settara', 'الستارة'),
(639, 18, 'El Ancer', 'العنصر'),
(640, 18, 'Ouled Yahia Khadrouch', 'أولاد يحيى خدروش'),
(641, 18, 'Boudriaa Ben Yadjis', 'بودريعة بن يعجيس'),
(642, 18, 'Kaous', 'قاوس'),
(643, 18, 'Ghebala', 'الغبالة'),
(644, 18, 'Boussif Ouled Askeur', 'بوسيف أولاد عسكر'),
(645, 18, 'El Aouana', 'العوانة'),
(646, 18, 'Djimla', 'جيملة'),
(647, 18, 'Selma Benziada', 'سلمى بن زيادة'),
(648, 18, 'Bordj T Har', 'برج الطهر'),
(649, 18, 'Texenna', 'تاكسنة'),
(650, 18, 'Djimla', 'جيملة'),
(651, 18, 'Ouled Rabah', 'أولاد رباح'),
(652, 18, 'Ain Makhlouf', 'عين مخلوف'),
(653, 18, 'Ain Soltane', 'عين السلطان'),
(654, 18, 'El Kennar Nouchfi', 'القنار نوشفي'),
(655, 18, 'Ouled Sidi Abdelaziz', 'أولاد سيدي عبد العزيز'),
(656, 18, 'Sidi Abdelaziz', 'سيدي عبد العزيز'),
(657, 19, 'Sétif', 'سطيف'),
(658, 19, 'Ain El Kebira', 'عين الكبيرة'),
(659, 19, 'Ain Arnat', 'عين أرنات'),
(660, 19, 'El Eulma', 'العلمة'),
(661, 19, 'Ain Azel', 'عين آزال'),
(662, 19, 'Guidjel', 'ڤيجل'),
(663, 19, 'Ain Oulmane', 'عين ولمان'),
(664, 19, 'Guenzet', 'قنزت'),
(665, 19, 'Ain El Hdjar', 'عين الحجر'),
(666, 19, 'Amoucha', 'عموشة'),
(667, 19, 'Babor', 'بابور'),
(668, 19, 'Bougaa', 'بوقاعة'),
(669, 19, 'Bir El Arch', 'بئر العرش'),
(670, 19, 'Bouandas', 'بوعنداس'),
(671, 19, 'Beni Aziz', 'بني عزيز'),
(672, 19, 'Beni Chebana', 'بني شبانة'),
(673, 19, 'Beni Ourtilane', 'بني ورتيلان'),
(674, 19, 'Beni Mouhli', 'بني موحلي'),
(675, 19, 'Boutaleb', 'بوطالب'),
(676, 19, 'Bir Haddada', 'بئر حدادة'),
(677, 19, 'Dehamcha', 'الدهامشة'),
(678, 19, 'Djemila', 'جميلة'),
(679, 19, 'El Ouldja', 'الولجة'),
(680, 19, 'Talaifacene', 'تالايفاسن'),
(681, 19, 'Tachouda', 'تاشودة'),
(682, 19, 'Hammam Sokhna', 'حمام السخنة'),
(683, 19, 'Hammam Guergour', 'حمام ڤرڤور'),
(684, 19, 'Harbil', 'حربيل'),
(685, 19, 'Hamma', 'الحمة'),
(686, 19, 'Ksar El Abtal', 'قصر الأبطال'),
(687, 19, 'Maaouia', 'معاوية'),
(688, 19, 'Mezloug', 'مزلوق'),
(689, 19, 'Ouled Addouane', 'أولاد عدوان'),
(690, 19, 'Ouled Si Ahmed', 'أولاد سي أحمد'),
(691, 19, 'Ouled Tebben', 'أولاد تبن'),
(692, 19, 'Ras El Oued', 'رأس الوادي'),
(693, 19, 'Salah Bey', 'صالح باي'),
(694, 19, 'Tala Ifacen', 'تالا إيفاسن'),
(695, 19, 'Taya', 'الطاية'),
(696, 19, 'Tizi N Bechar', 'تيزي نبشار'),
(697, 19, 'El Tlelat', 'التلات'),
(698, 19, 'Zit El Batel', 'زيت الباطل'),
(699, 19, 'Ain Legradj', 'عين لقراج'),
(700, 19, 'Ain Sebt', 'عين السبت'),
(701, 19, 'Beidha Bordj', 'البيضاء برج'),
(702, 19, 'Belaa', 'بلعاء'),
(703, 19, 'Oued Bared', 'وادي البارد'),
(704, 19, 'Ain Roua', 'عين الروى'),
(705, 19, 'Draa Kebila', 'ضرع القبيلة'),
(706, 19, 'Guellal', 'قلال'),
(707, 19, 'Bousselam', 'بوسلام'),
(708, 19, 'Bir El Arch', 'بئر العرش'),
(709, 19, 'Aïn Lahdjar', 'عين الحجر'),
(710, 19, 'Oued El Bared', 'وادي البارد'),
(711, 19, 'El Ouricia', 'الأوريسية'),
(712, 20, 'Saïda', 'سعيدة'),
(713, 20, 'Aïn El Hadjar', 'عين الحجر'),
(714, 20, 'Ouled Khaled', 'أولاد خالد'),
(715, 20, 'Moulay Larbi', 'مولاي العربي'),
(716, 20, 'Doui Thabet', 'ضوي ثابت'),
(717, 20, 'Sidi Boubekeur', 'سيدي بوبكر'),
(718, 20, 'El Hassasna', 'الحساسنة'),
(719, 20, 'Maamora', 'معمورة'),
(720, 20, 'Hadj Mechri', 'حاج مشري'),
(721, 20, 'Youb', 'يوب'),
(722, 20, 'Tircine', 'تيرسين'),
(723, 20, 'Ain Skhouna', 'عين السخونة'),
(724, 20, 'Sidi Amar', 'سيدي عمار'),
(725, 20, 'Ouled Brahim', 'أولاد إبراهيم'),
(726, 20, 'Sidi Ahmed', 'سيدي أحمد'),
(727, 21, 'Skikda', 'سكيكدة'),
(728, 21, 'Ben Azzouz', 'بن عزوز'),
(729, 21, 'El Harrouch', 'الحروش'),
(730, 21, 'Zerdazas', 'الزرذازة'),
(731, 21, 'Ouled Attia', 'أولاد عطية'),
(732, 21, 'Aïn Zouit', 'عين زويت'),
(733, 21, 'El Marsa', 'المرسى'),
(734, 21, 'Tamalous', 'تمالوس'),
(735, 21, 'Kanoua', 'قنواع'),
(736, 21, 'Oum Toub', 'أم الطيوب'),
(737, 21, 'Beni Zid', 'بني زيد'),
(738, 21, 'Ramdane Djamel', 'رمضان جمال'),
(739, 21, 'Azzaba', 'عزابة'),
(740, 21, 'Salah Bouchaour', 'صالح بوشعور'),
(741, 21, 'Essebt', 'السبت'),
(742, 21, 'Ain Charchar', 'عين شرشار'),
(743, 21, 'Collo', 'القل'),
(744, 21, 'Kerkera', 'كرقرة'),
(745, 21, 'Beni Oulbane', 'بني ولبان'),
(746, 21, 'Ain Kechra', 'عين كشرة'),
(747, 21, 'Ouled Hebaba', 'أولاد حبابة'),
(748, 21, 'Sidi Mezghiche', 'سيدي مزغيش'),
(749, 21, 'Cheraia', 'الشرايع'),
(750, 21, 'Emdjez Edchich', 'أمجاز الدشيش'),
(751, 21, 'Beni Bechir', 'بني بشير'),
(752, 21, 'El Hadaiek', 'الحدائق'),
(753, 21, 'Fil Fila', 'فيل فيلة'),
(754, 21, 'Stoura', 'الستورة'),
(755, 21, 'Djendel Saadi Mohamed', 'جندل سعيد محمد'),
(756, 21, 'Oued Zhour', 'وادي الزهور'),
(757, 21, 'Hamadi Krouma', 'حمادي كرومة'),
(758, 21, 'Khennouf Sidi Goufi', 'خنوف سيدي قفي'),
(759, 21, 'Ain Bouziane', 'عين بوزيان'),
(760, 21, 'Beni Oulbane', 'بني ولبان'),
(761, 21, 'El Ghedir', 'الغدير'),
(762, 21, 'Zitouna', 'الزيتونة'),
(763, 21, 'Ouldja Boulbalout', 'الولجة بولبالوت'),
(764, 21, 'El Mecheraa', 'المشرع'),
(765, 21, 'Djaoua', 'جاوة'),
(766, 22, 'Sidi Bel Abbès', 'سيدي بلعباس'),
(767, 22, 'Tessala', 'تسالة'),
(768, 22, 'Amarnas', 'العمارنة'),
(769, 22, 'Tilmouni', 'تيلموني'),
(770, 22, 'Ain El Berd', 'عين البيرد'),
(771, 22, 'Sidi Ali Benyoub', 'سيدي علي بن يوب'),
(772, 22, 'Merine', 'مرين'),
(773, 22, 'Tenira', 'تنيرة'),
(774, 22, 'Hassi Zehana', 'حاسي زهانة'),
(775, 22, 'Mostefa Ben Brahim', 'مصطفى بن إبراهيم'),
(776, 22, 'Boudjebha El Bordj', 'بوجبهة البرج'),
(777, 22, 'Ras El Ma', 'رأس الماء'),
(778, 22, 'Sfisef', 'صفيصيف'),
(779, 22, 'Oued Sebaa', 'وادي الصبع'),
(780, 22, 'Aïn Adden', 'عين العدن'),
(781, 22, 'Marhoum', 'مرحوم'),
(782, 22, 'Moulay Slissen', 'مولاي سليسن'),
(783, 22, 'Telagh', 'تلاغ'),
(784, 22, 'Ain Tindamine', 'عين التندامين'),
(785, 22, 'Aïn Kada', 'عين قادة'),
(786, 22, 'Sidi Brahim', 'سيدي إبراهيم'),
(787, 22, 'Sidi Khaled', 'سيدي خالد'),
(788, 22, 'Sidi Chaib', 'سيدي شعيب'),
(789, 22, 'Ain Thrid', 'عين تريد'),
(790, 22, 'Badredine El Mokrani', 'بدر الدين المقراني'),
(791, 22, 'Bir El Hammam', 'بئر الحمام'),
(792, 22, 'Mezaourou', 'مزاورو'),
(793, 22, 'Oued Sebbah', 'وادي السبع'),
(794, 22, 'Redjem Demouche', 'رجم الدموش'),
(795, 22, 'Aïn Sekhouna', 'عين السخونة'),
(796, 22, 'El Hacaiba', 'الحصيبة'),
(797, 22, 'Lamtar', 'لمطار'),
(798, 22, 'Zerouala', 'الزرواله'),
(799, 22, 'Sidi Ali Boussidi', 'سيدي علي بوسيدي'),
(800, 22, 'Ben Badis', 'بن باديس'),
(801, 22, 'Boukanoun', 'بوقنون'),
(802, 22, 'Oued Taoura', 'وادي التاورة'),
(803, 22, 'Chouala', 'شوالة'),
(804, 22, 'Lehssasna', 'الحساسنة'),
(805, 22, 'Ain Trid', 'عين تريد'),
(806, 22, 'Oued Sebbah', 'وادي السبع'),
(807, 22, 'Tafessour', 'تافسور'),
(808, 22, 'Tabia', 'طابية'),
(809, 22, 'Hadjrat Ennous', 'حجرة النوس'),
(810, 22, 'Guettarnia', 'قيطارنة'),
(811, 22, 'Benachiba Chelia', 'بناشيبة شلية'),
(812, 22, 'Ain Kada', 'عين قادة'),
(813, 22, 'Ben Badis', 'بن باديس'),
(814, 22, 'Sidi Lahcene', 'سيدي لحسن'),
(815, 23, 'Annaba', 'عنابة'),
(816, 23, 'Berrahhal', 'بررحال'),
(817, 23, 'Eulma', 'العلمة'),
(818, 23, 'El Bouni', 'البوني'),
(819, 23, 'Oued El Aneb', 'وادي العنب'),
(820, 23, 'Cheurfa', 'الشرفاء'),
(821, 23, 'Seraïdi', 'سراييدي'),
(822, 23, 'Aïn Berda', 'عين بردة'),
(823, 23, 'Chetaïbi', 'شطيبي'),
(824, 23, 'Sidi Amar', 'سيدي عمار'),
(825, 23, 'El Hadjar', 'الحجار'),
(826, 23, 'Treat', 'تريعات'),
(827, 23, 'Ain El Berda', 'عين البردة'),
(828, 24, 'Guelma', 'قالمة'),
(829, 24, 'Nechmaya', 'النشماية'),
(830, 24, 'Roknia', 'ركنيان'),
(831, 24, 'Oued Zenati', 'وادي الزناتي'),
(832, 24, 'Ras El Agba', 'رأس العقبة'),
(833, 24, 'Hammam N Bails', 'حمام النبايل'),
(834, 24, 'Hammam Maskhoutine', 'حمام مسخوطين'),
(835, 24, 'Belkheir', 'بلخير'),
(836, 24, 'Héliopolis', 'هيليوبوليس'),
(837, 24, 'Ain Ben Beida', 'عين بن بيضاء'),
(838, 24, 'Khezara', 'خزارة'),
(839, 24, 'Ain Makhlouf', 'عين مخلوف'),
(840, 24, 'Oued Fragha', 'وادي فراغة'),
(841, 24, 'Bordj Sabat', 'برج سباط'),
(842, 24, 'Ain Herodj', 'عين الهيرودج'),
(843, 24, 'El Fedjoudj', 'الفجوج'),
(844, 24, 'Bou Hachana', 'بوحشانة'),
(845, 24, 'Medjez Amar', 'مجاز عمار'),
(846, 24, 'Medjez Sfa', 'مجاز الصفاء'),
(847, 24, 'Bouchegouf', 'بوشقوف'),
(848, 24, 'Ain Sandel', 'عين الصندل'),
(849, 24, 'Beni Mezline', 'بني مزلين'),
(850, 24, 'Rebaou', 'الربعاوي'),
(851, 24, 'Tama', 'تامة'),
(852, 24, 'Sellaoua Announa', 'سلاوة عنونة'),
(853, 24, 'Ain Ben Beida', 'عين بن بيضاء'),
(854, 24, 'Oued Cheham', 'وادي الشاهم'),
(855, 24, 'Ain Reggada', 'عين رقادة'),
(856, 24, 'Bouati Mahmoud', 'بواطي محمود'),
(857, 24, 'Dahouara', 'الضواهرة'),
(858, 24, 'Ben Djerrah', 'بن جراح'),
(859, 24, 'Boumahra Ahmed', 'بومهرة أحمد'),
(860, 25, 'Constantine', 'قسنطينة'),
(861, 25, 'El Khroub', 'الخروب'),
(862, 25, 'Ain Abid', 'عين عبيد'),
(863, 25, 'Zighoud Youcef', 'زيغود يوسف'),
(864, 25, 'Beni Hamidane', 'بني حميدان'),
(865, 25, 'Ouled Rahmoune', 'أولاد رحمون'),
(866, 25, 'Ain Smara', 'عين سمارة'),
(867, 25, 'Hamma Bouziane', 'حامة بوزيان'),
(868, 25, 'Ibn Badis', 'ابن باديس'),
(869, 25, 'Didouche Mourad', 'ديدوش مراد'),
(870, 25, 'El Hamma', 'الحمة'),
(871, 25, 'Beni Mehenna', 'بني مهنة');

-- --------------------------------------------------------

--
-- Structure de la table `daily_journal`
--

CREATE TABLE `daily_journal` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `entry_date` date NOT NULL,
  `mood` tinyint(4) DEFAULT NULL,
  `feel_text` text DEFAULT NULL,
  `bp` varchar(20) DEFAULT NULL,
  `sugar` varchar(20) DEFAULT NULL,
  `heart_rate` varchar(20) DEFAULT NULL,
  `temperature` varchar(10) DEFAULT NULL,
  `spo2` varchar(10) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `symptoms` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`symptoms`)),
  `pain_level` tinyint(4) DEFAULT 0,
  `medication` varchar(10) DEFAULT NULL,
  `sleep_hours` tinyint(4) DEFAULT NULL,
  `sleep_quality` varchar(20) DEFAULT NULL,
  `water_cups` tinyint(4) DEFAULT 0,
  `activity` varchar(20) DEFAULT NULL,
  `nutrition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`nutrition`)),
  `notes` text DEFAULT NULL,
  `health_score` tinyint(4) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `daily_journal`
--

INSERT INTO `daily_journal` (`id`, `user_id`, `entry_date`, `mood`, `feel_text`, `bp`, `sugar`, `heart_rate`, `temperature`, `spo2`, `weight`, `symptoms`, `pain_level`, `medication`, `sleep_hours`, `sleep_quality`, `water_cups`, `activity`, `nutrition`, `notes`, `health_score`, `created_at`, `updated_at`) VALUES
(1, 62, '2026-05-02', 5, 'good', '80', '100', '70', '37', '98', '70', '[]', 0, 'yes', 9, 'excellent', 5, 'medium', '[]', 'good', 90, '2026-05-02 16:41:37', '2026-05-02 18:39:54'),
(2, 76, '2026-05-02', 5, '', '', '', '', '', '', '', '[]', 0, 'yes', 7, 'excellent', 4, 'low', '[]', '', 95, '2026-05-02 18:20:56', '2026-05-02 18:20:56'),
(3, 62, '2026-05-03', 5, '', '80', '80', '60', '37', '90', '60', '[]', 4, 'late', 7, 'good', 5, 'medium', '[]', '', 70, '2026-05-03 14:00:07', '2026-05-03 14:00:07'),
(4, 62, '2026-05-05', 3, '', '30', '90', '60', '36', '70', '60', '[]', 3, 'late', 7, 'fair', 5, 'low', '[]', '', 52, '2026-05-05 01:48:51', '2026-05-05 02:02:13'),
(5, 76, '2026-05-05', 5, '', '', '', '', '', '', '', '[]', 0, 'late', 9, 'excellent', 3, 'low', '[]', '', 82, '2026-05-05 13:28:09', '2026-05-05 13:28:09'),
(6, 62, '2026-05-06', 5, '', '90', '00', '72', '36', '50', '60', '[]', 4, 'late', 17, 'good', 5, 'medium', '[]', '', 37, '2026-05-06 22:04:44', '2026-05-06 22:04:44');

-- --------------------------------------------------------

--
-- Structure de la table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `license_number` varchar(20) DEFAULT NULL,
  `workplace` varchar(150) DEFAULT NULL,
  `is_profile_complete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `specialty_id` int(11) DEFAULT NULL,
  `experience` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `doctors`
--

INSERT INTO `doctors` (`id`, `user_id`, `license_number`, `workplace`, `is_profile_complete`, `created_at`, `lat`, `lng`, `wilaya`, `commune`, `specialty`, `specialty_id`, `experience`) VALUES
(15, 64, '1001', 'amarna clinic', 1, '2026-03-30 15:44:42', 35.1345, -0.6234, 'Sidi Bel Abbes', 'Amarnas', 'طب عام', NULL, 0),
(16, 65, '1002', 'amarna clinic', 1, '2026-03-30 15:44:42', 35.135, -0.624, 'Sidi Bel Abbes', 'Amarnas', 'طب عام', NULL, 0),
(17, 66, '1003', 'amarna clinic', 1, '2026-03-30 15:44:42', 35.136, -0.625, 'Sidi Bel Abbes', 'Amarnas', 'جلدية', NULL, 0),
(18, 67, '1004', 'sba clinic', 1, '2026-03-30 15:44:42', 35.189, -0.638, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'أمراض القلب', NULL, 0),
(19, 68, '1005', 'sba clinic', 1, '2026-03-30 15:44:42', 35.19, -0.639, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'أطفال', NULL, 0),
(20, 69, '1006', 'sba clinic', 1, '2026-03-30 15:44:42', 35.191, -0.64, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'طب عام', NULL, 0),
(33, 72, '3002', 'clinic B', 1, '2026-04-05 14:55:41', 35.3, -0.61, 'Sidi Bel Abbes', 'Sidi Bel Abbes', NULL, NULL, 0),
(34, 73, '3003', 'clinic C', 1, '2026-04-05 14:55:41', 35.4, -0.62, 'Sidi Bel Abbes', 'Sidi Bel Abbes', NULL, NULL, 0),
(47, 71, '9001', 'Test Clinic', 1, '2026-04-05 15:09:44', 35.2, -0.6, 'Sidi Bel Abbes', 'Sidi Bel Abbes', NULL, NULL, 0),
(48, 75, '0909', 'sba', 1, '2026-04-19 14:25:22', 0, 0, NULL, NULL, 'cardiologue', NULL, 0),
(49, 76, '09090', 'sidi bel abbess', 1, '2026-04-19 16:02:35', 0, 0, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'أمراض النساء والتوليد', NULL, 2),
(50, 80, '54645454', 'sba', 1, '2026-05-05 14:03:14', 0, 0, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'طب عام', NULL, 0),
(51, 81, '3456', 'sidi bel abbess', 1, '2026-05-06 12:01:06', 35.20585685186316, -0.6264937525962126, NULL, NULL, 'genicologue', NULL, 0),
(54, 85, NULL, NULL, 0, '2026-05-06 15:32:34', NULL, NULL, NULL, NULL, NULL, NULL, 0),
(55, 87, '8765', 'sidi bel abbess', 1, '2026-05-10 11:25:11', 0, 0, NULL, NULL, 'طب عام', NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `donors`
--

CREATE TABLE `donors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL,
  `blood_type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `donors`
--

INSERT INTO `donors` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`, `blood_type`) VALUES
(1, 'Donneur Karim', 35.1896, -0.631, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'A+'),
(2, 'Donneuse Sara', 35.1915, -0.6348, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'O+'),
(3, 'Donneur Amarnas', 35.1535, -0.7018, 'Sidi Bel Abbes', 'Amarnas', 'B+'),
(4, 'Donneuse Sidi Lahcene', 35.2048, -0.6865, 'Sidi Bel Abbes', 'Sidi Lahcene', 'AB+'),
(5, 'Donneur Yacine', 35.1878, -0.6288, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'O-'),
(6, 'Donneur Ahmed', 35.1901, -0.631, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'A+'),
(7, 'Donneuse Lina', 35.192, -0.633, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'O+'),
(8, 'Donneur Samir', 35.1945, -0.6355, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'B+'),
(9, 'Donneur Amarnas 2', 35.154, -0.702, 'Sidi Bel Abbes', 'Amarnas', 'A-'),
(10, 'Donneuse Amel', 35.156, -0.704, 'Sidi Bel Abbes', 'Amarnas', 'O-'),
(11, 'Donneur Lahcene 2', 35.206, -0.687, 'Sidi Bel Abbes', 'Sidi Lahcene', 'AB+'),
(12, 'Donneuse Ikram', 35.208, -0.689, 'Sidi Bel Abbes', 'Sidi Lahcene', 'B-'),
(13, 'Donneur Yacine 2', 35.187, -0.627, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'O+'),
(14, 'Donneuse Sara 2', 35.1895, -0.629, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'A+'),
(15, 'Donneur Karim 2', 35.191, -0.6305, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'AB-');

-- --------------------------------------------------------

--
-- Structure de la table `elderly`
--

CREATE TABLE `elderly` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `elderly`
--

INSERT INTO `elderly` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Dar El Ajaza El Amal', 35.1897, -0.6322, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Maison des Seniors SBA', 35.1916, -0.6359, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Dar El Ajaza Amarnas', 35.1542, -0.7012, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Dar El Ajaza Sidi Lahcene', 35.2045, -0.6858, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Centre Rahma Seniors', 35.1886, -0.6293, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Dar El Ihsane Seniors', 35.1908, -0.6332, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Maison Rahma Elders', 35.1925, -0.6378, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Centre El Baraka Seniors', 35.1872, -0.6289, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Dar El Wafa Amarnas', 35.1548, -0.7015, 'Sidi Bel Abbes', 'Amarnas'),
(10, 'Maison El Noor Sidi Lahcene', 35.2058, -0.6865, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(11, 'Centre Karam Seniors', 35.1889, -0.6295, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(12, 'Dar El Amal 2', 35.1913, -0.6341, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(13, 'Maison Hikma Seniors', 35.193, -0.6362, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `labs`
--

CREATE TABLE `labs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `labs`
--

INSERT INTO `labs` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Laboratoire El Fajr', 35.19, -0.6315, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Laboratoire Analyse Plus', 35.1928, -0.6372, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Lab Amarnas', 35.152, -0.7005, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Lab Sidi Lahcene', 35.205, -0.686, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Laboratoire Centrale', 35.1884, -0.6297, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Laboratoire El Hayat', 35.2001, -0.6401, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Laboratoire Ibn Rochd', 35.1985, -0.632, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Laboratoire El Amal Plus', 35.1902, -0.6205, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Lab BioTest', 35.21, -0.65, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(10, 'Laboratoire El Chifa Plus', 35.18, -0.61, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(11, 'Laboratoire Rahma', 35.15, -0.7, 'Sidi Bel Abbes', 'Amarnas'),
(12, 'Lab Amarnas Plus', 35.1555, -0.705, 'Sidi Bel Abbes', 'Amarnas'),
(13, 'Laboratoire Sidi Lahcene Plus', 35.2055, -0.69, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(14, 'Lab El Nour', 35.207, -0.695, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(15, 'Laboratoire Médical El Wafa', 35.17, -0.66, 'Sidi Bel Abbes', 'Sfisef'),
(16, 'Lab Analyse Moderne', 35.175, -0.665, 'Sidi Bel Abbes', 'Sfisef'),
(17, 'Laboratoire Central Plus', 35.185, -0.63, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(18, 'Lab Diagnostic Pro', 35.188, -0.635, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(19, 'Laboratoire BioLab', 35.192, -0.638, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `medical_records`
--

CREATE TABLE `medical_records` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `birth_info` varchar(255) DEFAULT NULL,
  `marital_status` varchar(100) DEFAULT NULL,
  `job` varchar(150) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `reason_exam` text DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `blood_pressure` varchar(50) DEFAULT NULL,
  `blood_sugar` varchar(50) DEFAULT NULL,
  `heart_rate` varchar(50) DEFAULT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `oxygen_level` varchar(50) DEFAULT NULL,
  `chronic_patient` text DEFAULT NULL,
  `chronic_family` text DEFAULT NULL,
  `medical_tests` text DEFAULT NULL,
  `radiology` text DEFAULT NULL,
  `prescription` text DEFAULT NULL,
  `next_appointment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `next_appointment_date` date DEFAULT NULL,
  `next_appointment_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `medical_records`
--

INSERT INTO `medical_records` (`id`, `patient_id`, `doctor_id`, `full_name`, `birth_info`, `marital_status`, `job`, `address`, `phone`, `reason_exam`, `symptoms`, `blood_pressure`, `blood_sugar`, `heart_rate`, `temperature`, `oxygen_level`, `chronic_patient`, `chronic_family`, `medical_tests`, `radiology`, `prescription`, `next_appointment`, `created_at`, `updated_at`, `next_appointment_date`, `next_appointment_time`) VALUES
(1, 76, 76, 'najet', '11\\04\\2004', 'hkgxwd', 'edd', 'edt456', '554322', 'fffffffff', 'mla/r3', '67', '00', '476', '49', '4fwg', 'frwq', 'ggg', 'fewfg', 'k.jv', 'efhjhgv', 'fewkjhvj', '2026-05-07 16:51:39', '2026-05-07 16:51:39', NULL, NULL),
(2, 0, 76, 'Nadjet Hakem', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'yes', '2026-05-09 17:00:22', '2026-05-09 17:00:22', '2026-08-10', '00:00:00'),
(3, 0, 76, 'عبدالصمد سلس زهيرة', '', '', '', 'تجزئة رقم 952 بلولادي سيدي بلعباس', '', '', '', '', '', '', '', '', '', '', '', '', '', 'yes', '2026-05-09 17:08:41', '2026-05-09 17:08:41', '2026-05-10', '03:03:00'),
(4, 0, 76, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'yes', '2026-05-09 23:28:42', '2026-05-09 23:28:42', '2026-11-11', '22:22:00'),
(5, 0, 76, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'yes', '2026-05-09 23:30:29', '2026-05-09 23:30:29', '2026-09-09', '08:08:00'),
(6, 0, 49, 'Nadjet Hakem', '11/04/2004', 'celebataire', 'etudiant', '', '', '', '', '098', '', '33', '37', '', '', '', '', '', '', 'yes', '2026-05-09 23:59:57', '2026-05-09 23:59:57', '2026-05-30', '03:03:00'),
(7, 0, 50, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'no', '2026-05-10 01:15:29', '2026-05-10 01:15:29', '0000-00-00', '00:00:00'),
(8, 0, 49, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'no', '2026-05-10 12:23:49', '2026-05-10 12:23:49', '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `is_read`, `created_at`) VALUES
(1, 76, '📅 تم تحديد موعدك يوم 2026-02-02 على الساعة 02:00', 0, '2026-04-19 22:58:46'),
(2, 76, '📅 تم تحديد موعدك يوم 0111-01-11 على الساعة 00:00', 0, '2026-04-19 23:04:49'),
(3, 76, '📅 موعد مع د.  \r\n🗓️ يوم 2026-04-19 \r\n🕐 على الساعة 03:00', 0, '2026-04-19 23:11:14'),
(4, 76, '📅 موعد مع د.  \r\n🗓️ يوم 2026-05-06 \r\n🕐 على الساعة 02:03', 0, '2026-04-19 23:11:46'),
(5, 76, '📅 موعد مع د. kheira \r\n🗓️ يوم 2026-05-06 \r\n🕐 على الساعة 04:00', 0, '2026-04-19 23:16:41'),
(6, 76, '📅 موعد مع د. kheira \r\n🗓️ يوم 2026-04-20 \r\n🕐 على الساعة 08:00', 0, '2026-04-19 23:18:47'),
(7, 76, '📅 موعد طبي\r\n🩺 مع د. kheira\r\n📅 يوم 2026-04-19\r\n⏰ على الساعة 00:00', 0, '2026-04-19 23:24:19'),
(8, 76, '📅 موعد طبي\r\n🩺 مع د. kheira\r\n📅 يوم 2026-05-06\r\n⏰ على الساعة 04:44', 0, '2026-04-19 23:25:04'),
(9, 76, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-05-06 \r\n🕐 على الساعة 03:03', 0, '2026-04-19 23:26:23'),
(10, 77, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-02-02 \r\n🕐 على الساعة 22:02', 0, '2026-04-19 23:32:27'),
(11, 76, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-04-04 \r\n🕐 على الساعة 04:04', 0, '2026-04-19 23:57:13'),
(12, 77, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-03-03 \r\n🕐 على الساعة 22:02', 0, '2026-04-20 00:04:29'),
(13, 62, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-07-07 \r\n🕐 على الساعة 09:00', 0, '2026-04-20 12:32:22'),
(14, 76, '  🩺 موعد مع د. kheira \r\n🗓️ يوم 2026-09-09 \r\n🕐 على الساعة 08:00', 0, '2026-04-20 12:34:12'),
(15, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/07/2026\n🕐 على الساعة 08:00', 0, '2026-05-06 22:49:14'),
(16, 80, '📅 تم تأكيد موعدك\n🩺 مع د. bennourcheikh\n🗓️ يوم 11/11/1111\n🕐 على الساعة 11:11', 0, '2026-05-06 23:12:12'),
(17, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 03/03/3333\n🕐 على الساعة 03:03', 0, '2026-05-06 23:24:02'),
(18, 80, '📅 تم تأكيد موعدك\n🩺 مع د. bennourcheikh\n🗓️ يوم 01/09/0099\n🕐 على الساعة 00:00', 0, '2026-05-06 23:48:18'),
(19, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 11/11/2026\n🕐 على الساعة 12:00', 0, '2026-05-07 13:02:11'),
(20, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 19:00', 0, '2026-05-07 14:45:30'),
(21, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 08/06/2026\n🕐 على الساعة 20:00', 0, '2026-05-07 14:51:10'),
(22, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 09:00', 0, '2026-05-07 14:52:44'),
(23, 86, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 08/05/2026\n🕐 على الساعة 09:00', 0, '2026-05-07 15:28:16'),
(24, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 09:00', 0, '2026-05-07 15:45:33'),
(25, 62, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 03:03', 0, '2026-05-07 16:05:57'),
(26, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 04:00', 0, '2026-05-07 16:12:49'),
(27, 76, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-05-08 على الساعة 04:04', 0, '2026-05-07 16:13:21'),
(28, 76, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-05-05 على الساعة 05:05', 0, '2026-05-07 16:26:12'),
(29, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 07/05/2026\n🕐 على الساعة 04:04', 0, '2026-05-07 16:31:18'),
(30, 76, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-10-05 على الساعة 04:04', 0, '2026-05-07 16:31:51'),
(31, 76, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-08-08 على الساعة 04:04', 0, '2026-05-07 16:32:36'),
(32, 76, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-05-07 على الساعة 08:08', 0, '2026-05-07 16:35:16'),
(33, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 09/05/2026\n🕐 على الساعة 10:00', 0, '2026-05-09 14:34:33'),
(34, 62, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 22:02', 0, '2026-05-09 23:27:41'),
(35, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 22:02', 0, '2026-05-09 23:29:56'),
(36, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 22:02', 0, '2026-05-09 23:37:04'),
(37, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 03:03', 0, '2026-05-09 23:43:17'),
(38, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 22:02', 0, '2026-05-09 23:46:11'),
(39, 80, '📅 تم تأكيد موعدك\n🩺 مع د. bennourcheikh\n🗓️ يوم 03/06/2026\n🕐 على الساعة 22:02', 0, '2026-05-10 01:14:45'),
(40, 80, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-05-10 على الساعة 22:02', 0, '2026-05-10 01:15:10'),
(41, 62, '📅 تم تأكيد موعدك\n🩺 مع د. nadjet\n🗓️ يوم 10/05/2026\n🕐 على الساعة 08:00', 0, '2026-05-10 11:28:51'),
(42, 87, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 07:07', 0, '2026-05-10 11:31:04'),
(43, 76, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 10/05/2026\n🕐 على الساعة 08:08', 0, '2026-05-10 11:33:15'),
(44, 0, '🔄 تم إعادة برمجة موعدك إلى يوم 2026-05-11 على الساعة 22:02', 0, '2026-05-10 22:57:46'),
(45, 62, '📅 تم تأكيد موعدك\n🩺 مع د. kheira\n🗓️ يوم 11/05/2026\n🕐 على الساعة 22:02', 0, '2026-05-10 22:59:11');

-- --------------------------------------------------------

--
-- Structure de la table `nurses`
--

CREATE TABLE `nurses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `nurses`
--

INSERT INTO `nurses` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Infirmier Ahmed', 35.1888, -0.632, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Infirmière Salma', 35.191, -0.636, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Infirmier Amarnas', 35.154, -0.701, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Infirmière Sidi Lahcene', 35.2042, -0.6855, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Soins à Domicile Nour', 35.1875, -0.6275, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'ممرض محمد بن علي', 35.1901, -0.6301, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'ممرضة فاطمة الزهراء', 35.192, -0.635, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'ممرض أحمد قاسمي', 35.185, -0.62, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'ممرضة سمية بوعلام', 35.188, -0.64, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(10, 'ممرض عبد القادر', 35.195, -0.645, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(11, 'ممرض إلياس عمار', 35.15, -0.7, 'Sidi Bel Abbes', 'Amarnas'),
(12, 'ممرضة نوال زروقي', 35.152, -0.705, 'Sidi Bel Abbes', 'Amarnas'),
(13, 'ممرض حسين شارف', 35.205, -0.69, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(14, 'ممرضة هاجر بن سالم', 35.207, -0.695, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(15, 'ممرض رشيد بوعزة', 35.17, -0.66, 'Sidi Bel Abbes', 'Sfisef'),
(16, 'ممرضة خديجة بن يحي', 35.175, -0.665, 'Sidi Bel Abbes', 'Sfisef'),
(17, 'ممرض نور الدين', 35.18, -0.625, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(18, 'ممرضة أمينة قادري', 35.182, -0.628, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(19, 'ممرض يوسف مهدي', 35.184, -0.632, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `orphans`
--

CREATE TABLE `orphans` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `orphans`
--

INSERT INTO `orphans` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Dar El Aytam El Nour', 35.1902, -0.6312, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Maison Enfance Heureuse', 35.1921, -0.6365, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Dar El Aytam Amarnas', 35.1532, -0.7009, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Dar El Aytam Sidi Lahcene', 35.205, -0.6862, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Centre Kafala Enfants', 35.1874, -0.6278, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Dar El Atfal El Amal', 35.191, -0.6335, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Maison Enfance Plus', 35.1928, -0.6368, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Centre Rahma Orphelins', 35.1885, -0.6288, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Dar El Atfal Amarnas 2', 35.1549, -0.7018, 'Sidi Bel Abbes', 'Amarnas'),
(10, 'Maison Nour Sidi Lahcene', 35.2056, -0.6869, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(11, 'Centre Kafala Plus', 35.1878, -0.6275, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(12, 'Dar El Baraka Orphelins', 35.1907, -0.6342, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(13, 'Maison Hikma Enfants', 35.1933, -0.6361, 'Sidi Bel Abbes', 'Sidi Bel Abbes');

-- --------------------------------------------------------

--
-- Structure de la table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `blood_type` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `height` varchar(20) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `chronic_diseases` text DEFAULT NULL,
  `allergies` text DEFAULT NULL,
  `medications` text DEFAULT NULL,
  `health_notes` text DEFAULT NULL,
  `emergency_name` varchar(100) DEFAULT NULL,
  `emergency_phone` varchar(30) DEFAULT NULL,
  `medical_completed` tinyint(1) DEFAULT 0,
  `emergency_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `patients`
--

INSERT INTO `patients` (`id`, `user_id`, `age`, `gender`, `blood_type`, `created_at`, `first_name`, `last_name`, `birth_date`, `height`, `weight`, `phone`, `chronic_diseases`, `allergies`, `medications`, `health_notes`, `emergency_name`, `emergency_phone`, `medical_completed`, `emergency_token`) VALUES
(3, 46, NULL, NULL, NULL, '2026-03-05 09:52:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'a258f35fae877f7e2c75304bdef62ed1'),
(15, 61, NULL, NULL, NULL, '2026-03-12 11:22:58', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'e858c833e59f086d54a6368e5f01c929'),
(16, 62, NULL, NULL, NULL, '2026-03-29 17:30:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0cf8f4d7a429a0e319fb44cfd6564138'),
(18, 78, NULL, NULL, NULL, '2026-04-23 05:46:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '4c9f95e689900dec8ae12748d270ba36'),
(19, 79, NULL, NULL, NULL, '2026-04-30 11:23:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(21, 86, NULL, NULL, NULL, '2026-05-07 15:26:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `pharmacies`
--

CREATE TABLE `pharmacies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pharmacies`
--

INSERT INTO `pharmacies` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`) VALUES
(1, 'Pharmacie El Amal', 35.1891, -0.6305, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(2, 'Pharmacie Ibn Sina', 35.1912, -0.635, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(3, 'Pharmacie Amarnas Centre', 35.153, -0.702, 'Sidi Bel Abbes', 'Amarnas'),
(4, 'Pharmacie Sidi Lahcene 1', 35.2035, -0.684, 'Sidi Bel Abbes', 'Sidi Lahcene'),
(5, 'Pharmacie El Chifa', 35.187, -0.628, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(6, 'Pharmacie El Nour', 35.189, -0.63, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(7, 'Pharmacie El Chifa 2', 35.195, -0.64, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(8, 'Pharmacie Ibn Rochd', 35.2, -0.62, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(9, 'Pharmacie El Baraka', 35.18, -0.615, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(10, 'Pharmacie El Amal 2', 35.178, -0.625, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(11, 'Pharmacie El Hikma', 35.182, -0.635, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(12, 'Pharmacie Centrale SBA', 35.188, -0.645, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(13, 'Pharmacie Rahma', 35.192, -0.65, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(14, 'Pharmacie El Fajr 2', 35.185, -0.655, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(15, 'Pharmacie El Wifak', 35.19, -0.66, 'Sidi Bel Abbes', 'Sidi Bel Abbes'),
(16, 'Pharmacie Amarnas 2', 35.153, -0.702, 'Sidi Bel Abbes', 'Amarnas'),
(17, 'Pharmacie Sidi Lahcene 2', 35.203, -0.684, 'Sidi Bel Abbes', 'Sidi Lahcene');

-- --------------------------------------------------------

--
-- Structure de la table `pregnancy_cards`
--

CREATE TABLE `pregnancy_cards` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `last_period_date` date DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `blood_type` varchar(10) DEFAULT NULL,
  `pregnancies_count` int(11) DEFAULT 0,
  `births_count` int(11) DEFAULT 0,
  `miscarriages_count` int(11) DEFAULT 0,
  `c_sections_count` int(11) DEFAULT 0,
  `chronic_diseases` text DEFAULT NULL,
  `father_status` varchar(255) DEFAULT NULL,
  `consanguinity` enum('yes','no') DEFAULT 'no',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pregnancy_followups`
--

CREATE TABLE `pregnancy_followups` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `blood_pressure` varchar(50) DEFAULT NULL,
  `sugar_level` varchar(50) DEFAULT NULL,
  `fetal_heartbeat` varchar(50) DEFAULT NULL,
  `fetal_movement` varchar(255) DEFAULT NULL,
  `fetal_weight` varchar(50) DEFAULT NULL,
  `fetal_position` varchar(100) DEFAULT NULL,
  `echo_notes` text DEFAULT NULL,
  `doctor_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_name` varchar(255) NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `doctor_address` varchar(255) DEFAULT NULL,
  `rx_date` date NOT NULL,
  `medicines` text NOT NULL,
  `notes` text DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `patient_id`, `doctor_id`, `patient_name`, `doctor_name`, `doctor_address`, `rx_date`, `medicines`, `notes`, `signature`, `created_at`) VALUES
(1, 0, 49, '', 'kheira', 'sidi bel abbess', '2026-05-09', '', '', 'kheira', '2026-05-09 15:52:12'),
(2, 0, 49, '', 'kheira', 'sidi bel abbess', '2026-05-09', '', '', 'kheira', '2026-05-09 15:52:36'),
(3, 0, 49, 'nadjet', 'kheira', 'sidi bel abbess', '2026-05-09', 'paracetamol\r\ndoleprane', 'apres \r\n2 fois', 'Dr. kheira', '2026-05-09 16:00:48'),
(4, 0, 49, 'nadjet', 'kheira', 'sidi bel abbess', '2026-05-09', 'paracetamol', '2 fois\r\napres', 'Dr. kheira', '2026-05-09 16:04:15'),
(5, 0, 49, 'nadjet', 'kheira', 'sidi bel abbess', '2026-05-09', 'duliprane', '7fois', 'Dr. kheira', '2026-05-09 16:07:40'),
(6, 0, 49, 'nadjet', 'kheira', 'sidi bel abbess', '2026-05-09', 'duliprane', '7fois', 'Dr. kheira', '2026-05-09 16:09:44'),
(7, 0, 49, 'nadjet', 'kheira', 'sidi bel abbess', '2026-05-09', 'duliprane\r\nCNb;igr\r\nfangi\r\nFAJW', '7fois\r\n9FOIS PARE JOUER', 'Dr. kheira', '2026-05-09 16:10:07');

-- --------------------------------------------------------

--
-- Structure de la table `specialties`
--

CREATE TABLE `specialties` (
  `id` int(11) NOT NULL,
  `name_fr` varchar(100) NOT NULL,
  `name_ar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `specialties`
--

INSERT INTO `specialties` (`id`, `name_fr`, `name_ar`) VALUES
(1, 'general', 'طب عام'),
(2, 'cardiology', 'أمراض القلب'),
(3, 'gastroenterology', 'أمراض الجهاز الهضمي'),
(4, 'pediatrics', 'طب الأطفال'),
(5, 'gynecology', 'أمراض النساء والتوليد'),
(6, 'dermatology', 'أمراض الجلد'),
(7, 'ophthalmology', 'طب العيون'),
(8, 'ent', 'أمراض الأنف والأذن والحنجرة'),
(9, 'neurology', 'أمراض الجهاز العصبي'),
(10, 'pulmonology', 'أمراض الرئة'),
(11, 'surgery', 'الجراحة العامة'),
(12, 'orthopedics', 'جراحة العظام'),
(13, 'dentist', 'طب الأسنان'),
(14, 'psychiatry', 'الطب النفسي'),
(15, 'endocrinology', 'الغدد الصماء والسكري'),
(16, 'hematology', 'أمراض الدم'),
(17, 'emergency', 'طب الطوارئ'),
(18, 'rheumatology', 'أمراض الروماتيزم'),
(19, 'oncology', 'طب الأورام'),
(20, 'cosmetic', 'جراحة تجميلية'),
(21, 'sports', 'طب الرياضة'),
(22, 'anesthesia', 'التخدير'),
(23, 'radiology', 'الأشعة الطبية');

-- --------------------------------------------------------

--
-- Structure de la table `sport_health`
--

CREATE TABLE `sport_health` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `wilaya` varchar(100) DEFAULT NULL,
  `commune` varchar(100) DEFAULT NULL,
  `sub_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sport_health`
--

INSERT INTO `sport_health` (`id`, `name`, `lat`, `lng`, `wilaya`, `commune`, `sub_type`) VALUES
(1, 'Centre Santé & Sport 1', 35.189, -0.63, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'nutrition'),
(2, 'Fitness Santé Plus', 35.192, -0.6362, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'sport'),
(3, 'Salle Sport Amarnas', 35.1538, -0.7015, 'Sidi Bel Abbes', 'Amarnas', 'sport'),
(4, 'Club Santé Sidi Lahcene', 35.204, -0.685, 'Sidi Bel Abbes', 'Sidi Lahcene', 'nutrition'),
(5, 'Vital Sport SBA', 35.1882, -0.6285, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'sport'),
(6, 'Nutrition Center SBA', 35.19, -0.63, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'nutrition'),
(7, 'Healthy Life Clinic', 35.195, -0.64, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'nutrition'),
(8, 'Diet Pro Center', 35.2, -0.65, 'Sidi Bel Abbes', 'Amarnas', 'nutrition'),
(9, 'Gym Power House', 35.205, -0.66, 'Sidi Bel Abbes', 'Sidi Bel Abbes', 'sport'),
(10, 'Fitness Club Pro', 35.21, -0.67, 'Sidi Bel Abbes', 'Amarnas', 'sport'),
(11, 'Iron Gym SBA', 35.215, -0.68, 'Sidi Bel Abbes', 'Sidi Lahcene', 'sport');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('doctor','patient','nurse','pharmacy','clinic','donor','lab') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reset_otp` varchar(10) DEFAULT NULL,
  `otp_expire` datetime DEFAULT NULL,
  `otp_attempts` int(11) DEFAULT 0,
  `twofa_secret` varchar(255) DEFAULT NULL,
  `twofa_enabled` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password_hash`, `role`, `created_at`, `reset_otp`, `otp_expire`, `otp_attempts`, `twofa_secret`, `twofa_enabled`) VALUES
(1, 'Test Patient', NULL, 'TEMP_PASSWORD', 'patient', '2026-02-10 18:42:58', NULL, NULL, 0, NULL, 0),
(46, 'kheira', 'linasonia224@gmail.com', '$2y$10$ECYlLYSoOh4J.vALLpVMPubZ7t/Hc6gvhpLLXGB5nHOfn3lJpgJXS', 'patient', '2026-03-05 09:52:18', NULL, NULL, 0, NULL, 0),
(61, 'najet', 'robinnajet@gmail.com', '$2y$10$46eiQtN7mEuzvd.XG3.05ug2YPUL4q/hEMBKllR4n62KsokNmQ2Ta', 'patient', '2026-03-12 11:22:58', NULL, NULL, 0, 'HI7MUVGAK2XHRM24', 0),
(62, 'nino', 'tppaw401@gmail.com', '$2y$10$SKPsesAUR21bsR..32.y2OnLBxjws/Wj/lQDysz/nbe1dN5.0QeSq', 'patient', '2026-03-29 17:30:30', NULL, NULL, 0, '74ZQRBBOZAKRHCFT', 0),
(64, 'د. أمين بوعلام', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(65, 'د. سارة منصوري', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(66, 'د. ياسين قادري', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(67, 'د. مريم بوقرة', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(68, 'د. هاجر زروقي', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(69, 'د. كريم بن عطية', NULL, '', 'doctor', '2026-03-30 15:43:10', NULL, NULL, 0, NULL, 0),
(71, 'د. جديد 1', 'doc1@test.com', '123', 'doctor', '2026-04-05 14:54:55', NULL, NULL, 0, NULL, 0),
(72, 'د. جديد 2', 'doc2@test.com', '123', 'doctor', '2026-04-05 14:54:55', NULL, NULL, 0, NULL, 0),
(73, 'د. جديد 3', 'doc3@test.com', '123', 'doctor', '2026-04-05 14:54:55', NULL, NULL, 0, NULL, 0),
(74, 'د. طب عام بلعباس', 'doc_sba@test.com', '123', 'doctor', '2026-04-05 15:02:37', NULL, NULL, 0, NULL, 0),
(75, 'nadjet', 'hinanadjet@gmail.com', '$2y$10$fIRIzXTLIGouXAYdA63mIuqSg3woKNG07WpiXf4iytsyMYjUfVF4O', 'doctor', '2026-04-19 14:25:22', NULL, NULL, 0, '7WWEAOLG6SHH7HM7', 0),
(76, 'kheira', 'jfalkhyrt@gmail.com', '$2y$10$O4v3IZezMojTbyn/ScTUcuucYLkIy3F8f8vNImaKMLRRD7MQ4S3mG', 'doctor', '2026-04-19 16:02:35', NULL, NULL, 0, 'TI6HEN45P4B4HVGE', 0),
(78, 'najet', 'informatiquechat@gmail.com', '$2y$10$5DSUiY6SrlcuSc47OfHg1utIZUIcfdn05qy98rFzc/KJdYZku0xOG', 'patient', '2026-04-23 05:46:02', NULL, NULL, 0, 'AHXU6YPSKSOZTWFE', 0),
(79, 'Nadjet Hakem', 'ghermaouiamina31@gmail.com', '$2y$10$u2FMhYm9hPebxDiqLyQaaOe7bYoXWDUzPXZvsEXdQo1fA2O/DEaGS', 'patient', '2026-04-30 11:23:16', NULL, NULL, 0, '7OZ6VHHQWT4IPKXD', 0),
(80, 'bennourcheikh', 'bennourcheikh.amsp@gmail.com', '$2y$10$o0IWDa6s3aUBT5u.gGoWrO.u0BtVoNZxgXtiVOkg11QhqNwW/PAHG', 'doctor', '2026-05-05 14:03:14', NULL, NULL, 0, 'CYMZNAFVELZ2YAKK', 0),
(81, 'djefal kheira', 'djefalkheira@gmail.com', '$2y$10$SJU5WizDU7n6hmh3GAXwZuKV7lIpxXMKcJk/dnzjt4Mk5jGhcluh.', 'doctor', '2026-05-06 12:01:06', NULL, NULL, 0, 'MOLM7GNPZZLBFIIJ', 0),
(85, 'Nadjet Hakem', 'nadjethakem11@gmail.com', '$2y$10$pMLgQzHBI.DgCvWG.21upORK0.SqF5kaoalyd3aA1caGUfZfmMqKC', 'doctor', '2026-05-06 15:32:34', NULL, NULL, 0, '7UXMQONFIC4425TD', 0),
(86, 'zohra', 'sirinesonia346@gmail.com', '$2y$10$N/L9n/ZGpPxdQlDf0XKoROhvXa0yeDKjidoevDMhDztYEhI9RkoHC', 'patient', '2026-05-07 15:26:45', NULL, NULL, 0, '7HDAIREJBLZYQZ66', 0),
(87, 'nadjet', 'hakemnadjet11@gmail.com', '$2y$10$ctQK0sgInsVh3UEy/jIoQuP40trr0Zb2bsNEapSwajymBQpkWiEKK', 'doctor', '2026-05-10 11:25:11', NULL, NULL, 0, 'CQHZYBJHYPZ5HK6X', 0);

-- --------------------------------------------------------

--
-- Structure de la table `wilayas`
--

CREATE TABLE `wilayas` (
  `id` int(11) NOT NULL,
  `name_fr` varchar(100) NOT NULL,
  `name_ar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `wilayas`
--

INSERT INTO `wilayas` (`id`, `name_fr`, `name_ar`) VALUES
(1, 'Adrar', 'أدرار'),
(2, 'Chlef', 'الشلف'),
(3, 'Laghouat', 'الأغواط'),
(4, 'Oum El Bouaghi', 'أم البواقي'),
(5, 'Batna', 'باتنة'),
(6, 'Bejaia', 'بجاية'),
(7, 'Biskra', 'بسكرة'),
(8, 'Bechar', 'بشار'),
(9, 'Blida', 'البليدة'),
(10, 'Bouira', 'البويرة'),
(11, 'Tamanrasset', 'تمنراست'),
(12, 'Tebessa', 'تبسة'),
(13, 'Tlemcen', 'تلمسان'),
(14, 'Tiaret', 'تيارت'),
(15, 'Tizi Ouzou', 'تيزي وزو'),
(16, 'Alger', 'الجزائر'),
(17, 'Djelfa', 'الجلفة'),
(18, 'Jijel', 'جيجل'),
(19, 'Setif', 'سطيف'),
(20, 'Saida', 'سعيدة'),
(21, 'Skikda', 'سكيكدة'),
(22, 'Sidi Bel Abbes', 'سيدي بلعباس'),
(23, 'Annaba', 'عنابة'),
(24, 'Guelma', 'قالمة'),
(25, 'Constantine', 'قسنطينة'),
(26, 'Medea', 'المدية'),
(27, 'Mostaganem', 'مستغانم'),
(28, 'Msila', 'المسيلة'),
(29, 'Mascara', 'معسكر'),
(30, 'Ouargla', 'ورقلة'),
(31, 'Oran', 'وهران'),
(32, 'El Bayadh', 'البيض'),
(33, 'Illizi', 'إليزي'),
(34, 'Bordj Bou Arreridj', 'برج بوعريريج'),
(35, 'Boumerdes', 'بومرداس'),
(36, 'El Tarf', 'الطارف'),
(37, 'Tindouf', 'تندوف'),
(38, 'Tissemsilt', 'تيسمسيلت'),
(39, 'El Oued', 'الوادي'),
(40, 'Khenchela', 'خنشلة'),
(41, 'Souk Ahras', 'سوق أهراس'),
(42, 'Tipaza', 'تيبازة'),
(43, 'Mila', 'ميلة'),
(44, 'Ain Defla', 'عين الدفلى'),
(45, 'Naama', 'النعامة'),
(46, 'Ain Temouchent', 'عين تموشنت'),
(47, 'Ghardaia', 'غرداية'),
(48, 'Relizane', 'غليزان'),
(49, 'Timimoun', 'تيميمون'),
(50, 'Bordj Badji Mokhtar', 'برج باجي مختار'),
(51, 'Ouled Djellal', 'أولاد جلال'),
(52, 'Beni Abbes', 'بني عباس'),
(53, 'In Salah', 'عين صالح'),
(54, 'In Guezzam', 'عين قزام'),
(55, 'Touggourt', 'تقرت'),
(56, 'Djanet', 'جانت'),
(57, 'El Meghaier', 'المغير'),
(58, 'El Meniaa', 'المنيعة'),
(59, 'Aflou', 'أفلو'),
(60, 'Barika', 'بريكة'),
(61, 'Ksar Chellala', 'قصر الشلالة'),
(62, 'Messaad', 'مسعد'),
(63, 'Ain Oussera', 'عين وسارة'),
(64, 'Boussaada', 'بوسعادة'),
(65, 'El Abiodh Sidi Cheikh', 'الأبيض سيدي الشيخ'),
(66, 'El Kantara', 'القنطرة'),
(67, 'Bir El Ater', 'بئر العاتر'),
(68, 'Ksar El Boukhari', 'قصر البخاري'),
(69, 'El Aricha', 'العريشة');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `associations`
--
ALTER TABLE `associations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `civil_protection`
--
ALTER TABLE `civil_protection`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clinics`
--
ALTER TABLE `clinics`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `communes`
--
ALTER TABLE `communes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wilaya_id` (`wilaya_id`);

--
-- Index pour la table `daily_journal`
--
ALTER TABLE `daily_journal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_date` (`user_id`,`entry_date`),
  ADD KEY `idx_user_date` (`user_id`,`entry_date`);

--
-- Index pour la table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Index pour la table `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `elderly`
--
ALTER TABLE `elderly`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `labs`
--
ALTER TABLE `labs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `medical_records`
--
ALTER TABLE `medical_records`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `nurses`
--
ALTER TABLE `nurses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orphans`
--
ALTER TABLE `orphans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Index pour la table `pharmacies`
--
ALTER TABLE `pharmacies`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pregnancy_cards`
--
ALTER TABLE `pregnancy_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `patient_id` (`patient_id`);

--
-- Index pour la table `pregnancy_followups`
--
ALTER TABLE `pregnancy_followups`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sport_health`
--
ALTER TABLE `sport_health`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `wilayas`
--
ALTER TABLE `wilayas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT pour la table `associations`
--
ALTER TABLE `associations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `civil_protection`
--
ALTER TABLE `civil_protection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `clinics`
--
ALTER TABLE `clinics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `communes`
--
ALTER TABLE `communes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=872;

--
-- AUTO_INCREMENT pour la table `daily_journal`
--
ALTER TABLE `daily_journal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT pour la table `donors`
--
ALTER TABLE `donors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `elderly`
--
ALTER TABLE `elderly`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `labs`
--
ALTER TABLE `labs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `medical_records`
--
ALTER TABLE `medical_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT pour la table `nurses`
--
ALTER TABLE `nurses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `orphans`
--
ALTER TABLE `orphans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `pharmacies`
--
ALTER TABLE `pharmacies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `pregnancy_cards`
--
ALTER TABLE `pregnancy_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pregnancy_followups`
--
ALTER TABLE `pregnancy_followups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `sport_health`
--
ALTER TABLE `sport_health`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `communes`
--
ALTER TABLE `communes`
  ADD CONSTRAINT `communes_ibfk_1` FOREIGN KEY (`wilaya_id`) REFERENCES `wilayas` (`id`);

--
-- Contraintes pour la table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `fk_doctors_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `fk_patients_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

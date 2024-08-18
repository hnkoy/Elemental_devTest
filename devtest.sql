-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Aug 18, 2024 at 05:50 PM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `devtest`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrders` ()   BEGIN
    SELECT 
        CONCAT(u.first_name, ' ', u.last_name)  AS customer,
        DATE_FORMAT(o.order_date, '%M %Y') AS order_month, o.order_date,
        GROUP_CONCAT(DISTINCT p.product ORDER BY p.product ASC SEPARATOR '<br>') AS products_bought,
        SUM(p.price) AS total_spent
    FROM 
        orders o
    JOIN 
        order_items oi ON o.id = oi.order_id
    JOIN 
        products p ON oi.product_id = p.id
    JOIN 
        statuses s ON o.order_status_id = s.id
    JOIN 
        users u ON o.user_id = u.id
    WHERE 
        s.status_name IN ('Payment received', 'Dispatched')
    
    GROUP BY 
    customer,o.order_date
    ORDER BY 
        EXTRACT(YEAR_MONTH FROM o.order_date),
        total_spent DESC,
        
    CASE 
            WHEN SUM(p.price) = SUM(p.price) THEN customer
            ELSE NULL 
        END ASC ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProducts` ()   BEGIN
SELECT COALESCE(cat.category, 'Uncategorized') AS category_name, pro.product, pro.price FROM products pro LEFT JOIN categories cat ON pro.category_id = cat.id ORDER BY category_name ASC, product ASC;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`) VALUES
(1, 'First Person Shooters'),
(2, 'Role Playing Games'),
(3, 'Real Time Strategy Games');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `order_status_id` tinyint(1) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `order_status_id`) VALUES
(1, 1, '2016-01-02', 3),
(2, 2, '2016-01-03', 3),
(3, 3, '2016-01-03', 3),
(4, 4, '2016-01-03', 3),
(5, 5, '2016-01-15', 3),
(6, 6, '2016-01-27', 3),
(7, 7, '2016-02-10', 3),
(8, 1, '2016-02-14', 3),
(9, 2, '2016-02-21', 3),
(10, 3, '2016-02-24', 4),
(11, 4, '2016-03-01', 3),
(12, 8, '2016-03-02', 3),
(13, 9, '2016-03-11', 3),
(14, 1, '2016-03-12', 3),
(15, 10, '2016-03-19', 3),
(16, 5, '2016-04-21', 4),
(17, 11, '2016-04-22', 3),
(18, 12, '2016-04-23', 3),
(19, 13, '2016-04-29', 3),
(20, 6, '2016-05-05', 3),
(21, 9, '2016-05-06', 4),
(22, 14, '2016-05-07', 3),
(23, 15, '2016-05-17', 3),
(24, 14, '2016-05-24', 3),
(25, 1, '2016-06-15', 3),
(26, 2, '2016-07-03', 4),
(27, 3, '2016-07-04', 3),
(28, 4, '2016-07-14', 3),
(29, 5, '2016-07-24', 3),
(30, 6, '2016-08-01', 3),
(31, 7, '2016-08-08', 3),
(32, 8, '2016-08-24', 3),
(33, 9, '2016-08-25', 3),
(34, 10, '2016-09-01', 3),
(35, 11, '2016-09-05', 4),
(36, 12, '2016-09-10', 3),
(37, 13, '2016-09-15', 3),
(38, 14, '2016-09-20', 3),
(39, 15, '2016-09-25', 3),
(40, 14, '2016-09-30', 3),
(41, 13, '2017-01-01', 4),
(42, 12, '2017-01-02', 3),
(43, 11, '2017-01-03', 3),
(44, 10, '2017-01-09', 3),
(45, 9, '2017-01-14', 3),
(46, 8, '2017-01-16', 3),
(47, 7, '2017-01-19', 3),
(48, 6, '2017-01-21', 3),
(49, 5, '2017-01-22', 2),
(50, 4, '2017-01-23', 1),
(51, 3, '2017-01-25', 1),
(52, 2, '2017-01-26', 1),
(53, 1, '2017-01-27', 2),
(54, 2, '2017-01-28', 1),
(55, 3, '2017-01-31', 3),
(56, 4, '2017-02-01', 2),
(57, 5, '2017-02-01', 1),
(58, 6, '2017-02-01', 4),
(59, 7, '2017-02-02', 1),
(60, 8, '2017-02-05', 1),
(61, 9, '2017-02-06', 2),
(62, 10, '2017-02-07', 3),
(63, 11, '2017-02-14', 4),
(64, 12, '2017-02-15', 2),
(65, 13, '2017-02-17', 3),
(66, 14, '2017-02-21', 2),
(67, 15, '2017-02-21', 2),
(68, 15, '2017-02-25', 1),
(69, 14, '2017-02-26', 2),
(70, 15, '2017-03-01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_id`, `product_id`) VALUES
(1, 1),
(1, 5),
(1, 6),
(2, 5),
(2, 6),
(2, 12),
(3, 5),
(4, 3),
(5, 10),
(6, 13),
(7, 5),
(8, 12),
(9, 1),
(10, 13),
(11, 12),
(11, 13),
(11, 14),
(12, 1),
(12, 13),
(13, 2),
(14, 3),
(15, 16),
(16, 2),
(16, 7),
(17, 5),
(18, 9),
(18, 10),
(19, 1),
(20, 2),
(21, 3),
(22, 5),
(23, 6),
(24, 4),
(25, 7),
(26, 8),
(27, 9),
(29, 10),
(30, 11),
(31, 12),
(31, 13),
(31, 14),
(32, 15),
(32, 18),
(33, 16),
(33, 17),
(34, 5),
(34, 15),
(35, 1),
(35, 5),
(35, 10),
(36, 7),
(36, 8),
(37, 5),
(38, 9),
(39, 5),
(40, 10),
(41, 12),
(42, 6),
(42, 8),
(43, 9),
(44, 9),
(45, 9),
(46, 9),
(47, 4),
(47, 5),
(48, 3),
(49, 1),
(49, 10),
(49, 11),
(49, 15),
(50, 11),
(51, 12),
(52, 13),
(53, 12),
(54, 18),
(55, 17),
(56, 16),
(57, 16),
(58, 16),
(59, 14),
(60, 8),
(61, 8),
(62, 4),
(62, 11),
(63, 12),
(63, 14),
(63, 16),
(64, 10),
(64, 11),
(65, 1),
(65, 8),
(66, 6),
(67, 7),
(68, 8),
(69, 9),
(70, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `product` varchar(64) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product`, `price`, `category_id`) VALUES
(1, 'Counter-Strike: Global Offensive', 159, 1),
(2, 'Farcry Primal', 549, 1),
(3, 'Fable Anniversary', 359, 2),
(4, 'Left 4 Dead 2', 219, 1),
(5, 'DOOM', 799, 1),
(6, 'Dark Souls 3', 799, 2),
(7, 'The Witcher 3: Wild Hunt', 399.99, 2),
(8, 'The Elder scrolls V: Skyrim', 219, 2),
(9, 'Grim Dawn', 269, 2),
(10, 'Age of Empires 3: Complete Collection', 409, 3),
(11, 'Age of Mythology: Extended Edition', 319, 3),
(12, 'Rise of Nations: Extended Edition', 219, 3),
(13, 'Homeworld Remastered Collection', 359, 3),
(14, 'Command & Conquer: Red Alert 3', 219, 3),
(15, '7 Days to Die', 269, NULL),
(16, 'DayZ', 429, NULL),
(17, 'Portal Bundle', 246, NULL),
(18, 'Tales of Berseria', 757, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `id` tinyint(1) UNSIGNED NOT NULL,
  `status_name` varchar(64) DEFAULT NULL,
  `colour` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `status_name`, `colour`) VALUES
(1, 'Payment Pending', 'cccc00'),
(2, 'Payment Received', '0000cc'),
(3, 'Dispatched', '00cc00'),
(4, 'Cancelled', 'cc0000');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `address` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `address`) VALUES
(1, 'Angelena', 'Ristau', 'angelena@mail.com', '11 Test Street\r\nTest Town\r\n1654\r\n'),
(2, 'Melissia', 'Sipe', 'melissia@mail.com', '12 Test Street\r\nTest Town\r\n1654'),
(3, 'Stanford', 'Stukes', 'stanford', '13 Test Street\r\nTest Town\r\n1654'),
(4, 'Jon', 'Lirette', 'jon@mail.com', '14 Test Street\r\nTest Town\r\n1654'),
(5, 'Jacklyn', 'Wineinger', 'jacklyn@mail.com', '15 Test Street\r\nTest Town\r\n1654'),
(6, 'Rosario', 'Milnes', 'rosario@mail.com', '16 Test Street\r\nTest Town\r\n1654'),
(7, 'Arnulfo', 'Condrey', 'arnulfo@mail.com', '17 Test Street\r\nTest Town\r\n1654'),
(8, 'Etta', 'Jorgenson', 'etta@mail.com', '18 Test Street\r\nTest Town\r\n1654'),
(9, 'Olin', 'Holeman', 'olan@mail.com', '19 Test Street\r\nTest Town\r\n1654'),
(10, 'Waldo', 'Hartl', 'waldo@mail.com', '20 Test Street\r\nTest Town\r\n1654'),
(11, 'Rocky', 'Fenster', 'rocky@mail.com', '21 Test Street\r\nTest Town\r\n1654'),
(12, 'Brandon', 'Bleakley', 'brandon@mail.com', '22 Test Street\r\nTest Town\r\n1654'),
(13, 'Barney', 'Oubre', 'barney@mail.com', '23 Test Street\r\nTest Town\r\n1654'),
(14, 'Sammy', 'Gunderman', 'sammy@mail.com', '24 Test Street\r\nTest Town\r\n1654'),
(15, 'Tyron', 'Birch', 'tyron@mail.com', '25 Test Street\r\nTest Town\r\n1654');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_id`,`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
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
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` tinyint(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

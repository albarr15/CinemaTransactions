-- -----------------------------------------------------
-- Schema ctm_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS ctmdb;
CREATE SCHEMA IF NOT EXISTS ctmdb;
USE ctmdb;

-- -----------------------------------------------------
-- Table seat_type
-- -----------------------------------------------------
DROP TABLE IF EXISTS seat_type;
CREATE TABLE IF NOT EXISTS seat_type (
	seat_type		VARCHAR(45) NOT NULL,
    price			DOUBLE NOT NULL,
	PRIMARY KEY	(seat_type)
);

-- -----------------------------------------------------
-- Table cinema
-- -----------------------------------------------------
DROP TABLE IF EXISTS cinema;
CREATE TABLE IF NOT EXISTS cinema (
	cinema_num	INT(2) NOT NULL,
	cinema_type	ENUM('2D', '3D', 'IMAX') NOT NULL,
	total_seats	INT(3) NOT NULL,
	PRIMARY KEY	(cinema_num)
);

-- -----------------------------------------------------
-- Table movie
-- -----------------------------------------------------
DROP TABLE IF EXISTS movie;
CREATE TABLE IF NOT EXISTS movie (
	movie_id		VARCHAR(6) NOT NULL,
	movie_title		VARCHAR(100) NOT NULL,
	rating			ENUM('G', 'PG', 'R-13', 'R-16', 'R-18','NYR') NOT NULL,
	genre			VARCHAR(50) NOT NULL,
	director		VARCHAR(45) NOT NULL,
	actors			VARCHAR(100) NOT NULL,
	synopsis		VARCHAR(250) NOT NULL,
	movie_type		VARCHAR(20) NOT NULL,
	minutes			INT(3) NOT NULL,
	movie_status	ENUM('coming soon', 'now showing', 'deleted') NOT NULL,
	PRIMARY KEY	(movie_id)
);

-- -----------------------------------------------------
-- Table schedule
-- -----------------------------------------------------
DROP TABLE IF EXISTS sched;
CREATE TABLE IF NOT EXISTS sched (
	sched_id	VARCHAR(10) NOT NULL,
	time		TIME NOT NULL,
    date		DATE NOT NULL,
	movie_id	VARCHAR(6) NOT NULL,
	cinema_num	INT(2) NOT NULL,
    price		DOUBLE NOT NULL,
    avail_seats INT(3) NOT NULL,
	PRIMARY KEY	(sched_id),
	FOREIGN KEY	(movie_id)
	REFERENCES	movie(movie_id),
	FOREIGN KEY	(cinema_num)
	REFERENCES	cinema(cinema_num)
);

-- -----------------------------------------------------
-- Table seat
-- -----------------------------------------------------
DROP TABLE IF EXISTS seat;
CREATE TABLE IF NOT EXISTS seat (
	seat_id		INT(4) NOT NULL,
    seat_type	VARCHAR(45) NOT NULL,
    sched_id	VARCHAR(10) NOT NULL,
    seat_status	TINYINT(1) NOT NULL,
	PRIMARY KEY	(seat_id),
    FOREIGN KEY (seat_type)
		REFERENCES seat_type(seat_type),
	FOREIGN KEY (sched_id)
		REFERENCES	sched(sched_id)
);

-- -----------------------------------------------------
-- Table ticket
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticket;
CREATE TABLE IF NOT EXISTS ticket (
	ticket_id	INT(5) NOT NULL,
    sched_id	VARCHAR(10) NOT NULL,
    seat_id		INT(4) NOT NULL,
    payment_type ENUM('GCash', 'PayMaya', 'Master Card', 'Cash') NOT NULL,
    amount		DOUBLE NOT NULL,
    price		DOUBLE NOT NULL,
    pay_change	DOUBLE NOT NULL,
    pay_date	DATE NOT NULL,
    num_tickets	TINYINT(2) NOT NULL,
    
	PRIMARY KEY	(ticket_id),
    FOREIGN KEY (sched_id)
		REFERENCES sched(sched_id),
	FOREIGN KEY (seat_id)
		REFERENCES seat(seat_id)
);

-- -----------------------------------------------------
-- Add records to seat_type
-- -----------------------------------------------------
INSERT INTO	seat_type
	VALUES	('regular', 	0),
			('premium', 	100),
            ('pwd', 		-100);


-- -----------------------------------------------------
-- Add records to cinema
-- -----------------------------------------------------
INSERT INTO	cinema
	VALUES	(01, '2D', 20),
			(02, '2D', 25),
            (03, '2D', 20),
            (04, '2D', 20),
            (05, '2D', 25),
            (06, '2D', 20),
            (07, '3D', 25),
            (08, 'IMAX', 25);

-- -----------------------------------------------------
-- Add records to movie
-- -----------------------------------------------------
INSERT INTO	movie
	VALUES	('M00001', 'Five Breakups and a Romance', 'PG', 'romance',
			 'Irene Emma Villamor', 'Alden Richards, Julia Montes',
			 'Five Breakups and a Romance is a story of the complexities of romance and relationships today. This is a letter to the people who made a dent in our lives, to our “quantum entanglement”, and to the struggles and victories of love.',
			 '2D', 102, 'now showing'),
		('M00002', 'Five Nights at Freddy\'s', 'R-13', 'thriller, horror, mystery',
     'Emma Tammi', 'Josh Hutcherson, Piper Rubio, Elizabeth Lail',
     'A troubled security guard begins working at Freddy Fazbear\'s Pizza. During his first night on the job, he realizes that the night shift won\'t be so easy to get through. Pretty soon he will unveil what actually happened at Freddy\'s.',
     '2D', 109,	'now showing'),
		('M00003', 'The Marvels', 'G', 'action, fantasy, adventure',
     'Nia DaCosta',	'Brie Larson, Teyonah Parris, Iman Vellani',
     'Carol Danvers gets her powers entangled with those of Kamala Khan and Monica Rambeau, forcing them to work together to save the universe.',
     '2D, 3D', 105,	'now showing'),
		('M00004', 'The Hunger Games: The Ballad of Songbirds and Snakes', 'PG', 'drama, action, adventure',
     'Francis Lawrence', 'Tom Blyth, Rachel Zegler, Josh Andrés Rivera',
     'Coriolanus Snow mentors and develops feelings for the female District 12 tribute during the 10th Hunger Games.',
     '2D', 157,	'now showing'),
		('M00005', 'Trolls Band Together', 'G', 'comedy, adventure',
     'Walt Dohrn', 'Anna Kendrick, Justin Timberlake, Camila Cabello',
     'Poppy discovers that Branch was once part of a boy band, BroZone, with his brothers: Floyd, John Dory, Spruce, and Clay. But when Floyd is kidnapped, Branch and Poppy embark on a journey to reunite the other brothers and rescue Floyd.',
     '2D', 92, 'now showing'),
		('M00006', 'Napoleon', 'R-13', 'action, adventure, biography',
     'Ridley Scott', 'Joaquin Phoenix, Vanessa Kirby',
     'An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte and his relentless journey to power through the prism of his addictive, volatile relationship with his wife, Josephine.',
     '2D', 157,	'coming soon'),
		('M00007', 'Wish', 'G', 'comedy, adventure',
     'Chris Buck, Fawn Veerasunthorn', 'Ariana DeBose, Chris Pine, Alan Tudyk',
     'Wish will follow a young girl named Asha who wishes on a star and gets a more direct answer than she bargained for when a trouble-making star comes down from the sky to join her.',
     '2D', 95, 'now showing'),
		('M00008', 'Wonka',	'G', 'comedy, family, adventure',
     'Paul King', 'Timothée Chalamet, Calah Lane, Keegan-Michael Key',
     'The story will focus specifically on a young Willy Wonka and how he met the Oompa-Loompas on one of his earliest adventures.',
		 '2D', 116,	'coming soon');
             
-- -----------------------------------------------------
-- Add records to schedule
-- -----------------------------------------------------
INSERT INTO	sched
	VALUES	('S000000001', '12:30:00', '2023-11-18', 'M00003', 03, 350, 15),
			('S000000002', '11:00:00', '2023-11-18', 'M00004', 03, 330, 18),
			('S000000003', '14:30:00', '2023-11-19', 'M00008', 02, 350, 22),
			('S000000004', '19:15:00', '2023-11-19', 'M00003', 02, 350, 18),
			('S000000005', '16:15:00', '2023-12-02', 'M00006', 04, 300, 17),
            ('S000000006', '12:30:00', '2023-12-18', 'M00002', 03, 400, 19),
			('S000000007', '11:40:00', '2023-12-23', 'M00007', 03, 380, 20),
			('S000000008', '09:30:00', '2024-01-19', 'M00001', 02, 350, 24),
			('S000000009', '13:10:00', '2024-01-19', 'M00005', 02, 290, 25),
			('S000000010', '15:15:00', '2024-01-22', 'M00001', 04, 320, 20);
             
-- -----------------------------------------------------
-- Add records to seat
-- -----------------------------------------------------
INSERT INTO	seat
	VALUES	('1001', 'regular', 'S000000001', 1),
			('1002', 'premium', 'S000000001', 0),
			('1003', 'premium', 'S000000001', 1),
            ('1004', 'regular', 'S000000001', 1),
			('1005', 'regular', 'S000000001', 1),
			('1006', 'regular', 'S000000001', 1),
            ('1007', 'regular', 'S000000001', 0),
			('1008', 'regular', 'S000000001', 1),
			('1009', 'regular', 'S000000001', 1),
            ('1010', 'regular', 'S000000001', 0),
			('1011', 'pwd', 	 'S000000001', 1),
			('1012', 'regular', 'S000000001', 1),
            ('1013', 'pwd', 	 'S000000001', 1),
			('1014', 'pwd', 	 'S000000001', 0),
			('1015', 'pwd', 	 'S000000001', 0),
            
            ('2001', 'regular', 'S000000002', 1),
			('2002', 'regular', 'S000000002', 0),
			('2003', 'regular', 'S000000002', 1),
            ('2004', 'regular', 'S000000002', 1),
			('2005', 'regular', 'S000000002', 1),
			('2006', 'regular', 'S000000002', 1),
            ('2007', 'regular', 'S000000002', 0),
			('2008', 'regular', 'S000000002', 1),
			('2009', 'regular', 'S000000002', 1),
            ('2010', 'regular', 'S000000003', 0),
			('2011', 'regular', 'S000000002', 1),
			('2012', 'regular', 'S000000002', 1),
            ('2013', 'regular', 'S000000002', 1),
			('2014', 'regular', 'S000000003', 0),
			('2015', 'regular', 'S000000003', 0),
		
            ('3001', 'regular', 'S000000004', 0),
			('3002', 'regular', 'S000000004', 0),
			('3003', 'regular', 'S000000004', 0),
            ('3004', 'regular', 'S000000003', 1),
			('3005', 'regular', 'S000000003', 1),
			('3006', 'pwd', 	 'S000000003', 1),
            ('3007', 'pwd', 	 'S000000003', 1),
			('3008', 'pwd', 	 'S000000003', 1),
			('3009', 'pwd', 	 'S000000003', 1),
            ('3010', 'pwd', 	 'S000000003', 1),
            ('3011', 'pwd', 	 'S000000003', 1),
			('3012', 'pwd', 	 'S000000003', 1),
			('3013', 'pwd', 	 'S000000003', 1),
            ('3014', 'regular', 'S000000003', 1),
			('3015', 'regular', 'S000000003', 1),
            
            ('4001', 'regular', 'S000000005', 0),
			('4002', 'regular', 'S000000005', 0),
			('4003', 'regular', 'S000000004', 1),
            ('4004', 'premium', 'S000000004', 1),
			('4005', 'premium', 'S000000006', 0),
			('4006', 'premium', 'S000000004', 1),
            ('4007', 'regular', 'S000000004', 1),
			('4008', 'regular', 'S000000004', 1),
			('4009', 'regular', 'S000000004', 1),
            ('4010', 'regular', 'S000000004', 0),
            ('4011', 'regular', 'S000000004', 0),
			('4012', 'regular', 'S000000004', 0),
			('4013', 'regular', 'S000000004', 1),
            ('4014', 'premium', 'S000000004', 1),
			('4015', 'premium', 'S000000004', 0),
            
            ('5001', 'pwd', 	 'S000000005', 1),
			('5002', 'pwd', 	 'S000000008', 0),
			('5003', 'pwd', 	 'S000000005', 1),
            ('5004', 'pwd', 	 'S000000005', 1),
			('5005', 'pwd', 	 'S000000005', 1),
			('5006', 'pwd', 	 'S000000005', 1),
            ('5007', 'regular', 'S000000005', 1),
			('5008', 'regular', 'S000000005', 1),
			('5009', 'regular', 'S000000005', 1),
            ('5010', 'premium', 'S000000005', 1),
			('5011', 'premium', 'S000000005', 0),
			('5012', 'premium', 'S000000005', 1),
            ('5013', 'pwd', 	 'S000000005', 1),
			('5014', 'pwd', 	 'S000000005', 1),
            ('5015', 'pwd', 	 'S000000005', 1),
            
            ('6001', 'regular', 'S000000007', 1),
			('6002', 'regular', 'S000000007', 1),
			('6003', 'regular', 'S000000007', 1),
            ('6004', 'regular', 'S000000007', 1),
			('6005', 'regular', 'S000000007', 1),
			('6006', 'regular', 'S000000007', 1),
            ('6007', 'regular', 'S000000007', 1),
			('6008', 'regular', 'S000000007', 1),
			('6009', 'regular', 'S000000007', 1),
            ('6010', 'regular', 'S000000007', 1),
			('6011', 'regular', 'S000000009', 1),
			('6012', 'regular', 'S000000009', 1),
            ('6013', 'regular', 'S000000009', 1),
			('6014', 'regular', 'S000000010', 1),
			('6015', 'regular', 'S000000010', 1);
            
            
-- -----------------------------------------------------
-- Add records to ticket
-- -----------------------------------------------------
INSERT INTO ticket
	VALUES 	('40001', 'S000000001', '1002', 'Cash', 		450, 450,   0, '2023-11-17', 1),
            ('40002', 'S000000001', '1007', 'GCash', 		500, 350, 150, '2023-11-17', 1),
            ('40003', 'S000000001', '1010', 'Cash', 		400, 350,  50, '2023-11-18', 1),
            ('40004', 'S000000001', '1014', 'Cash', 		250, 250,   0, '2023-11-18', 1),
            ('40005', 'S000000001', '1015', 'Cash', 		300, 250,  50, '2023-11-18', 1),
            
			('40006', 'S000000002', '2002', 'PayMaya', 		350, 330,  20, '2023-11-18', 1),
			('40007', 'S000000002', '2007', 'Master Card',  500, 330, 170, '2023-11-18', 1),
            
            ('40008', 'S000000003', '2010', 'Cash', 		500, 350, 150, '2023-11-19', 1),
            ('40009', 'S000000003', '2014', 'Cash', 		350, 350,   0, '2023-11-19', 1),
            ('40010', 'S000000003', '2015', 'Cash', 		350, 350,   0, '2023-11-19', 1),
            
            ('40011', 'S000000004', '3001', 'Cash', 		400, 350,  50, '2023-11-19', 1),
            ('40012', 'S000000004', '3002', 'Cash', 		350, 350,   0, '2023-11-19', 1),
            ('40013', 'S000000004', '3003', 'Cash', 		350, 350,   0, '2023-11-19', 1),
            
            
            ('40014', 'S000000005', '4001', 'PayMaya', 	    300, 300,   0, 	'2023-12-02', 1),
            ('40015', 'S000000005', '4002', 'PayMaya', 	    500, 300, 200, 	'2023-12-02', 1),
            
            ('40016', 'S000000006', '4005', 'PayMaya', 	    500, 500,   0, 	'2023-12-18', 1),
            
            ('40017', 'S000000004', '4010', 'Cash', 	    350, 350,   0, 	'2023-11-19', 1),
            ('40018', 'S000000004', '4011', 'Cash', 	    350, 350,   0, 	'2023-11-19', 1),
            ('40019', 'S000000004', '4012', 'PayMaya', 	    500, 350, 150, 	'2023-11-19', 1),
            ('40020', 'S000000004', '4015', 'PayMaya', 	    500, 450,  50, 	'2023-11-19', 1),
            
            ('40021', 'S000000008', '5002', 'GCash', 		250, 250,   0,  '2024-01-19', 1),
            
            ('40022', 'S000000005', '5011', 'Cash', 	    400, 400,   0, 	'2023-12-01', 1);
            

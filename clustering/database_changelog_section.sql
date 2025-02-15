--
-- Table structure for table `advisor`
--
CREATE TABLE `advisor` (
  `student_id` varchar(5) NOT NULL,
  `advisor_id` varchar(5) DEFAULT NULL,
  `advisor_created` timestamp NOT NULL DEFAULT '2009-04-30 06:30:00',
  PRIMARY KEY (`student_id`),
  KEY `i_ID` (`advisor_id`),
  CONSTRAINT `advisor_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `instructor` (`instr_id`) ON DELETE SET NULL,
  CONSTRAINT `advisor_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE
) ;
--
-- Table structure for table `classroom`
--
CREATE TABLE `classroom` (
  `building` varchar(15) NOT NULL,
  `room_number` varchar(7) NOT NULL,
  `capacity` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`building`,`room_number`)
) ;

--
-- Table structure for table `concept`
--
CREATE TABLE `concept` (
  `ID` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` varchar(8) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ;
--
-- Table structure for table `department`
--
CREATE TABLE `department` (
  `dept_name` varchar(20) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `max_credits` int DEFAULT '90',
  PRIMARY KEY (`dept_name`)
) ;
--
-- Table structure for table `event_log`
--
CREATE TABLE `event_log` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `activity` varchar(30) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '1999-12-31 23:00:01',
  `student_id` varchar(20) DEFAULT NULL,
  `instr_id` varchar(20) DEFAULT NULL,
  `section_id` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL,
  `department_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
);
--
-- Table structure for table `instructor`
--
CREATE TABLE `instructor` (
  `instr_id` varchar(5) NOT NULL,
  `instr_name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `instr_created` timestamp NOT NULL DEFAULT '2009-04-01 06:00:00',
  PRIMARY KEY (`instr_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ;
--
-- Table structure for table `prereq`
--
CREATE TABLE `prereq` (
  `course_id` varchar(8) NOT NULL,
  `prereq_id` varchar(8) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_id` (`prereq_id`),
  CONSTRAINT `prereq_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `prereq_ibfk_2` FOREIGN KEY (`prereq_id`) REFERENCES `course` (`course_id`)
) ;
--
-- Table structure for table `section`
--
CREATE TABLE `section` (
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `room_number` varchar(7) DEFAULT NULL,
  `time_slot_id` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  KEY `building` (`building`,`room_number`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`building`, `room_number`) REFERENCES `classroom` (`building`, `room_number`) ON DELETE SET NULL,
  CONSTRAINT `section_ibfk_3` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`time_slot_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
--
-- Table structure for table `student`
--
CREATE TABLE `student` (
  `student_id` varchar(5) NOT NULL,
  `student_name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `tot_cred` decimal(3,0) DEFAULT NULL,
  `tot_cred_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `student_created` timestamp NOT NULL DEFAULT '2009-04-01 06:00:00',
  PRIMARY KEY (`student_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ;
--
-- Table structure for table `takes`
--
CREATE TABLE `takes` (
  `student_id` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `takes_created` timestamp NOT NULL DEFAULT '2010-10-01 18:30:00',
  `grade_modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE
) ;
--
-- Table structure for table `teaches`
--
CREATE TABLE `teaches` (
  `instr_id` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `teaches_created` timestamp NOT NULL DEFAULT '2009-04-01 06:00:00',
  PRIMARY KEY (`instr_id`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`instr_id`) REFERENCES `instructor` (`instr_id`) ON DELETE CASCADE
) ;
--
-- Table structure for table `time_slot`
--
CREATE TABLE `time_slot` (
  `time_slot_id` varchar(4) NOT NULL,
  `day` varchar(1) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`time_slot_id`,`day`,`start_time`)
);

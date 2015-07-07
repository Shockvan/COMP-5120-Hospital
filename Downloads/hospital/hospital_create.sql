SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`services` (
  `svcid` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`svcid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`inpatient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`inpatient` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `svcid`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`outpatient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`outpatient` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `svcid`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`nonmedical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`nonmedical` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `svcid`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`workers` (
  `wid` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`wid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`volunteers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`volunteers` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`employees` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatment_administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`treatment_administrator` (
  `tadid` INT NOT NULL,
  PRIMARY KEY (`tadid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`nurses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`nurses` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tadid`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`administrators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`administrators` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`technicians`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`technicians` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tadid`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`staff` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`doctors` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tadid`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patient` (
  `pid` INT NOT NULL,
  `policynum` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`admits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`admits` (
  `doctors_wid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `inpatient_svcid` INT NOT NULL,
  `diagnosis` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `timestamp` DATETIME NULL,
  PRIMARY KEY (`doctors_wid`, `patient_pid`, `inpatient_svcid`),
  INDEX `fk_doctors_has_patient_patient1_idx` (`patient_pid` ASC),
  INDEX `fk_doctors_has_patient_doctors1_idx` (`doctors_wid` ASC),
  INDEX `fk_admits_inpatient1_idx` (`inpatient_svcid` ASC),
  CONSTRAINT `fk_doctors_has_patient_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `hospital`.`doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctors_has_patient_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `hospital`.`patient` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admits_inpatient1`
    FOREIGN KEY (`inpatient_svcid`)
    REFERENCES `hospital`.`inpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`assigned_doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`assigned_doctors` (
  `doctors_wid` INT NOT NULL,
  `admits_doctors_wid` INT NOT NULL,
  `admits_patient_pid` INT NOT NULL,
  PRIMARY KEY (`doctors_wid`, `admits_doctors_wid`, `admits_patient_pid`),
  INDEX `fk_doctors_has_admits_admits1_idx` (`admits_doctors_wid` ASC, `admits_patient_pid` ASC),
  INDEX `fk_doctors_has_admits_doctors1_idx` (`doctors_wid` ASC),
  CONSTRAINT `fk_doctors_has_admits_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `hospital`.`doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctors_has_admits_admits1`
    FOREIGN KEY (`admits_doctors_wid` , `admits_patient_pid`)
    REFERENCES `hospital`.`admits` (`doctors_wid` , `patient_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`treatment` (
  `tid` INT NOT NULL,
  PRIMARY KEY (`tid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`medication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`medication` (
  `tid` INT NOT NULL,
  `medid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
  CONSTRAINT `tid`
    FOREIGN KEY (`tid`)
    REFERENCES `hospital`.`treatment` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`procedures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`procedures` (
  `tid` INT NOT NULL,
  `procid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
  CONSTRAINT `tid`
    FOREIGN KEY (`tid`)
    REFERENCES `hospital`.`treatment` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `doctors_wid` INT NOT NULL,
  `treatment_tid` INT NOT NULL,
  `tadid` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`order_id`, `doctors_wid`, `treatment_tid`, `tadid`),
  INDEX `fk_doctors_has_treatment_treatment1_idx` (`treatment_tid` ASC),
  INDEX `fk_doctors_has_treatment_doctors1_idx` (`doctors_wid` ASC),
  INDEX `fk_orders_treatment_administrator1_idx` (`tadid` ASC),
  CONSTRAINT `fk_doctors_has_treatment_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `hospital`.`doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctors_has_treatment_treatment1`
    FOREIGN KEY (`treatment_tid`)
    REFERENCES `hospital`.`treatment` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_treatment_administrator1`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`administered_treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`administered_treatments` (
  `order_id` INT NOT NULL,
  `timestamp` DATETIME NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `hospital`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`room` (
  `roomid` INT NOT NULL,
  PRIMARY KEY (`roomid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`room_assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`room_assignments` (
  `assignmentid` INT NOT NULL,
  `room_roomid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `administrators_wid` INT NOT NULL,
  PRIMARY KEY (`assignmentid`, `room_roomid`, `patient_pid`, `administrators_wid`),
  INDEX `fk_assigns_room1_idx` (`room_roomid` ASC),
  INDEX `fk_assigns_patient1_idx` (`patient_pid` ASC),
  INDEX `fk_assigns_administrators1_idx` (`administrators_wid` ASC),
  CONSTRAINT `fk_assigns_room1`
    FOREIGN KEY (`room_roomid`)
    REFERENCES `hospital`.`room` (`roomid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `hospital`.`patient` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `hospital`.`administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`volunteer_schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`volunteer_schedules` (
  `volunteers_wid` INT NOT NULL,
  `nonmedical_svcid` INT NOT NULL,
  `day` VARCHAR(45) NULL,
  PRIMARY KEY (`volunteers_wid`, `nonmedical_svcid`),
  INDEX `fk_volunteers_has_nonmedical_nonmedical1_idx` (`nonmedical_svcid` ASC),
  INDEX `fk_volunteers_has_nonmedical_volunteers1_idx` (`volunteers_wid` ASC),
  CONSTRAINT `fk_volunteers_has_nonmedical_volunteers1`
    FOREIGN KEY (`volunteers_wid`)
    REFERENCES `hospital`.`volunteers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteers_has_nonmedical_nonmedical1`
    FOREIGN KEY (`nonmedical_svcid`)
    REFERENCES `hospital`.`nonmedical` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`staff_assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`staff_assignments` (
  `staff_wid` INT NOT NULL,
  `nonmedical_svcid` INT NOT NULL,
  PRIMARY KEY (`staff_wid`, `nonmedical_svcid`),
  INDEX `fk_staff_has_nonmedical_nonmedical1_idx` (`nonmedical_svcid` ASC),
  INDEX `fk_staff_has_nonmedical_staff1_idx` (`staff_wid` ASC),
  CONSTRAINT `fk_staff_has_nonmedical_staff1`
    FOREIGN KEY (`staff_wid`)
    REFERENCES `hospital`.`staff` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_has_nonmedical_nonmedical1`
    FOREIGN KEY (`nonmedical_svcid`)
    REFERENCES `hospital`.`nonmedical` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`outpatients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`outpatients` (
  `outpatient_svcid` INT NOT NULL,
  `doctors_wid` INT NOT NULL,
  `timestamp` DATETIME NULL DEFAULT now(),
  PRIMARY KEY (`outpatient_svcid`, `doctors_wid`),
  INDEX `fk_outpatient_has_doctors_doctors1_idx` (`doctors_wid` ASC),
  INDEX `fk_outpatient_has_doctors_outpatient1_idx` (`outpatient_svcid` ASC),
  CONSTRAINT `fk_outpatient_has_doctors_outpatient1`
    FOREIGN KEY (`outpatient_svcid`)
    REFERENCES `hospital`.`outpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_has_doctors_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `hospital`.`doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

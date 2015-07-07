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
DROP TABLE IF EXISTS `hospital`.`services` ;

CREATE TABLE IF NOT EXISTS `hospital`.`services` (
  `svcid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`svcid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`inpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`inpatient` ;

CREATE TABLE IF NOT EXISTS `hospital`.`inpatient` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `fk_inpatient_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`outpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`outpatient` ;

CREATE TABLE IF NOT EXISTS `hospital`.`outpatient` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `fk_outpatient_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`nonmedical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`nonmedical` ;

CREATE TABLE IF NOT EXISTS `hospital`.`nonmedical` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
  CONSTRAINT `fk_nonmedical_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `hospital`.`services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`workers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`workers` ;

CREATE TABLE IF NOT EXISTS `hospital`.`workers` (
  `wid` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `hire_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`volunteers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`volunteers` ;

CREATE TABLE IF NOT EXISTS `hospital`.`volunteers` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `fk_volunteer_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`employees` ;

CREATE TABLE IF NOT EXISTS `hospital`.`employees` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `fk_employee_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatment_administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`treatment_administrator` ;

CREATE TABLE IF NOT EXISTS `hospital`.`treatment_administrator` (
  `tadid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tadid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`nurses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`nurses` ;

CREATE TABLE IF NOT EXISTS `hospital`.`nurses` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `fk_nurse_wid`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nurse_tadid`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`administrators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`administrators` ;

CREATE TABLE IF NOT EXISTS `hospital`.`administrators` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `fk_admin_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`technicians`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`technicians` ;

CREATE TABLE IF NOT EXISTS `hospital`.`technicians` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `fk_tech_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tech_tadid1`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`staff` ;

CREATE TABLE IF NOT EXISTS `hospital`.`staff` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
  CONSTRAINT `fk_staff_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`doctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`doctors` ;

CREATE TABLE IF NOT EXISTS `hospital`.`doctors` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
  INDEX `tadid_idx` (`tadid` ASC),
  CONSTRAINT `fk_doctor_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `hospital`.`employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctor_tadid1`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`patients` ;

CREATE TABLE IF NOT EXISTS `hospital`.`patients` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `policynum` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`admits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`admits` ;

CREATE TABLE IF NOT EXISTS `hospital`.`admits` (
  `admission_id` INT NOT NULL AUTO_INCREMENT,
  `doctors_wid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `inpatient_svcid` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`),
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
    REFERENCES `hospital`.`patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admits_inpatient1`
    FOREIGN KEY (`inpatient_svcid`)
    REFERENCES `hospital`.`inpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`assigned_doctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`assigned_doctors` ;

CREATE TABLE IF NOT EXISTS `hospital`.`assigned_doctors` (
  `doctors_wid` INT NOT NULL,
  `admits_admission_id` INT NOT NULL,
  `admits_doctors_wid` INT NOT NULL,
  PRIMARY KEY (`doctors_wid`, `admits_admission_id`, `admits_doctors_wid`),
  INDEX `fk_doctors_has_admits_doctors1_idx` (`doctors_wid` ASC),
  INDEX `fk_assigned_doctors_admits1_idx` (`admits_admission_id` ASC, `admits_doctors_wid` ASC),
  CONSTRAINT `fk_doctors_has_admits_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `hospital`.`doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_doctors_admits1`
    FOREIGN KEY (`admits_admission_id` , `admits_doctors_wid`)
    REFERENCES `hospital`.`admits` (`admission_id` , `doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`treatments` ;

CREATE TABLE IF NOT EXISTS `hospital`.`treatments` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`medication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`medication` ;

CREATE TABLE IF NOT EXISTS `hospital`.`medication` (
  `tid` INT NOT NULL,
  `medid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
  CONSTRAINT `fk_medication_tid1`
    FOREIGN KEY (`tid`)
    REFERENCES `hospital`.`treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`procedures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`procedures` ;

CREATE TABLE IF NOT EXISTS `hospital`.`procedures` (
  `tid` INT NOT NULL,
  `procid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
  CONSTRAINT `fk_procedure_tid1`
    FOREIGN KEY (`tid`)
    REFERENCES `hospital`.`treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`orders` ;

CREATE TABLE IF NOT EXISTS `hospital`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `doctors_wid` INT NOT NULL,
  `treatment_tid` INT NOT NULL,
  `tadid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
    REFERENCES `hospital`.`treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_treatment_administrator1`
    FOREIGN KEY (`tadid`)
    REFERENCES `hospital`.`treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`administered_treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`administered_treatments` ;

CREATE TABLE IF NOT EXISTS `hospital`.`administered_treatments` (
  `order_id` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_administered_treatment_order_id1`
    FOREIGN KEY (`order_id`)
    REFERENCES `hospital`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`rooms` ;

CREATE TABLE IF NOT EXISTS `hospital`.`rooms` (
  `roomid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`roomid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`room_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`room_assignments` ;

CREATE TABLE IF NOT EXISTS `hospital`.`room_assignments` (
  `room_roomid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `administrators_wid` INT NOT NULL,
  PRIMARY KEY (`room_roomid`, `patient_pid`, `administrators_wid`),
  INDEX `fk_assigns_room1_idx` (`room_roomid` ASC),
  INDEX `fk_assigns_administrators1_idx` (`administrators_wid` ASC),
  INDEX `fk_assigns_patient1_idx` (`patient_pid` ASC),
  CONSTRAINT `fk_assigns_room1`
    FOREIGN KEY (`room_roomid`)
    REFERENCES `hospital`.`rooms` (`roomid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `hospital`.`admits` (`doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `hospital`.`administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`volunteer_schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`volunteer_schedules` ;

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
DROP TABLE IF EXISTS `hospital`.`staff_assignments` ;

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
DROP TABLE IF EXISTS `hospital`.`outpatients` ;

CREATE TABLE IF NOT EXISTS `hospital`.`outpatients` (
  `outpatient_svcid` INT NOT NULL,
  `doctors_wid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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


-- -----------------------------------------------------
-- Table `hospital`.`diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`diagnoses` ;

CREATE TABLE IF NOT EXISTS `hospital`.`diagnoses` (
  `diagid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`diagid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`inpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`inpatient_diagnoses` ;

CREATE TABLE IF NOT EXISTS `hospital`.`inpatient_diagnoses` (
  `inpatient_diagnosis_id` INT NOT NULL AUTO_INCREMENT,
  `diagid` INT NOT NULL,
  `admission_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`inpatient_diagnosis_id`, `diagid`, `admission_id`),
  INDEX `fk_admission_id1_idx` (`admission_id` ASC),
  CONSTRAINT `fk_diagnosis_diagid1`
    FOREIGN KEY (`diagid`)
    REFERENCES `hospital`.`diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admission_id1`
    FOREIGN KEY (`admission_id`)
    REFERENCES `hospital`.`admits` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.``
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`` ;

CREATE TABLE IF NOT EXISTS `hospital`.`` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`discharges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`discharges` ;

CREATE TABLE IF NOT EXISTS `hospital`.`discharges` (
  `admits_admission_id` INT NOT NULL,
  `administrators_wid` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admits_admission_id`, `administrators_wid`),
  INDEX `fk_administrators_has_admits_admits1_idx` (`admits_admission_id` ASC),
  INDEX `fk_discharges_administrators1_idx` (`administrators_wid` ASC),
  CONSTRAINT `fk_administrators_has_admits_admits1`
    FOREIGN KEY (`admits_admission_id`)
    REFERENCES `hospital`.`admits` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discharges_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `hospital`.`administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`outpatient_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`outpatient_orders` ;

CREATE TABLE IF NOT EXISTS `hospital`.`outpatient_orders` (
  `outpatient_order_id` INT NOT NULL AUTO_INCREMENT,
  `outpatients_outpatient_svcid` INT NOT NULL,
  `outpatients_doctors_wid` INT NOT NULL,
  `patients_pid` INT NOT NULL,
  PRIMARY KEY (`outpatient_order_id`, `patients_pid`, `outpatients_outpatient_svcid`, `outpatients_doctors_wid`),
  INDEX `fk_outpatients_has_doctors_outpatients1_idx` (`outpatients_outpatient_svcid` ASC, `outpatients_doctors_wid` ASC),
  INDEX `fk_outpatient_orders_patients1_idx` (`patients_pid` ASC),
  CONSTRAINT `fk_outpatients_has_doctors_outpatients1`
    FOREIGN KEY (`outpatients_outpatient_svcid` , `outpatients_doctors_wid`)
    REFERENCES `hospital`.`outpatients` (`outpatient_svcid` , `doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_orders_patients1`
    FOREIGN KEY (`patients_pid`)
    REFERENCES `hospital`.`patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `hospital`.`outpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`outpatient_diagnoses` ;

CREATE TABLE IF NOT EXISTS `hospital`.`outpatient_diagnoses` (
  `diagnoses_diagid` INT NOT NULL,
  `outpatient_order_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`diagnoses_diagid`, `outpatient_order_id`),
  INDEX `fk_outpatient_orders_has_diagnoses_diagnoses1_idx` (`diagnoses_diagid` ASC),
  CONSTRAINT `fk_outpatient_orders_has_diagnoses_diagnoses1`
    FOREIGN KEY (`diagnoses_diagid`)
    REFERENCES `hospital`.`diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

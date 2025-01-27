-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema UNSW
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema UNSW
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `UNSW` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema car_dealership_lab
-- -----------------------------------------------------
USE `UNSW` ;

-- -----------------------------------------------------
-- Table `UNSW`.`STUDENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`STUDENTS` (
  `st_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` VARCHAR(45) NULL,
  `age` INT NULL,
  PRIMARY KEY (`st_id`),
  UNIQUE INDEX `st_id_UNIQUE` (`st_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`COURSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`COURSES` (
  `c_id` INT NOT NULL AUTO_INCREMENT,
  `c_name` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`c_id`),
  UNIQUE INDEX `c_id_UNIQUE` (`c_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`STUDENTS_has_COURSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`STUDENTS_has_COURSES` (
  `STUDENTS_st_id` INT NOT NULL,
  `COURSES_c_id` INT NOT NULL,
  `grade` DECIMAL(2) NULL,
  `attendance` VARCHAR(45) NULL,
  PRIMARY KEY (`STUDENTS_st_id`, `COURSES_c_id`),
  INDEX `fk_STUDENTS_has_COURSES_COURSES1_idx` (`COURSES_c_id` ASC) VISIBLE,
  INDEX `fk_STUDENTS_has_COURSES_STUDENTS1_idx` (`STUDENTS_st_id` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENTS_has_COURSES_STUDENTS1`
    FOREIGN KEY (`STUDENTS_st_id`)
    REFERENCES `UNSW`.`STUDENTS` (`st_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STUDENTS_has_COURSES_COURSES1`
    FOREIGN KEY (`COURSES_c_id`)
    REFERENCES `UNSW`.`COURSES` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`SALESPERSONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`SALESPERSONS` (
  `id2` INT NOT NULL AUTO_INCREMENT,
  `staff_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `store` VARCHAR(45) NULL,
  PRIMARY KEY (`id2`),
  UNIQUE INDEX `staff_id_UNIQUE` (`id2` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`CUSTOMERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`CUSTOMERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone number` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`INVOICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`INVOICE` (
  `invoice_number` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `car` VARCHAR(45) NULL,
  `customer` VARCHAR(45) NULL,
  `invoice_total` FLOAT NOT NULL,
  `salesperson_id` VARCHAR(45) NULL,
  `SALESPERSONS_id2` INT NOT NULL,
  `CUSTOMERS_id` INT NOT NULL,
  PRIMARY KEY (`invoice_number`),
  UNIQUE INDEX `invoice_number_UNIQUE` (`invoice_number` ASC) VISIBLE,
  INDEX `fk_INVOICE_SALESPERSONS1_idx` (`SALESPERSONS_id2` ASC) VISIBLE,
  INDEX `fk_INVOICE_CUSTOMERS1_idx` (`CUSTOMERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_INVOICE_SALESPERSONS1`
    FOREIGN KEY (`SALESPERSONS_id2`)
    REFERENCES `UNSW`.`SALESPERSONS` (`id2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVOICE_CUSTOMERS1`
    FOREIGN KEY (`CUSTOMERS_id`)
    REFERENCES `UNSW`.`CUSTOMERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`CARS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`CARS` (
  `car_id` INT NOT NULL AUTO_INCREMENT,
  `VIN` VARCHAR(45) NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `colour` VARCHAR(45) NULL,
  `staff_id` VARCHAR(45) NULL,
  `INVOICE_invoice_number` INT NOT NULL,
  `CUSTOMERS_id` INT NOT NULL,
  UNIQUE INDEX `VIN_UNIQUE` (`car_id` ASC) VISIBLE,
  PRIMARY KEY (`car_id`),
  UNIQUE INDEX `VIN_UNIQUE` (`VIN` ASC) VISIBLE,
  INDEX `fk_CARS_INVOICE1_idx` (`INVOICE_invoice_number` ASC) VISIBLE,
  INDEX `fk_CARS_CUSTOMERS1_idx` (`CUSTOMERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_CARS_INVOICE1`
    FOREIGN KEY (`INVOICE_invoice_number`)
    REFERENCES `UNSW`.`INVOICE` (`invoice_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CARS_CUSTOMERS1`
    FOREIGN KEY (`CUSTOMERS_id`)
    REFERENCES `UNSW`.`CUSTOMERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UNSW`.`CUSTOMERS_has_SALESPERSONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UNSW`.`CUSTOMERS_has_SALESPERSONS` (
  `CUSTOMERS_id` INT NOT NULL,
  `SALESPERSONS_id2` INT NOT NULL,
  PRIMARY KEY (`CUSTOMERS_id`, `SALESPERSONS_id2`),
  INDEX `fk_CUSTOMERS_has_SALESPERSONS_SALESPERSONS1_idx` (`SALESPERSONS_id2` ASC) VISIBLE,
  INDEX `fk_CUSTOMERS_has_SALESPERSONS_CUSTOMERS1_idx` (`CUSTOMERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_CUSTOMERS_has_SALESPERSONS_CUSTOMERS1`
    FOREIGN KEY (`CUSTOMERS_id`)
    REFERENCES `UNSW`.`CUSTOMERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CUSTOMERS_has_SALESPERSONS_SALESPERSONS1`
    FOREIGN KEY (`SALESPERSONS_id2`)
    REFERENCES `UNSW`.`SALESPERSONS` (`id2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

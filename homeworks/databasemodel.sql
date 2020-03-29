-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema banking_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema banking_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banking_system` DEFAULT CHARACTER SET utf8 ;
USE `banking_system` ;

-- -----------------------------------------------------
-- Table `banking_system`.`Main Bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Main Bank` (
  `bank_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bank_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Branches` (
  `branch_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_id` INT UNSIGNED NOT NULL,
  `location` VARCHAR(45) NULL,
  PRIMARY KEY (`branch_id`, `bank_id`),
  UNIQUE INDEX `location_UNIQUE` (`location` ASC) VISIBLE,
  INDEX `bank_id_idx` (`bank_id` ASC) VISIBLE,
  CONSTRAINT `BANK_BRANCH_FK`
    FOREIGN KEY (`bank_id`)
    REFERENCES `banking_system`.`Main Bank` (`bank_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Employees` (
  `employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `branch_id` INT UNSIGNED NOT NULL,
  `age` INT NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `EMPLOYEE_BRANCH_FK`
    FOREIGN KEY (`branch_id`)
    REFERENCES `banking_system`.`Branches` (`branch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Managers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Managers` (
  `manager_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` INT UNSIGNED NOT NULL,
  `branch_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`manager_id`, `employee_id`),
  INDEX `branch_id_idx` (`branch_id` ASC) VISIBLE,
  INDEX `manager_id_idx` (`employee_id` ASC) VISIBLE,
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  UNIQUE INDEX `branch_id_UNIQUE` (`branch_id` ASC) VISIBLE,
  CONSTRAINT `MANAGER_BRANCH_FK`
    FOREIGN KEY (`branch_id`)
    REFERENCES `banking_system`.`Branches` (`branch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `EMPLOYEE_MANAGER_FK`
    FOREIGN KEY (`employee_id`)
    REFERENCES `banking_system`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Bank Tellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Bank Tellers` (
  `teller_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`teller_id`, `employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `EMPLOYEE_TELLER_FK`
    FOREIGN KEY (`employee_id`)
    REFERENCES `banking_system`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Accounts` (
  `acc_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `teller_id` INT UNSIGNED NULL,
  PRIMARY KEY (`acc_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  CONSTRAINT `ACC_BY_TELLER_FK`
    FOREIGN KEY (`teller_id`)
    REFERENCES `banking_system`.`Bank Tellers` (`teller_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Bank Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Bank Accounts` (
  `bacc_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `acc_id` INT UNSIGNED NOT NULL,
  `teller_id` INT UNSIGNED NULL,
  PRIMARY KEY (`bacc_id`, `acc_id`),
  CONSTRAINT `BACC_ACC_FK`
    FOREIGN KEY (`acc_id`)
    REFERENCES `banking_system`.`Accounts` (`acc_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `BACC_BY_TELLER_FK`
    FOREIGN KEY (`teller_id`)
    REFERENCES `banking_system`.`Bank Tellers` (`teller_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Checking Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Checking Accounts` (
  `checking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bacc_id` INT UNSIGNED NOT NULL,
  `balance` FLOAT(17,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`checking_id`, `bacc_id`),
  UNIQUE INDEX `bacc_id_UNIQUE` (`bacc_id` ASC) VISIBLE,
  CONSTRAINT `CHECKING_BACC_FK`
    FOREIGN KEY (`bacc_id`)
    REFERENCES `banking_system`.`Bank Accounts` (`bacc_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Savings Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Savings Accounts` (
  `saving_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bacc_id` INT UNSIGNED NOT NULL,
  `balance` FLOAT(17,2) NOT NULL DEFAULT 0.00,
  `APY` FLOAT(5,2) NOT NULL DEFAULT 0.06,
  PRIMARY KEY (`saving_id`, `bacc_id`),
  UNIQUE INDEX `bacc_id_UNIQUE` (`bacc_id` ASC) VISIBLE,
  CONSTRAINT `SAVING_BACC_FK`
    FOREIGN KEY (`bacc_id`)
    REFERENCES `banking_system`.`Bank Accounts` (`bacc_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Transfers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Transfers` (
  `transfer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `checking_id` INT UNSIGNED NULL,
  `saving_id` INT UNSIGNED NULL,
  `amount` FLOAT(17,2) NOT NULL,
  `direction` ENUM("saving-to-checking", "checking-to-saving") NOT NULL,
  PRIMARY KEY (`transfer_id`),
  CONSTRAINT `CHECKING_TRANSFER_FK`
    FOREIGN KEY (`checking_id`)
    REFERENCES `banking_system`.`Checking Accounts` (`checking_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `SAVING_TRANSFER_FK`
    FOREIGN KEY (`saving_id`)
    REFERENCES `banking_system`.`Savings Accounts` (`saving_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `age` INT NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`User Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`User Accounts` (
  `user_id` INT UNSIGNED NOT NULL,
  `acc_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `acc_id`),
  INDEX `acc_id_idx` (`acc_id` ASC) VISIBLE,
  CONSTRAINT `OWNER_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `banking_system`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ACC_OWNED_FK`
    FOREIGN KEY (`acc_id`)
    REFERENCES `banking_system`.`Accounts` (`acc_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Debit Cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Debit Cards` (
  `card_number` CHAR(16) NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `checking_id` INT UNSIGNED NULL,
  `CVV` CHAR(3) NOT NULL,
  `expiration_date` DATE NOT NULL,
  `pin` CHAR(4) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`card_number`),
  UNIQUE INDEX `checking_id_UNIQUE` (`checking_id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `CARD_OWNER_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `banking_system`.`Users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `CHECKING_CONNECTED_FK`
    FOREIGN KEY (`checking_id`)
    REFERENCES `banking_system`.`Checking Accounts` (`checking_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`ATMs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`ATMs` (
  `atm_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` INT UNSIGNED NOT NULL,
  `balance` FLOAT(17,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`atm_Id`, `branch_id`),
  CONSTRAINT `BRANCH_LOCATED_FK`
    FOREIGN KEY (`branch_id`)
    REFERENCES `banking_system`.`Branches` (`branch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Payment Methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Payment Methods` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_method` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Transaction` (
  `transaction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `atm_id` INT UNSIGNED NULL,
  `payment_id` INT UNSIGNED NOT NULL,
  `card_number` CHAR(16) NULL,
  `amount` FLOAT(17,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`transaction_id`),
  INDEX `atm_id_idx` (`atm_id` ASC) VISIBLE,
  INDEX `card_number_idx` (`card_number` ASC) VISIBLE,
  INDEX `payment_id_idx` (`payment_id` ASC) VISIBLE,
  UNIQUE INDEX `COMP_TRANS_UNIQUE` (`transaction_id` ASC, `atm_id` ASC, `card_number` ASC) VISIBLE,
  CONSTRAINT `ATM_FK`
    FOREIGN KEY (`atm_id`)
    REFERENCES `banking_system`.`ATMs` (`atm_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `DEBIT_CARD_FK`
    FOREIGN KEY (`card_number`)
    REFERENCES `banking_system`.`Debit Cards` (`card_number`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `PAYMENT_METHODS_FK`
    FOREIGN KEY (`payment_id`)
    REFERENCES `banking_system`.`Payment Methods` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking_system`.`Checks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking_system`.`Checks` (
  `check_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id (from)` INT UNSIGNED NULL,
  `user_id (to)` INT UNSIGNED NULL,
  `teller_id` INT UNSIGNED NULL,
  `amount` FLOAT(17,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`check_id`),
  INDEX `user_id (to)_idx` (`user_id (to)` ASC) VISIBLE,
  INDEX `user_id (from)_idx` (`user_id (from)` ASC) VISIBLE,
  UNIQUE INDEX `COMP_UNIQUE` (`check_id` ASC, `user_id (from)` ASC, `user_id (to)` ASC) VISIBLE,
  CONSTRAINT `USER_RECEIVER_FK`
    FOREIGN KEY (`user_id (to)`)
    REFERENCES `banking_system`.`Users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `USER_SENDER_FK`
    FOREIGN KEY (`user_id (from)`)
    REFERENCES `banking_system`.`Users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `TELLER_PROCESSED_FK`
    FOREIGN KEY (`teller_id`)
    REFERENCES `banking_system`.`Bank Tellers` (`teller_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

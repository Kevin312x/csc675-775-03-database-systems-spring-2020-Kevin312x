USE banking_system;

INSERT INTO `main bank`(bank_name) VALUES("XYZ Bank");
INSERT INTO `main bank`(bank_name) VALUES("ABC Bank");
INSERT INTO `main bank`(bank_name) VALUES("BIG Bank");

INSERT INTO branches(bank_id, location) VALUES(1, "XYZ Street, CA");
INSERT INTO branches(bank_id, location) VALUES(2, "ABC Street, CA");
INSERT INTO branches(bank_id, location) VALUES(3, "Large Street, CA");
INSERT INTO branches(bank_id, location) VALUES (1, "2134 Nowhere Ville");

INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("John", "Smith", 1, 25, "1995-07-23");
INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("Emma", "Johnson", 3, 27, "1993-05-13");
INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("Robert", "Brown", 2, 33, "1987-11-06");
INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("David", "Miller", 2, 20, "2020-01-02");
INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("Thomas", "Jones", 2, 30, "1990-12-25");
INSERT INTO employees(first_name, last_name, branch_id, age, dob) VALUES("Nancy", "Anderson", 3, 35, "1985-09-16");

INSERT INTO managers(employee_id, branch_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 1),
    (SELECT (b.branch_id) FROM branches b, employees e WHERE e.employee_id = 1 AND e.branch_id = b.branch_id));
INSERT INTO managers(employee_id, branch_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 2),
    (SELECT (b.branch_id) FROM branches b, employees e WHERE e.employee_id = 2 AND e.branch_id = b.branch_id));
INSERT INTO managers(employee_id, branch_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 3),
    (SELECT (b.branch_id) FROM branches b, employees e WHERE e.employee_id = 3 AND e.branch_id = b.branch_id));

INSERT INTO `bank tellers`(employee_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 5 AND employee_id NOT IN
    (SELECT employee_id FROM managers)));
INSERT INTO `bank tellers`(employee_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 6 AND employee_id NOT IN
    (SELECT employee_id FROM managers)));
INSERT INTO `bank tellers`(employee_id) VALUES (
	(SELECT (employee_id) FROM employees WHERE employee_id = 4 AND employee_id NOT IN
    (SELECT employee_id FROM managers)));

INSERT INTO users(first_name, last_name, age, dob) VALUES ("Kevin", "Huynh", 23, "1997-03-19");
INSERT INTO users(first_name, last_name, age, dob) VALUES ("Sarah", "Davis", 18, "2003-10-15");
INSERT INTO users(first_name, last_name, age, dob) VALUES ("William", "Miller", 60, "1960-02-09");

INSERT INTO accounts(username, `password`, teller_id) VALUES ("kevin123", "something",
	(SELECT teller_id FROM `bank tellers` WHERE teller_id = 1));
INSERT INTO accounts(username, `password`, teller_id) VALUES ("sarahqwerty", "somepassword",
	(SELECT teller_id FROM `bank tellers` WHERE teller_id = 2));
INSERT INTO accounts(username, `password`, teller_id) VALUES ("willmill", "newpassword",
	(SELECT teller_id FROM `bank tellers` WHERE teller_id = 3));

INSERT INTO `user accounts`(user_id, acc_id) VALUES (1, 1);
INSERT INTO `user accounts`(user_id, acc_id) VALUES (2, 2);
INSERT INTO `user accounts`(user_id, acc_id) VALUES (3, 3);

INSERT INTO `bank accounts`(acc_id, teller_id) VALUES (
	(SELECT acc_id FROM accounts WHERE username = "kevin123"),
    (SELECT teller_id FROM accounts WHERE username = "kevin123"));
INSERT INTO `bank accounts`(acc_id, teller_id) VALUES (
	(SELECT acc_id FROM accounts WHERE username = "kevin123"), 2);
INSERT INTO `bank accounts`(acc_id, teller_id) VALUES (
	(SELECT acc_id FROM accounts WHERE username = "sarahqwerty"),
    (SELECT teller_id FROM accounts WHERE username = "sarahqwerty"));
INSERT INTO `bank accounts`(acc_id, teller_id) VALUES (
	(SELECT acc_id FROM accounts WHERE username = "willmill"),
    (SELECT teller_id FROM accounts WHERE username = "willmill"));

INSERT INTO `checking accounts`(bacc_id, balance) VALUES (
	(SELECT bacc_id FROM `bank accounts` WHERE bacc_id = 1), 500.00);
INSERT INTO `checking accounts`(bacc_id, balance) VALUES (
	(SELECT bacc_id FROM `bank accounts` WHERE bacc_id = 3), 500.00);
INSERT INTO `checking accounts`(bacc_id, balance) VALUES (
	(SELECT bacc_id FROM `bank accounts` WHERE bacc_id = 4), 2500.00);
    
INSERT INTO `savings accounts`(bacc_id, balance) VALUES (
	(SELECT bacc_id FROM `bank accounts` WHERE bacc_id = 2), 1000.00);

INSERT INTO transfers(checking_id, saving_id, amount, direction) VALUES (1, 1, 0.00, "checking-to-saving");
INSERT INTO transfers(checking_id, saving_id, amount, direction) VALUES (2, 1, 0.00, "saving-to-checking");
INSERT INTO transfers(checking_id, saving_id, amount, direction) VALUES (2, 1, 0.00, "checking-to-saving");

INSERT INTO atms(branch_id, balance) VALUES (1, 100000.00);
INSERT INTO atms(branch_id, balance) VALUES (1, 50000.00);
INSERT INTO atms(branch_id, balance) VALUES (3, 100000.00);
INSERT INTO atms(branch_id, balance) VALUES (2, 123000.00);


INSERT INTO `debit cards`(card_number, user_id, checking_id, CVV, expiration_date, pin, `active`) VALUES (
	"1251351584321659", 1, 1, "513", "2025-06-00", "3899", true);
INSERT INTO `debit cards`(card_number, user_id, checking_id, CVV, expiration_date, pin, `active`) VALUES (
	"5618651651861568", 2, 2, "221", "2022-09-00", "5252", true);
    
INSERT INTO `payment methods`(payment_method) VALUE ("Deposit");
INSERT INTO `payment methods`(payment_method) VALUE ("Withdrawal");
INSERT INTO `payment methods`(payment_method) VALUE ("Cash");

INSERT INTO `transaction`(atm_id, payment_id, card_number, amount) VALUES (1, 2, "1251351584321659", 50.00);
INSERT INTO `transaction`(atm_id, payment_id, card_number, amount) VALUES (1, 3, "1251351584321659", 20.00);
INSERT INTO `transaction`(atm_id, payment_id, card_number, amount) VALUES (2, 3, "5618651651861568", 40.00);

INSERT INTO checks(`user_id (from)`, `user_id (to)`, teller_id, amount) VALUES (1, 2, 3, 122.53);
INSERT INTO checks(`user_id (from)`, `user_id (to)`, teller_id, amount) VALUES (1, 3, 1, 150.50);
INSERT INTO checks(`user_id (from)`, `user_id (to)`, teller_id, amount) VALUES (3, 2, 2, 5.53);
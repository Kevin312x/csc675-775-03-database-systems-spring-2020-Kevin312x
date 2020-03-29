USE banking_system;

UPDATE `main bank` SET bank_name="LARGE Bank" WHERE bank_name = "BIG Bank";
DELETE FROM `main bank` WHERE bank_id = 3;
SELECT m.bank_name, b.location FROM `main bank` m, branches b WHERE m.bank_id = b.bank_id;

UPDATE employees SET last_name = "Wall" WHERE employee_id = 3;
DELETE FROM employees WHERE employee_id = 5;
SELECT e.first_name, e.last_name, b.location FROM employees e, branches b WHERE e.branch_id = b.branch_id;

UPDATE managers SET branch_id = 4 WHERE manager_id = 3;
DELETE FROM managers WHERE branch_id = 4;
SELECT e.first_name, e.last_name, b.branch_id 
FROM employees e, managers m, branches b 
WHERE b.branch_id = m.branch_id AND m.employee_id = e.employee_id;

DELETE FROM atms WHERE atm_id = 4;
UPDATE atms SET balance = 1000000 WHERE atm_id = 2;
SELECT a.atm_id, b.location FROM atms a LEFT JOIN branches b ON a.branch_id = b.branch_id;

DELETE FROM `bank accounts` WHERE bacc_id = 1;
UPDATE `bank accounts` SET acc_id = 2 WHERE bacc_id = 2;
SELECT * FROM `bank accounts` ba LEFT JOIN accounts a ON ba.acc_id = a.acc_id;

DELETE FROM `accounts` WHERE acc_id = 1;
UPDATE accounts SET `password` = "newerpassword" WHERE `password` = "newpassword";
SELECT t.teller_id, a.acc_id
FROM `bank tellers` t LEFT JOIN accounts a
ON t.teller_id = a.teller_id;

UPDATE `bank accounts` SET teller_id = 3 WHERE bacc_id = 2;
DELETE FROM `bank accounts` WHERE bacc_id = 3;
SELECT t.teller_id, ba.bacc_id
FROM `bank tellers` t LEFT JOIN `bank accounts` ba
ON t.teller_id = ba.teller_id;

UPDATE `user accounts` SET acc_id = 3 WHERE user_id = 2;
DELETE FROM users WHERE user_id = 1;
SELECT * from `user accounts`;

UPDATE checks SET teller_id = 3 WHERE check_id = 3;
DELETE FROM checks WHERE check_id = 2;
SELECT t.teller_id, c.check_id FROM `bank tellers` t, checks c WHERE t.teller_id = 3 AND t.teller_id = c.teller_id;

UPDATE `checking accounts` SET balance = 15000.00 WHERE checking_id = 3;
DELETE FROM `checking accounts` WHERE checking_id = 3;
SELECT * FROM `checking accounts`;

UPDATE `debit cards` SET checking_id = 3 WHERE card_number = "5618651651861568";
DELETE FROM `debit cards` WHERE card_number = "1251351584321659";
SELECT * FROM `debit cards`;

UPDATE `transaction` SET card_number = "5618651651861568" WHERE transaction_id = 2;
DELETE FROM `transaction` WHERE transaction_id = 1;
SELECT * FROM `transaction`;

UPDATE transfers SET amount = 15.00 WHERE transfer_id = 1;
DELETE FROM transfers WHERE transfer_id = 2;
SELECT * FROM transfers;
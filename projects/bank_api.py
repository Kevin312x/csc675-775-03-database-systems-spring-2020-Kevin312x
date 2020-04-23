import database as db
import random

def init():
    bank_name = 'XYZ Bank'
    db.queryDatabase('''INSERT INTO `main bank`(bank_id, bank_name) VALUES (%s, %s) ON DUPLICATE KEY UPDATE bank_name = %s;''', (1, bank_name, bank_name))
    db.queryDatabase('''INSERT INTO branches(branch_id, bank_id, location) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE location = %s''', (1, 1, 'SFSU', 'SFSU'))
    db.queryDatabase('''INSERT INTO employees(employee_id, first_name, last_name, branch_id, age, dob) VALUES (%s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE branch_id = 1;''', (1, 'John', 'Smith', 1, 30, '1990-3-10'))
    db.queryDatabase('''INSERT INTO employees(employee_id, first_name, last_name, branch_id, age, dob) VALUES (%s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE branch_id = 1;''', (2, 'Frank', 'Johnson', 1, 35, '1985-3-22'))
    db.queryDatabase('''INSERT INTO employees(employee_id, first_name, last_name, branch_id, age, dob) VALUES (%s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE branch_id = 1;''', (3, 'Ada', 'Williams', 1, 22, '1997-9-25'))
    db.queryDatabase('''INSERT INTO `bank tellers`(teller_id, employee_id) VALUES (1, 1) ON DUPLICATE KEY UPDATE employee_id = 1''', ())
    db.queryDatabase('''INSERT INTO `bank tellers`(teller_id, employee_id) VALUES (2, 2) ON DUPLICATE KEY UPDATE employee_id = 2''', ())
    db.queryDatabase('''INSERT INTO `bank tellers`(teller_id, employee_id) VALUES (3, 3) ON DUPLICATE KEY UPDATE employee_id = 3''', ())
    db.commitDatabase()


def getTeller():
    results = db.queryDatabase('''SELECT employee_id, teller_id FROM `bank tellers`;''', ())
    rand = random.randint(1, len(results))
    selected_employee_id = results[rand-1]['employee_id']
    selected_teller_id = results[rand-1]['teller_id']
    employee_info = db.queryDatabase('''SELECT first_name, last_name FROM employees WHERE employee_id = %s LIMIT 1;''', (selected_employee_id,))
    return {'teller_id': selected_teller_id, 'employee_first_name': employee_info[0]['first_name'], 'employee_last_name': employee_info[0]['last_name']}

def checkUsername(username):
    results = db.queryDatabase('''SELECT COUNT(*) FROM accounts WHERE username = %s;''', (username,))
    if results[0]['COUNT(*)'] == 0:
        return True
    return False

def addUser(username, password, teller_id):
    db.queryDatabase('''INSERT INTO accounts(username, password, teller_id) VALUES (%s, %s, %s);''', (username, password, teller_id))
    db.commitDatabase()

def getUser(username):
    results = db.queryDatabase('''SELECT acc_id, username, password FROM accounts WHERE username = %s;''', (username,))
    return results

def addBankAccount(acc_id, teller_id):
    pass

def addCheckingAccount(bacc_id):
    pass

def checkCheckingAccounts(acc_id):
    results = db.queryDatabase('''SELECT COUNT(*) FROM `bank accounts` ba INNER JOIN `checking accounts` ca ON ca.bacc_id = ba.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
    if results[0]['COUNT(*)'] == 0:
        return False
    return True

def getCheckingAccounts(acc_id):
    pass

def addSavingsAccount(bacc_id):
    pass

def checkSavingsAccount(acc_id):
    results = db.queryDatabase('''SELECT COUNT(*) FROM `bank accounts` ba INNER JOIN `savings accounts` sa ON sa.bacc_id = ba.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
    if results[0]['COUNT(*)'] == 0:
        return False
    return True

def getSavingsAccount(acc_id):
    pass
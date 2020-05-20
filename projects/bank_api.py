import database as db
import random

def getTeller():
    results = db.queryDatabase('''SELECT employee_id, teller_id FROM `Bank Tellers`;''', ())
    rand = random.randint(1, len(results))
    selected_employee_id = results[rand-1]['employee_id']
    selected_teller_id = results[rand-1]['teller_id']
    employee_info = db.queryDatabase('''SELECT first_name, last_name FROM Employees WHERE employee_id = %s LIMIT 1;''', (selected_employee_id,))
    return {'teller_id': selected_teller_id, 'employee_first_name': employee_info[0]['first_name'], 'employee_last_name': employee_info[0]['last_name']}

def checkUsername(username):
    count = db.queryDatabase('''SELECT COUNT(*) FROM Accounts WHERE username = %s;''', (username,))
    if count[0]['COUNT(*)'] == 0:
        return True
    return False

def addUser(username, password, teller_id, firstname, lastname, age, dob):
    db.queryDatabase('''INSERT INTO Users (first_name, last_name, age, dob) VALUES (%s, %s, %s, %s);''', (firstname, lastname, age, dob))
    user_id = db.queryDatabase('''SELECT user_id FROM Users WHERE first_name = %s AND last_name = %s AND age = %s ORDER BY user_id DESC;''', (firstname, lastname, age))
    user_id = user_id[0]['user_id']
    db.queryDatabase('''INSERT INTO Accounts(username, password, teller_id) VALUES (%s, %s, %s);''', (username, password, teller_id))
    acc_id = db.queryDatabase('''SELECT acc_id FROM Accounts WHERE username = %s;''', (username,))
    acc_id = acc_id[0]['acc_id']
    db.queryDatabase('''INSERT INTO `User Accounts`(user_id, acc_id) VALUES (%s, %s);''', (user_id, acc_id))
    db.commitDatabase()

def getUser(username):
    results = db.queryDatabase('''SELECT acc_id, username, password FROM Accounts WHERE username = %s;''', (username,))
    return results

def addBankAccount(acc_id, teller_id):
    db.queryDatabase('''INSERT INTO `Bank Accounts`(acc_id, teller_id) VALUES (%s, %s);''', (acc_id, teller_id))
    bacc_id = db.queryDatabase('''SELECT bacc_id FROM `Bank Accounts` WHERE acc_id = %s ORDER BY bacc_id DESC;''', (acc_id,))
    return bacc_id

def addCheckingAccount(acc_id, teller_id):
    bacc = addBankAccount(acc_id, teller_id)
    db.queryDatabase('''INSERT INTO `Checking Accounts`(bacc_id) VALUES (%s);''', (bacc[0]['bacc_id'],))
    db.commitDatabase()

def checkCheckingAccounts(acc_id):
    count = db.queryDatabase('''SELECT COUNT(*) FROM `Bank Accounts` ba INNER JOIN `Checking Accounts` ca ON ca.bacc_id = ba.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
    if count[0]['COUNT(*)'] == 0:
        return False
    return True

def getCheckingAccounts(acc_id):
    if checkCheckingAccounts(acc_id) == False:
        return None
    else:
        results = db.queryDatabase('''SELECT ba.bacc_id FROM `Checking Accounts` ca INNER JOIN `Bank Accounts` ba ON ba.bacc_id = ca.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
        return results

def addSavingsAccount(acc_id, teller_id):
    bacc = addBankAccount(acc_id, teller_id)
    db.queryDatabase('''INSERT INTO `Savings Accounts`(bacc_id) VALUES (%s);''', (bacc[0]['bacc_id'],))
    db.commitDatabase()

def checkSavingsAccounts(acc_id):
    count = db.queryDatabase('''SELECT COUNT(*) FROM `Bank Accounts` ba INNER JOIN `Savings Accounts` sa ON sa.bacc_id = ba.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
    if count[0]['COUNT(*)'] == 0:
        return False
    return True

def getSavingsAccounts(acc_id):
    if checkSavingsAccounts(acc_id) == False:
        return None
    else:
        results = db.queryDatabase('''SELECT ba.bacc_id FROM `Savings Accounts` sa INNER JOIN `Bank Accounts` ba ON ba.bacc_id = sa.bacc_id WHERE ba.acc_id = %s;''', (acc_id,))
        return results

def checkAccountCategory(bacc_id):
    count = db.queryDatabase('''SELECT COUNT(*) FROM `Bank Accounts` WHERE bacc_id = %s;''', (bacc_id,))
    if count[0]['COUNT(*)'] != 0:
        checking_count = db.queryDatabase('''SELECT COUNT(*) FROM `Checking Accounts` WHERE bacc_id = %s;''', (bacc_id,))
        if checking_count[0]['COUNT(*)'] != 0:
            return 1
        else:
            return 2
    else:
        return -1

def depositAccount(bacc_id, amount):
    account = ''
    category = checkAccountCategory(bacc_id)
    if category == 1:
        account = 'Checking Accounts'
        balance = db.queryDatabase('''SELECT balance FROM `Checking Accounts` WHERE bacc_id = %s;''', (bacc_id,))
    elif category == 2:
        account = 'Savings Accounts'
        balance = db.queryDatabase('''SELECT balance FROM `Savings Accounts` WHERE bacc_id = %s;''', (bacc_id,))
    else:
        print('Account does not exist')
        return -1

    balance = balance[0]['balance'] + amount
    queryString = 'UPDATE `' + account + '` SET balance = %s WHERE bacc_id = %s;'
    db.queryDatabase(queryString, (balance, bacc_id))
    db.commitDatabase()

def withdrawAccount(bacc_id, amount):
    account = ''
    category = checkAccountCategory(bacc_id)
    if category == 1:
        account = 'Checking Accounts'
        balance = db.queryDatabase('''SELECT balance FROM `Checking Accounts` WHERE bacc_id = %s;''', (bacc_id,))
    elif category == 2:
        account = 'Savings Accounts'
        balance = db.queryDatabase('''SELECT balance FROM `Savings Accounts` WHERE bacc_id = %s;''', (bacc_id,))
    else:
        print('Account ID', bacc_id, 'does not exist')
        return -1

    balance = balance[0]['balance'] - amount
    if balance < 0:
        print('Insufficient balance')
        return -1
    else:
        queryString = 'UPDATE `' + account + '` SET balance = %s WHERE bacc_id = %s;'
        db.queryDatabase(queryString, (balance, bacc_id))
        db.commitDatabase()
        
def checkBalance(bacc_id):
    account = ''
    category = checkAccountCategory(bacc_id)
    if category == 1:
        account = 'Checking Accounts'
    elif category == 2:
        account = 'Savings Accounts'
    else:
        print('Account ID', bacc_id, 'does not exist')
        return

    queryString = 'SELECT balance FROM `' + account + '` WHERE bacc_id = %s;'
    balance = db.queryDatabase(queryString, (bacc_id,))
    print('Bank Account ID:', bacc_id, '\t\tBalance:', '$' + str(balance[0]['balance']))

def transfer(bacc_from, bacc_to, amount):
    if withdrawAccount(bacc_from, amount) != -1:
        depositAccount(bacc_to, amount)

def closeDatabase():
    db.closeDatabase()

db.executeScript()

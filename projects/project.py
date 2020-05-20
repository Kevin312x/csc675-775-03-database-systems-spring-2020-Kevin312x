import bank_api as bankManager
import sys

# NEED TO USE requirements.txt IF WE USE PYTHON TO SHOW MODULES
teller_info = None
user = None

###################################################################################
#                                                                                 #
#                                   MENU #2                                       #
#                                                                                 #
###################################################################################

def getTeller():
    global teller_info
    teller_info = bankManager.getTeller()
    print("\n\nHello, your bank teller today is", teller_info['employee_first_name'], teller_info['employee_last_name'] + '.\n\n')

def operations_prompt():
    print('''
    Operations:

    1. Create bank account
    2. Deposit
    3. Withdraw
    4. Transfer
    5. Check balance
    6. Sign out

    ''')

def signIn():
    global user
    if user == None:
        while True:
            username = input("Enter your username: ")
            password = input("Enter your password: ")

            user = bankManager.getUser(username)

            if user == [] or user[0]['password'] != password:
                try_again = input('Wrong credentials. Would you like to try again? <y/n>')
                while True:
                    user = None
                    if try_again.lower() == 'y':
                        break
                    elif try_again.lower() == 'n':
                        return False
            else:
                return True
    else:
        return False

def createBankAccount():
    print('''
    Which bank account would you like to create?

    1. Checking Account
    2. Savings Account
    3. Exit

    ''')
    while True:
        acc_choice = input('Select an option: ')
        if acc_choice.isdigit():
                acc_choice = int(acc_choice)

                if acc_choice >= 1 or acc_choice <= 3:
                    break
    
    if acc_choice == 1:
        bankManager.addCheckingAccount(user[0]['acc_id'], teller_info['teller_id'])
    elif acc_choice == 2:
        bankManager.addSavingsAccount(user[0]['acc_id'], teller_info['teller_id'])
    else:
        return

def deposit():
    print('Which bank account would you like to deposit into?')
    bacc_id = input('Enter bank account id: ')
    amount = input('Enter amount to be deposited: ')
    bankManager.depositAccount(int(bacc_id), int(amount))

def withdraw():
    print('Which bank account would you like to withdraw from?')
    bacc_id = input('Enter bank account id: ')
    amount = input('Enter amount to be withdrawn: ')
    bankManager.withdrawAccount(int(bacc_id), int(amount))

def transfer():
    bacc_from = input('Select account to transfer from:')
    bacc_to = input('Select account to transfer to: ')
    amount = input('Enter amount to be transfered: ')
    bankManager.transfer(int(bacc_from), int(bacc_to), int(amount))
    

def checkBalance():
    print('Which bank account would you like to check the balance of?')
    bacc_id = input('Enter bank account id: ')
    bankManager.checkBalance(int(bacc_id))

def signOut():
    global user
    user = None

def account_operation():
    global user
    while True:
        print('\n\nYour checking accounts: ')
        if bankManager.checkCheckingAccounts(user[0]['acc_id']):
            checkingAccounts = bankManager.getCheckingAccounts(user[0]['acc_id'])
            for account in checkingAccounts:
                print('Bank Account ID:', account['bacc_id'])
        else:
            print('None')

        print('\n\nYour savings accounts: ')
        if bankManager.checkSavingsAccounts(user[0]['acc_id']):
            savingsAccounts = bankManager.getSavingsAccounts(user[0]['acc_id'])
            for account in savingsAccounts:
                print('Bank Account ID:', account['bacc_id'])
        else:
            print('None')

        
        operations_prompt()

        while True:
            choice = input('Select an operation: ')
            if choice.isdigit():
                choice = int(choice)

                if choice >= 1 and choice <= 7:
                    break
        
        if choice == 1:
            createBankAccount()
        elif choice == 2:
            deposit()
        elif choice == 3:
            withdraw()
        elif choice == 4:
            transfer()
        elif choice == 5:
            checkBalance()
        else:
            signOut()
            break


###################################################################################
#                                                                                 #
#                               MENU #1                                           #
#                                                                                 #
###################################################################################

def prompt():
    print('''
    Menu:

    1. Create Account
    2. Login
    3. Exit

    ''')

def createAccount():
    while True:
        username = input("Enter a username: ")
        password = input("Enter a password: ")
        firstname = input("Enter your first name: ")
        lastname = input("Enter your last name: ")
        age = input("Enter your age: ")
        dob = input("Enter you date of birth (YYYY-MM-DD): ")
        if bankManager.checkUsername(username):
            bankManager.addUser(username, password, teller_info['teller_id'])
            print('\nYour account has been created!\n')
            break
        else:
            print('\nUsername is already taken. Try a different one.\n')



getTeller()
while True:
    prompt()
    while True:
        choice = input('Select an option: ')

        if choice.isdigit():
            choice = int(choice)

            if choice >= 1 or choice <= 3:
                break

    if choice == 1:
        createAccount()
    elif choice == 2:
        if signIn():
            account_operation()
    else:
        bankManager.closeDatabase()
        sys.exit(0)

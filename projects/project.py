import bank_api as bankManager

teller_info = None
user = None

def prompt():
    print('''
    Menu:

    1. Create Account
    2. Login

    ''')

def operations_prompt():
    print('''
    Operations:

    1. Create bank account
    2. Deposit
    3. Withdraw
    4. Transfer
    5. Check balance
    6. Check history
    7. Sign out

    ''')

def createAccount():
    global teller_info
    if teller_info == None:
        teller_info = bankManager.getTeller()

    print("\n\nHello, your bank teller today is", teller_info['employee_first_name'], teller_info['employee_last_name'] + '.\n\n')
    while True:
        username = input("Enter a username: ")
        password = input("Enter a password: ")
        if bankManager.checkUsername(username):
            bankManager.addUser(username, password, teller_info['teller_id'])
            print('\nYour account has been created!\n')
            break
        else:
            print('\nUsername is already taken. Try a different one.\n')

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
                    if try_again.lower() == 'y':
                        continue
                    elif try_again.lower() == 'n':
                        return False
            else:
                return True
    else:
        return False

def createBankAccount():
    pass

def deposit():
    pass

def Withdraw():
    pass

def transfer():
    pass

def checkBalance():
    pass

def checkHistory():
    pass

def signOut():
    pass

def account_operation():
    while True:
        operations_prompt()

        while True:
            choice = input('Select an operation: ')
            if choice.isdigit():
                choice = int(choice)

                if choice >= 1 and choice <= 7:
                    break
        
        if choice == 1:
            deposit()
        elif choice == 2:
            pass
        elif choice == 3:
            pass
        elif choice == 4:
            pass
        elif choice == 5:
            pass
        else:
            global user
            user = None
            break

bankManager.init()

while True:
    prompt()
    while True:
        choice = input('Select an option: ')

        if choice.isdigit():
            choice = int(choice)

            if choice == 1 or choice == 2:
                break

    if choice == 1:
        createAccount()
    if choice == 2:
        if signIn():
            account_operation()


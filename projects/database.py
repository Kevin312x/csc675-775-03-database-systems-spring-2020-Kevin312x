import mysql.connector

mydb = ''
cur = ''

config = {
    'host': 'csc675-finalproject.c9rxuqqvtijv.us-east-2.rds.amazonaws.com',
    'user': 'admin',
    'password': 'IYsSlqB6xbDCN9rjRmJ9',
    'database': 'banking_system'
}

mydb = mysql.connector.connect(**config)
if(mydb):
    cur = mydb.cursor(dictionary=True)
else:
    print('Failed to connect to database')
    exit()

def queryDatabase(query, params):
    results = []
    cur.execute(query, params)
    
    for res in cur:
        results.append(res)

    return results

def commitDatabase():
    mydb.commit()

def closeDatabase():
    mydb.close()
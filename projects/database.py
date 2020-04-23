import mysql.connector

mydb = ''
cur = ''

config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'password',
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
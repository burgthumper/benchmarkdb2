from datetime import timedelta
import time
import psutil
import mysql.connector


def HelloWorld():
    print('tsload Hello!!')

def getSQLConnection():
    cnx = mysql.connector.connect(user='root', password='edward', host='127.0.0.1', port='3307', database='benchmark_support')
    return cnx



#pull a random record from restaurant table capture the restaurant_id
#

def getSampleCPUData():
    returndata = {}

    # you can have the percentage of used RAM
    var_virtual_memory_pct = psutil.virtual_memory().percent
    #print(var_virtual_memory_pct)

    # you can calculate percentage of available memory
    var_virtual_memory_avail = psutil.virtual_memory().available * 100 / psutil.virtual_memory().total
    #print(var_virtual_memory_avail)

    var_cpu_percent = (psutil.cpu_percent(interval=0.01, percpu=False))
    var_cpu_percent# = (psutil.cpu_percent(interval=0.25, percpu=False))
    #print(var_cpu_percent)

    var_getloadavg = psutil.getloadavg()[0]
    #print(var_getloadavg)

    returndata['var_virtual_memory_pct'] = var_virtual_memory_pct
    returndata['var_virtual_memory_avail'] = var_virtual_memory_avail
    returndata['var_cpu_percent'] = var_cpu_percent
    returndata['var_getloadavg'] = var_getloadavg

    return returndata


def getRestaurantID(sqlConn):
    var_restaurant_id = 0
    cursor = sqlConn.cursor()
    query = ("SELECT restaurant_id FROM restaurants ORDER BY RAND() LIMIT 1;")
    cursor.execute(query)
    # print(cursor)
    for (the_record) in cursor:
        var_restaurant_id = the_record[0]
        #print(var_restaurant_id)
    cursor.close()

    return var_restaurant_id

def printElapsedTime(start, end):
    hours, rem = divmod(end - start, 3600)
    minutes, seconds = divmod(rem, 60)
    print("{:0>2}:{:0>2}:{:05.2f}".format(int(hours), int(minutes), seconds))

#This is the main function/method
def insertCPUValues():
    sqlConn = getSQLConnection()
    start_time = time.time()
    print('start time:' + str(start_time))
    #print(start_time)
    #approximately 4 records per second; 40000 records in ~2.75 hours
    #100000 loops produces 100000 records in 7.46 hours
    for x in range(100000):
        cursor = sqlConn.cursor()
        cpuData = getSampleCPUData()
        restaurant_id = getRestaurantID(sqlConn)
        #test table: sql_test
        query = ("INSERT INTO cpu "
                 "(restaurant_id,virtual_memory_percent,virtual_memory_avail,cpu_percent,getloadavg) "
                 "VALUES (%s, %s, %s, %s, %s);")
        queryValues = (restaurant_id,
                       cpuData['var_virtual_memory_pct'],
                       cpuData['var_virtual_memory_avail'],
                       cpuData['var_cpu_percent'],
                       cpuData['var_getloadavg'])
        cursor.execute(query, queryValues)
        cursor.close()
        if x % 5000 == 0:
            sqlConn.commit()

    end_time = time.time()
    elapsed_time = end_time - start_time
    print('Time to successfully add CPU data: ' + str(timedelta(seconds=elapsed_time)))
    #printElapsedTime(start_time,end_time)
    sqlConn.commit()
    sqlConn.close()

#print(getSampleCPUData())
#print('--------------')


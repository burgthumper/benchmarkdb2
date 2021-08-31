#import mysql.connector
import csv
import mysql
import time
from datetime import timedelta, datetime
from random import random
import random


def HelloWorld():
    print('tsload Hello!!')

#def getSQLConnection():
#    cnx = mysql.connector.connect(user='edward', password='edward', host='192.168.1.229', database='benchmarkmysql')
#    return cnx
def getSQLConnection():
    cnx = mysql.connector.connect(user='root', password='edward', host='127.0.0.1', port='3307', database='benchmark_support')
    return cnx


i = 'int'
d = 'date'
dt = 'datetime'
v = 'varchar'
d = 'decimal'
t = 'text'
f = 'float'

def setCPUTypes():
    cpu_types = {}
    cpu_types['ts'] = dt
    cpu_types['ts_insert'] = dt
    cpu_types['restaurant_id'] = v
    cpu_types['virtual_memory_percent'] = f
    cpu_types['virtual_memory_avail'] = f
    cpu_types['cpu_percent'] = f
    cpu_types['getloadavg'] = f

    #keys = list(coupon_issued_types.keys())
    #print('key0: ', keys[0])

    #for i in range(len(keys)):
    #    print('key.i: ', keys[i])
    #    print('value: ', coupon_issued_types[keys[i]])

    return cpu_types


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


def trimTop(value):
    if value >= 100:
        value = 100

    return value


def getFakeCPUData():
    #returndata = {}
    data = []

    # you can have the percentage of used RAM
    value = round(random.uniform(0,100), 4)
    data.append(trimTop(value))
    #var_virtual_memory_pct = psutil.virtual_memory().percent
    #print(var_virtual_memory_pct)

    # you can calculate percentage of available memory
    value = round(random.uniform(0,100), 4)
    data.append(trimTop(value))
    #var_virtual_memory_avail = psutil.virtual_memory().available * 100 / psutil.virtual_memory().total
    #print(var_virtual_memory_avail)

    value = round(random.uniform(0,100), 4)
    data.append(trimTop(value))
    #var_cpu_percent = (psutil.cpu_percent(interval=0.25, percpu=False))
    #print(var_cpu_percent)

    value = round(random.uniform(0,100), 4)
    data.append(trimTop(value))
    #var_getloadavg = round(random.uniform(1,2), 4)
    #var_getloadavg = psutil.getloadavg()[0]
    #print(var_getloadavg)

    #returndata['var_virtual_memory_pct'] = var_virtual_memory_pct
    #returndata['var_virtual_memory_avail'] = var_virtual_memory_avail
    #returndata['var_cpu_percent'] = var_cpu_percent
    #returndata['var_getloadavg'] = var_getloadavg

    return data


#Drives process
def create_inserts_cpu_data(max_lines, batch_number):
    start_time_job = time.time()
    print('Begin creation of fake CPU data INSERTS; Job start time: ' + str(datetime.fromtimestamp(start_time_job).strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]))
    for bn in range(batch_number):
        start_time_file = time.time()
        name_time = str(datetime.fromtimestamp(start_time_file).strftime('%Y%m%d.%H%M%S.%f')[:-3])
        file_out_name = 'inserts_fake_cpu_' + str(max_lines) + '_' + name_time + '.sql'
        create_inserts(max_lines, file_out_name)
        elapsed_time_file = time.time() - start_time_file
        print(file_out_name + ' was created in: ' + str(timedelta(seconds=elapsed_time_file)) + ' (H:MM:SS.MS).')
    elapsed_time = time.time() - start_time_job
    print('Job completed in: ' + str(timedelta(seconds=elapsed_time)) + ' (H:MM:SS.MS).')


def create_inserts(max_lines, file_out_name):
    file_out_name_pg = 'pg_' + file_out_name
    file_out_name_mysql = 'mysql_' + file_out_name

    fw_pg = open("outputData/" + file_out_name_pg, "w+")
    fw_mysql = open("outputData/" + file_out_name_mysql, "w+")
    sqlConn = getSQLConnection()
    cpu_types = setCPUTypes()
    for x in range(max_lines):
        line = []
        ts_insert = str(datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S.%f')[:-3])
        restaurant_id = str(getRestaurantID(sqlConn))
        cpuData = getFakeCPUData()
        line.append(ts_insert)
        line.append(restaurant_id)
        line.append(str(cpuData[0]))
        line.append(str(cpuData[1]))
        line.append(str(cpuData[2]))
        line.append(str(cpuData[3]))
        fields_pg = spin_out_fields(cpu_types, 'pg')
        fields_mysql = spin_out_fields(cpu_types, 'mysql')
        values = spin_out_values(line, cpu_types)
        insert_sql_pg = "INSERT INTO cpu (" + fields_pg + ") VALUES (" + values + ");\n"
        insert_sql_mysql = "INSERT INTO cpu (" + fields_mysql + ") VALUES (" + values + ");\n"
        fw_pg.write(insert_sql_pg)
        fw_mysql.write(insert_sql_mysql)
    fw_pg.close()
    fw_mysql.close()


def spin_out_fields(dict, db):
    fields = ""
    tick = ""
    if(db=='mysql'):
        tick = "`"
    cnt=0
    loop_count = len(dict)-1
    for key in dict:
        comma = ", "
        if(cnt==loop_count):
            comma = ""
        if cnt > 0:
            fields += tick + key + tick + comma
        cnt += 1

    return fields


def spin_out_values(line, dict):
    keys = list(dict.keys())
    index = 0
    values_string = ''
    for ele in line:
        tick = "'"
        if (dict[keys[index]] == 'int' or ele == 'NULL'):
            tick = ""
        comma = ","
        if(index==(len(line)-1)):
            comma = ""
        values_string += tick + ele + tick + comma
        index += 1

    return values_string


#import mysql.connector
import csv
import time
from datetime import timedelta


def HelloWorld():
    print('tsload Hello!!')

#def getSQLConnection():
#    cnx = mysql.connector.connect(user='edward', password='edward', host='192.168.1.229', database='benchmarkmysql')
#    return cnx


i = 'int'
d = 'date'
dt = 'datetime'
v = 'varchar'
d = 'decimal'
t = 'text'

def setFieldTypes_CouponIssued():
    coupon_issued_types = {}
    coupon_issued_types['id'] = i
    coupon_issued_types['serial'] = i
    coupon_issued_types['secret'] = v
    coupon_issued_types['is_burnable'] = i
    coupon_issued_types['expiration'] = dt
    coupon_issued_types['incipience'] = dt
    coupon_issued_types['overall_use_count'] = i
    coupon_issued_types['period_use_count'] = i
    coupon_issued_types['last_use_timestamp'] = dt
    coupon_issued_types['last_action'] = v
    coupon_issued_types['tracked_use_count'] = i
    coupon_issued_types['last_tracked_timestamp'] = dt
    coupon_issued_types['tracked_active_until'] = dt
    coupon_issued_types['available_redemptions'] = i
    coupon_issued_types['last_redemption_earned'] = dt
    coupon_issued_types['last_number_of_redemptions_applied'] = i
    coupon_issued_types['number_of_redemptions_earned_in_time_period'] = i
    coupon_issued_types['last_apply_amount'] = d
    coupon_issued_types['registration_timestamp'] = dt
    coupon_issued_types['user_reference_id'] = v
    coupon_issued_types['is_deactivated'] = i
    coupon_issued_types['has_received_registration_reward'] = i
    coupon_issued_types['campaign_id'] = i
    coupon_issued_types['coupon_short_id'] = v
    coupon_issued_types['coupon_barcode'] = v
    coupon_issued_types['first_transaction_timestamp'] = dt

    #keys = list(coupon_issued_types.keys())
    #print('key0: ', keys[0])

    #for i in range(len(keys)):
    #    print('key.i: ', keys[i])
    #    print('value: ', coupon_issued_types[keys[i]])

    return coupon_issued_types


def setFieldTypes_CouponTransaction():
    coupon_transaction_types = {}
    coupon_transaction_types['id'] = i
    coupon_transaction_types['type'] = v
    coupon_transaction_types['status'] = i
    coupon_transaction_types['utc_timestamp'] = dt
    coupon_transaction_types['coupon_id'] = i
    coupon_transaction_types['coupon_serial'] = i
    coupon_transaction_types['pos_token'] = v
    coupon_transaction_types['pos_restaurant'] = v
    coupon_transaction_types['pos_terminal'] = v
    coupon_transaction_types['pos_operator'] = v
    coupon_transaction_types['pos_transid'] = v
    coupon_transaction_types['pos_timestamp'] = dt
    coupon_transaction_types['pos_language'] = v
    coupon_transaction_types['coupon_code_raw'] = v
    coupon_transaction_types['coupon_code'] = v
    coupon_transaction_types['coupon_secret_hash'] = v
    coupon_transaction_types['coupon_expiration_hash'] = v
    coupon_transaction_types['basket_type'] = v
    coupon_transaction_types['basket_items'] = t
    coupon_transaction_types['basket_coupon_amount'] = d
    coupon_transaction_types['basket_coupon_retail_amount'] = d
    coupon_transaction_types['basket_taxes'] = d
    coupon_transaction_types['basket_total'] = d
    coupon_transaction_types['basket_discounted_plu'] = v
    coupon_transaction_types['basket_discounted_category'] = v

    #keys = list(coupon_issued_types.keys())
    #print('key0: ', keys[0])

    #for i in range(len(keys)):
    #    print('key.i: ', keys[i])
    #    print('value: ', coupon_issued_types[keys[i]])

    return coupon_transaction_types




def create_inserts(table, dbs, max_lines):
    #how to get it to: yyyymmdd.hh.mm.ss | could be used to not overwrite previous written files
    #also print out runtime
    #start_time = now()
    for db in dbs:
        if(table==('coupon_issued') or table==('both')):
            coupon_issued_types = setFieldTypes_CouponIssued()
            create_inserts_coupon_issued(coupon_issued_types, db, max_lines)
        if(table==('coupon_transaction') or table==('both')):
            coupon_transaction_types = setFieldTypes_CouponTransaction()
            create_inserts_coupon_transaction(coupon_transaction_types, db, max_lines)


def getCouponIssuedFileName():
    files = ['data_coupon_issued.a.csv','data_coupon_issued.b.csv','data_coupon_issued.c.csv']
    return files


def create_inserts_coupon_issued(coupon_issued_types, db, max_lines):
    file_out_name = db + '_inserts_coupon_issued_' + str(max_lines) + '.sql'
    fw = open("outputData/" + file_out_name, "w+")
    #fw = open("outputData/inserts_coupon_issued.sql", "w+")
    #fw.write("Woops! I have added the content!\n")
    start_time = time.time()
    for file in getCouponIssuedFileName():
        with open('Data/' + file) as openfileobject:
            csv_coupons = csv.reader(openfileobject)
            #print('test print1', openfileobject)
            index = 0
            for line in csv_coupons:
                if(index>0):
                    #print(line)
                    print(type(line))
                    values = spin_out_values(line, coupon_issued_types)
                    fields = spin_out_fields(coupon_issued_types, db)
                    insert_sql = "INSERT INTO coupon_issued (" + fields + ") VALUES (" + values + ");\n"
                    #print(insert_sql)
                    fw.write(insert_sql)
                    if (index == max_lines):
                        break
                index += 1
        print(file_out_name + ' was successfully built and completed.')
    fw.close()
    end_time = time.time()
    elapsed_time = end_time - start_time
    print('Time to create INSERT file: ' + str(timedelta(seconds=elapsed_time)))


def create_inserts_coupon_transaction(coupon_transaction_types, db, max_lines):
    file_out_name = db + '_inserts_coupon_transaction_' + str(max_lines) + '.sql'
    fw = open("outputData/" + file_out_name, "w+")
    with open('Data/data_coupon_transaction.csv') as openfileobject:
        csv_coupons = csv.reader(openfileobject)
        #print('test print2', openfileobject)
        index = 0
        for line in csv_coupons:
            if(index>0):
                #print(line)
                values = spin_out_values(line, coupon_transaction_types)
                fields = spin_out_fields(coupon_transaction_types, db)
                insert_sql = "INSERT INTO coupon_transaction (" + fields + ") VALUES (" + values + ");\n"
                #print('test print2b', insert_sql)
                #print(max_lines)
                fw.write(insert_sql)
                if(index == max_lines):
                    break
            index += 1
        print(file_out_name + ' was successfully built and completed.')
    fw.close()


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
        fields += tick + key + tick + comma
        cnt += 1

    return fields


def spin_out_values(line, dict):
    keys = list(dict.keys())
    index = 0
    values_string = ''
    count=0
    for ele in line:
        tick = "'"
        if(index>=0):
            if (dict[keys[count]] == 'int' or ele == 'NULL'):
                tick = ""
            comma = ","
            if(index==(len(line)-1)):
                comma = ""
            values_string += tick + ele + tick + comma
            count += 1
        index += 1

    return values_string



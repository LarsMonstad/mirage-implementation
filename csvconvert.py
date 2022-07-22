import csv
import sys
#script to convert csv to ann
#extracting the 1(onset), 2(offset), 3(onpitch) and 5(essential) column.
#taking command line as input
#Run the script with the following command: python csvconvert.py test.csv > test.ann 
csvfile = open(sys.argv[1], newline='')

c = csv.DictReader(csvfile)

headers = c.fieldnames

itercars = iter(c)
for row in itercars:
    #converting string to float and then round up the decimals and seperate with a tab(sep='\t')
    print(round(float(row[headers[0]]),3),round(float(row[headers[1]]),3),round(float(row[headers[2]]), 2),int(float(row[headers[4]])),sep='\t')
csvfile.close()

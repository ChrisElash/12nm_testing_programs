#! /usr/bin/python
############################################################
'''
Created by Christopher Elash in September 2021 Originally Named "22nm_RO_Tester_NEW.py"
Modified to work with the 12nm RO by Dylan Lambert in March 2023 now named "12nm_RO_Tester.py"

This test program is meant for the 12nm FDSOI test chip and will test the chips 
SRAM and test the chips clock generator.

Please read any further documentation provided with this code to gain a better of understanding of how it works.
Also ensure that the FPGA and testboard are properly set up before running this test.
'''
############################################################

CLOCK_PERIOD = 0.000001  # The period for the clocking of the system. Seems stable at 1 MHz

import time
import RPi.GPIO as GPIO
import sys

# Setup for all the GPIO pins

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD) # use the actual pin number 
GPIO.setup(31, GPIO.OUT, initial = GPIO.HIGH) # the reset for the counters for the RO frequency measurement
GPIO.setup(33, GPIO.OUT, initial = GPIO.LOW) # the data clk to get the counter data from the ROs
GPIO.setup(35, GPIO.IN) # the data out for the counters of the RO test

"""
Converts a binary numbary to an equivlant decimal.

n: a number in binary

Returns: nothing
"""  
def binaryToDecimal(n):
    return int(n,2)



"""
Takes in a number in seconds and outputs array of days, hours, minutes, and seconds

n: a number in seconds

Returns: array of days, hours, minutes, and seconds elapsed
"""  
def timeElapsed(seconds):
    time_elapsed = [0, 0, 0, 0]
    
    seconds_in_day = 60*60*24
    seconds_in_hour = 60*60
    seconds_in_minute = 60
    
    
    days = seconds // seconds_in_day
    hours = (seconds -  (days*seconds_in_day)) // seconds_in_hour
    minutes = (seconds - (days * seconds_in_day) - (hours*seconds_in_hour)) // seconds_in_minute
    seconds_remaining = int(seconds % 60)
    
    time_elapsed = [days, hours, minutes, seconds_remaining]
    return time_elapsed


"""
Sends a clock pulse to the RO data out clk

Returns: nothing
"""
def clockDataRO():
    GPIO.output(33, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(33, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)


"""
Returns a list containing the frequencies of the ROs in MHz.
0 - Inverter
1 - NAND
2 - NOR
3 - CLK
Returns: list of frequencies for the ROs
"""
def getROData():

    # variables for frequencies
    frequencies = ['', '', '', '']
    INV_freq = 0
    NAND_freq = 0
    NOR_freq = 0
    CLK_freq = 0

    # to hold the 32 bits for each counter
    INV_count_bits = ''
    NAND_count_bits = ''
    NOR_count_bits = ''
    CLK_count_bits = ''

    #read the counter for the inverter RO
    for i in range(32):
        clockDataRO() # clock the next bit in
        if (GPIO.input(35)):
            INV_count_bits = '1' + INV_count_bits
        else:
            INV_count_bits = '0' + INV_count_bits
        
    # now convert from binary to int
    INV_count_int = int(INV_count_bits, 2)

    # calculate the frequency in MHz
    INV_freq = (INV_count_int / 0.1) / 1E6


    #read the counter for the NAND RO
    for i in range(32):
        clockDataRO() # clock the next bit in
        if (GPIO.input(35)):
            NAND_count_bits = '1' + NAND_count_bits
        else:
            NAND_count_bits = '0' + NAND_count_bits
        
    
    # now convert from binary to int
    NAND_count_int = int(NAND_count_bits, 2)

    # calculate the frequency in MHz
    NAND_freq = (NAND_count_int / 0.1) / 1E6


    #read the counter for the NOR RO
    for i in range(32):
        clockDataRO() # clock the next bit in
        if (GPIO.input(35)):
            NOR_count_bits = '1' + NOR_count_bits
        else:
            NOR_count_bits = '0' + NOR_count_bits
        
    
    # now convert from binary to int
    NOR_count_int = int(NOR_count_bits, 2)

    # calculate the frequency in MHz
    NOR_freq = (NOR_count_int / 0.1) / 1E6


    #read the counter for the CLK GEN
    for i in range(32):
        clockDataRO() # clock the next bit in
        if (GPIO.input(35)):
            CLK_count_bits = '1' + CLK_count_bits
        else:
            CLK_count_bits = '0' + CLK_count_bits
        
    
    # now convert from binary to int
    CLK_count_int = int(CLK_count_bits, 2)

    # calculate the frequency in MHz
    CLK_freq = (CLK_count_int / 0.1) / 1E6
    
    # now load the list and return
    frequencies[0] = INV_freq
    frequencies[1] = NAND_freq
    frequencies[2] = NOR_freq
    frequencies[3] = CLK_freq

    return frequencies



if __name__ == '__main__':

    # open up files to save the test data with start time in name
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    StartTime_File = str(StartTime).replace(':','-')
    ro_file = open("/home/pi/Desktop/%s-RO_Test.txt" %(StartTime_File),"w")
    
    time_elapsed_start = time.time()


    
    GPIO.setwarnings(False)
    time.sleep(0.5)
    print("  _____   ____    _______ ______  _____ _______ ______ _____  ")
    print(" |  __ \ / __ \  |__   __|  ____|/ ____|__   __|  ____|  __ \ ")
    print(" | |__) | |  | |    | |  | |__  | (___    | |  | |__  | |__) |")
    print(" |  _  /| |  | |    | |  |  __|  \___ \   | |  |  __| |  _  / ")
    print(" | | \ \| |__| |    | |  | |____ ____) |  | |  | |____| | \ \ ")
    print(" |_|  \_\\____/     |_|  |______|_____/   |_|  |______|_|  \_\\")
    print("                                                          ")
    print("                                                          ")
    time.sleep(0.5)
    print("Welcome to the 22nm FDSOI RO Teseter\n")
    print ("Press 'CTRL+C' when done testing to terminate")
    time.sleep(1)

    #show the local time
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    print("The beginning time: ", StartTime)
    data_string_write = "The beginning time: " + StartTime + "\n"
    ro_file.write(data_string_write)

    time.sleep(0.5)

    print("Beginning to read results")

    while True:
        try:

            # now do the testing for the ROs
            inv_selects = [0, 0, 0, 0]
            nand_selects = [0, 0, 0, 0]
            nor_selects = [0, 0, 0 ,0]
            clk_selects = [0, 0, 0 ,0]

            for i in range(4):
            
                # first reset the counters, the freq select line should start at 00
                GPIO.output(31, GPIO.LOW) # reset signal
                time.sleep(CLOCK_PERIOD)
                GPIO.output(31, GPIO.HIGH)

                time.sleep(0.15) # give time for counters to count then stop
                # now read the data from the ROs
                RO_data = getROData()

                inv_selects[i] = RO_data[0]
                nand_selects[i] = RO_data[1]
                nor_selects[i] = RO_data[2]
                clk_selects[i] = RO_data[3]
                
                time.sleep(0.01)
            
            # now print out and log the data
                

            # inverter frequency
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " Inverter RO Frequencies: " + str(inv_selects[0]) + ', ' + str(inv_selects[1]) + ', ' + str(inv_selects[2]) + ', ' + str(inv_selects[3]) + " MHz"
            data_string_write = CurrentTime + " Inverter RO Frequencies: " + str(inv_selects[0]) + ', ' + str(inv_selects[1]) + ', ' + str(inv_selects[2]) + ', ' + str(inv_selects[3]) + " MHz" + "\n"
            print(data_string_print)
            ro_file.write(data_string_write)
            
            # nand frequency
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " NAND RO Frequencies: " + str(nand_selects[0]) + ', ' + str(nand_selects[1]) + ', ' + str(nand_selects[2]) + ', ' + str(nand_selects[3]) + " MHz"
            data_string_write = CurrentTime + " NAND RO Frequencies: " + str(nand_selects[0]) + ', ' + str(nand_selects[1]) + ', ' + str(nand_selects[2]) + ', ' + str(nand_selects[3]) + " MHz" + "\n"
            print(data_string_print)
            ro_file.write(data_string_write)

            # nor frequency
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " NOR RO Frequencies: " + str(nor_selects[0]) + ', ' + str(nor_selects[1]) + ', ' + str(nor_selects[2]) + ', ' + str(nor_selects[3]) + " MHz"
            data_string_write = CurrentTime + " NOR RO Frequencies: " + str(nor_selects[0]) + ', ' + str(nor_selects[1]) + ', ' + str(nor_selects[2]) + ', ' + str(nor_selects[3]) + " MHz" + "\n"
            print(data_string_print)
            ro_file.write(data_string_write)

            # clock gen frequency
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " CLK GEN Frequencies: " + str(clk_selects[0]) + ', ' + str(clk_selects[1]) + ', ' + str(clk_selects[2]) + ', ' + str(clk_selects[3]) + " MHz"
            data_string_write = CurrentTime + " CLK GEN Frequencies: " + str(clk_selects[0]) + ', ' + str(clk_selects[1]) + ', ' + str(clk_selects[2]) + ', ' + str(clk_selects[3]) + " MHz" + "\n"
            print(data_string_print)
            ro_file.write(data_string_write)
            
            # time elapsed
            time_elapsed_now = time.time() - time_elapsed_start
            elapsed = timeElapsed(time_elapsed_now)
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s "
            data_string_write = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s " + "\n"
            print(data_string_print)
            ro_file.write(data_string_write)

            print("\n")
            time.sleep(1)


        except KeyboardInterrupt:   # if user presses CTRL+C end the testing
            print("Ending Testing")
            ro_file.close()
            sys.exit()
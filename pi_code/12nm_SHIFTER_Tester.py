#! /usr/bin/python
############################################################
'''
Created by Christopher Elash for 22nm in September 2021 and Modifed for 12nm by Dylan Lambert March/April 2023

This test program is meant for the 12nm test chip and will test the chips 
shifter circuits for SEUs.

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
GPIO.setup(23, GPIO.OUT, initial = GPIO.LOW) # the save pin for collecting the error registers (posedge)
GPIO.setup(19, GPIO.OUT, initial = GPIO.LOW) # the data clk to get the counter data from the dffs
GPIO.setup(15, GPIO.IN) # the data out for the counters of the dff

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
def clockDataSHIFTER():
    GPIO.output(19, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(19, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)


"""
Returns a list containing the frequencies of the ROs in MHz.
0 - Inverter
1 - NAND
2 - NOR

Returns: list of frequencies for the ROs
"""
def getDFFData():

    # variables for error count
    error_count = 0
    

    # to hold the 12 bits for each counter
    error_count_bits = ''
    

    #read the counter for the chain of 12 bits
    for i in range(12):
        clockDataSHIFTER() # clock the next bit in
        if (GPIO.input(15)):
            error_count_bits = '1' + error_count_bits
        else:
            error_count_bits = '0' + error_count_bits
        
    
    # now convert from binary to int
    error_count = int(error_count_bits, 2)


    return error_count



if __name__ == '__main__':

    # open up files to save the test data with start time in name
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    StartTime_File = str(StartTime).replace(':','-')
    shifter_file = open("/home/pi/Desktop/%s-Shifter_Test.txt" %(StartTime_File),"w")
    
    time_elapsed_start = time.time()


    
    GPIO.setwarnings(False)
    time.sleep(0.5)
    print("   _____ _    _ _____ ______ _______ ______ _____   ")
    print("  / ____| |  | |_   _|  ____|__   __|  ____|  __ \  ")
    print(" | (___ | |__| | | | | |__     | |  | |__  | |__) | ")
    print("  \___ \|  __  | | | |  __|    | |  |  __| |  _  /  ")
    print("  ____) | |  | |_| |_| |       | |  | |____| | \ \  ")
    print(" |_____/|_|_ |_|_____|_|__ ____|_| _|______|_|_ \_\ ")
    print("    |__   __|  ____|/ ____|__   __|  ____|  __ \    ")
    print("       | |  | |__  | (___    | |  | |__  | |__) |   ")
    print("       | |  |  __|  \___ \   | |  |  __| |  _  /    ")
    print("       | |  | |____ ____) |  | |  | |____| | \ \    ")
    print("       |_|  |______|_____/   |_|  |______|_|  \_\   ")
    print("                                                    ")
    time.sleep(0.5)
    print("Welcome to the 12nm FDSOI Shifter Circuit Tester\n")
    print ("Press 'CTRL+C' when done testing to terminate")
    time.sleep(1)

    #show the local time
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    print("The beginning time: ", StartTime)
    data_string_write = "The beginning time: " + StartTime + "\n"
    shifter_file.write(data_string_write)

    time.sleep(0.5)

    print("Beginning to read results")

    while True:
        try:

            # do testing for the shifter circuits
            count_output0 = []
            count_output1 = []

            
            # first save the counter data
            GPIO.output(23, GPIO.HIGH) # reset signal
            time.sleep(CLOCK_PERIOD)
            GPIO.output(23, GPIO.LOW)

            for i in range(2): # 2 Shifters, Chip 0 is outputted first
                error_count_shift = getDFFData()
                count_output0.append(error_count_shift)
                
            # now print out and log the data
                
            for i in range(2): # 2 Shifters, Chip 1 is outputted second
                error_count_shift = getDFFData()
                count_output1.append(error_count_shift)
                
            # now print out and log the data
            
            # SEU Count
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + ' ' + 'Chip 0 [Shifter0, Shifter1]: ' + str(count_output0)
            data_string_write = CurrentTime + ' ' + 'Chip 0 [Shifter0, Shifter1]: ' + str(count_output0) + "\n"
            print(data_string_print)
            shifter_file.write(data_string_write)

            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + ' ' + 'Chip 1 [Shifter0, Shifter1]: ' + str(count_output1)
            data_string_write = CurrentTime + ' ' + 'Chip 1 [Shifter0, Shifter1]: ' + str(count_output1) + "\n"
            print(data_string_print)
            shifter_file.write(data_string_write)
            
            time.sleep(0.5)


        except KeyboardInterrupt:   # if user presses CTRL+C end the testing
            time_elapsed_now = time.time() - time_elapsed_start
            elapsed = timeElapsed(time_elapsed_now)
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s "
            data_string_write = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s " + "\n"
            print(data_string_print)
            shifter_file.write(data_string_write)
            print("Ending Testing")
            shifter_file.close()
            sys.exit()

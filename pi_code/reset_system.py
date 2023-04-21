#! /usr/bin/python
############################################################
'''
Created by Christopher Elash in September 2021 and modified for 12nm by Dylan Lambert in March/April 2023

This test program is meant for the 22nm FDSOI test chip and will reset all the programs

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
GPIO.setup(5, GPIO.OUT, initial = GPIO.LOW) # top level reset
GPIO.setup(33, GPIO.OUT, initial = GPIO.LOW) # data clock RO
GPIO.setup(19, GPIO.OUT, initial = GPIO.LOW) # data clock SHIFTER
GPIO.setup(8, GPIO.OUT, initial = GPIO.LOW) # the data clk to get the counter data from the dffs






if __name__ == '__main__':

    print('resetting system...')
    time.sleep(0.1)
    
    # now reset the system to clear any data currently there
    GPIO.output(5, GPIO.HIGH)
    
    GPIO.output(33, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(33, GPIO.LOW)
    
    GPIO.output(8, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(8, GPIO.LOW)

    GPIO.output(19, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(19, GPIO.LOW)

    GPIO.output(5, GPIO.LOW)
    
    time.sleep(0.1)

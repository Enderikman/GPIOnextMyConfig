#!/usr/bin/env python3

import RPi.GPIO as GPIO
import os
import time

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, GPIO.PUD_DOWN)

switchMode = 0

#switchmode = 0 -> 1 controller
#switchmode = 1 -> 2 controller


os.system('gpionext2 stop')
try:
  while True:
  	if GPIO.input(18) == True:
  		if switchmode == 0:
		    os.system('gpionext1 stop')
			os.system('gpionext2 start')
		else:
			os.system('gpionext2 stop')
			os.system('gpionext1 start')
	time.sleep(0.07)
except KeyboardInterrupt:
  GPIO.cleanup() 


echo Running at boot 
sudo python /GPIOnextMyConfig/ControllerSetter.py

#!/usr/bin/python
import time, random
from selenium import webdriver
import selenium.webdriver.chrome.service as service

while True:
	try:
		driver = webdriver.Chrome('C:\\Users\\IEUser\\chromedriver.exe')  # Optional argument, if not specified will search path.
		driver.get('http://' + random.choice(open('urls.csv').readlines()).rstrip('\n'));
		time.sleep(5) # Let the user actually see something!
		driver.quit()
	except: pass



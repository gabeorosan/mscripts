from selenium import webdriver
from selenium.webdriver.common.by import By
import time

options = webdriver.ChromeOptions()
prefs = {"download.default_directory" : "vpscrape/getvirions/capsids/"}
options.add_experimental_option("prefs",prefs)
driver = webdriver.Chrome(executable_path='./chromedriver',options=options)

base_url = 'https://viperdb.scripps.edu/Info_Page.php?VDB='
for id in pdb_ids:
    try:
        res = driver.get(base_url + id)
        while True:
            try:
                dlds = driver.find_element(By.ID, "btn-downloads")
                dlds.click()
                dlbtn = driver.find_element(By.LINK_TEXT, "VIPER Coordinates")
                dlbtn.click()
                time.sleep(1)
                break
            except:
                break
    except Exception as e:
        print(e)
driver.close()

import subprocess
subprocess.check_call(['./pdb.sh', 'capsids'])

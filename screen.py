import time
import secrets
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def main():
    #Use for mac/linux
    # driver = webdriver.Chrome('./chromedriver')

    # Use for Windows
    driver = webdriver.Chrome('./chromedriver.exe')


    esxiServer= [ ["crooky", "3"], 
    ["faye", "4"], 
    ["bobbin", "5"], 
    ["xserve1", "6"],
     ["xserve2", "7"],
    ["vdi01", "8"] ]

    freeNasServer= [ ["arete", "10"], ["sprio", "18"] ]

    synologyServer= [ ["togo", "15"], ["alma", "20"] ] 

    
    # for x in range(len(freeNasServer)):
    #     driver = freeNas(driver, freeNasServer[x][0], freeNasServer[x][1])
    

    # driver = panasas(driver)
    # driver = avere(driver)
    # for x in range(len(esxiServer)):
    #     driver = esxi(driver, esxiServer[x][0], esxiServer[x][1])
    driver = synology(driver, 'togo', '15')
    # for x in range (len(synologyServer)):
    #     driver = synology(driver, synologyServer[x][0], synologyServer[x][1])
   
    # driver.quit()

def panasas(driver):
     #Logs into panasas admin portal.  Grabs screenshots of main page, storage and hdd health.
    driver.get('http://10.26.62.50/login')
    driver.find_element_by_name("loginName").send_keys("admin")
    driver.find_element_by_name("loginPassword").send_keys("tlnsn!")
    driver.find_element_by_xpath('//*[@id="sidebar"]/div[1]/div/div/div[2]/form/div/div[2]/input').click()
    time.sleep(2)
    driver.save_screenshot('./log/panasas/panasas_main.png')

    driver.get("https://10.26.62.50/html/monitoring/data_detail.htm")
    driver.execute_script("window.scrollTo(0, 200)") 
    driver.save_screenshot('./log/panasas/panasas_storage1.png')
    driver.execute_script("window.scrollTo(0, 1080)") 
    driver.save_screenshot('./log/panasas/panasas_storage2.png')

    driver.get("https://10.26.62.50/html/monitoring/driveStats.htm")
    driver.save_screenshot('./log/panasas/panasas_hdd1.png')
    driver.execute_script("window.scrollTo(0, 700)") 
    driver.save_screenshot('./log/panasas/panasas_hdd2.png')
    driver.execute_script("window.scrollTo(0, 1100)") 
    driver.save_screenshot('./log/panasas/panasas_hdd3.png')
    driver.execute_script("window.scrollTo(0, 2000)") 
    driver.save_screenshot('./log/panasas/panasas_hdd4.png')

    return driver

def avere(driver):
    driver.get('http://10.26.62.145/fxt/login.php')
    driver.find_element_by_name("user").send_keys(secrets.username)
    driver.find_element_by_id("password").send_keys(secrets.password)
    driver.find_element_by_name("OK").click()
    time.sleep(2)

    driver.save_screenshot('./log/avere/conditions1.png')
    driver.execute_script("window.scrollTo(0,1080)")
    driver.save_screenshot('./log/avere/conditions2.png')
    driver.find_element_by_xpath('//*[@id="wrap"]/div[4]/div[3]/ul/li[2]/a').click()

    driver.execute_script("window.scrollTo(0,300)")
    driver.save_screenshot('./log/avere/alert1.png')
    driver.execute_script("window.scrollTo(0,600)")
    driver.save_screenshot('./log/avere/alert2.png')
    return driver

def esxi(driver, server, ip):
    
    driver.get('http://10.26.62.' + ip)
    time.sleep(2)
    driver.find_element_by_id('username').send_keys(secrets.esxiUname)
    if ("sever" == "vdi01"):
        driver.find_element_by_id('password').send_keys(secrets.vdiPass)
    else:
        driver.find_element_by_id('password').send_keys(secrets.esxiPword)
    driver.find_element_by_id('submit').click()
    time.sleep(4)

    driver.save_screenshot('./log/' + server + '/serverHealth.png')

    driver.get('http://10.26.62.'+ ip + '/ui/#/host/vms')
    time.sleep(7)
    driver.save_screenshot('./log/'+ server + '/vmStatus.png')
    driver.get('http://10.26.62.' + ip + '/ui/#/host/storage/devices')
    time.sleep(7)
    driver.save_screenshot('./log/' + server + '/storage.png')
    
    return driver


def freeNas(driver, server, ip):
    
    driver.get('http://10.26.62.'+ ip)
    time.sleep(2)
    driver.find_element_by_css_selector('#mat-input-0').send_keys(secrets.freeNasUname)
    driver.find_element_by_css_selector('#mat-input-1').send_keys(secrets.freeNasPword)
    driver.find_element_by_id('signin_button').click()
    driver.save_screenshot('./log/' + server +'/dashboard1.png')
    driver.execute_script("window.scrollTo(0,600)")
    driver.save_screenshot('./log/' + server +'/dashboard2.png')
    
    return driver
    

def synology(driver, server, ip):
    driver.implicitly_wait(3)
    driver.get('http://10.26.62.'+ ip +':5000')
    time.sleep(5)
    driver.find_element_by_css_selector('#login_passwd').click()
    driver.find_element_by_css_selector('#login_username').send_keys(secrets.synologyUname)
    driver.find_element_by_css_selector('#login_passwd').send_keys(secrets.synologyPword)
    driver.find_element_by_id('login-btn').click()

    time.sleep(5)
    # driver.find_element_by_xpath('//*[@id="ext-gen210"]').click()
    # time.sleep(2)
    # driver.find_element_by_xpath('//*[@id="ext-gen198"]').click()
    # time.sleep(15)
    # driver.save_screenshot('./log/'+server+'/overview.png')

    driver.find_element_by_xpath('//*[@id="ext-gen210"]').click()
    time.sleep(2)
    driver.find_element_by_css_selector('#ext-gen199').click()
    time.sleep(1)
    driver.save_screenshot('./log/'+ server + 'drive1.png')
    driver.find_element_by_css_selector('#ext-gen1336 > div > li:nth-child(3)').click()


main()










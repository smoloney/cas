import time
import secrets
from selenium import webdriver

driver = webdriver.Chrome('./chromedriver')
# driver.get('http://10.26.62.50/login')
# driver.find_element_by_name("loginName").send_keys("admin")
# driver.find_element_by_name("loginPassword").send_keys("tlnsn!")
# driver.find_element_by_xpath('//*[@id="sidebar"]/div[1]/div/div/div[2]/form/div/div[2]/input').click()
# time.sleep(2)
# driver.save_screenshot('./log/panasas/panasas_main.png')

# driver.get("https://10.26.62.50/html/monitoring/data_detail.htm")
# driver.execute_script("window.scrollTo(0, 200)") 
# driver.save_screenshot('./log/panasas/panasas_storage1.png')
# driver.execute_script("window.scrollTo(0, 1080)") 
# driver.save_screenshot('./log/panasas/panasas_storage2.png')
# driver.get("https://10.26.62.50/html/monitoring/driveStats.htm")
# driver.save_screenshot('./log/panasas/panasas_hdd1.png')
# driver.execute_script("window.scrollTo(0, 700)") 
# driver.save_screenshot('./log/panasas/panasas_hdd2.png')
# driver.execute_script("window.scrollTo(0, 1100)") 
# driver.save_screenshot('./log/panasas/panasas_hdd3.png')
# driver.execute_script("window.scrollTo(0, 2000)") 
# driver.save_screenshot('./log/panasas/panasas_hdd4.png')

driver.get('http://10.26.62.145/fxt/login.php')
driver.find_element_by_name("user").send_keys(secrets.username)
driver.find_element_by_id("password").send_keys(secrets.password)
driver.find_element_by_name("OK").click()










time.sleep(5)

driver.quit()


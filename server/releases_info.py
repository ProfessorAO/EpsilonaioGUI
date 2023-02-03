import argparse
import copy
import json
import os
import socket
import threading
import time
import binascii

import requests
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException, WebDriverException


DEFAULT_SHOE_IMAGE_FOLDER = 'latest_shoe_images'

class shoe_service():
    def __init__(self, addr: str = '::1', port: int = 5051, interval: int = 1200):
        self.shoes = []
        self.mutex = threading.Lock()
        self.addr = addr
        self.port = port
        self.interval = interval
        self.ready_to_send = False

    def run_service_thread(self):
        while True:
            self.ready_to_send = False
            self.shoes = scrape_all_shoes()
            start_time = time.time()
            threads = []
            sem = threading.BoundedSemaphore(10)
            for shoe in self.shoes:
                sem.acquire()
                get_image_thread = threading.Thread(target=shoe.get_image, args=(sem,), daemon=True)
                get_image_thread.start()

            # Make sure all threads are finished
            for t in threads:
                t.join()

            print("Got latest shoe releases")
            print("Get Image Time taken: %ds" % (time.time() - start_time))
            self.ready_to_send = True
            time.sleep(self.interval)

    def start(self):
        print("[Latest Shoe Service] Starting on [%s]:%d" % (self.addr, self.port))
        service_thread = threading.Thread(target=self.run_service_thread, daemon=True)
        listen_thread = threading.Thread(target=self.listen_incoming, daemon=True)
        service_thread.start()
        listen_thread.start()

    def listen_incoming(self):
        with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_V6ONLY, 0)
            s.bind((self.addr, self.port))
            s.listen()
            while True:
                try:
                    conn, addr = s.accept()
                    self.send_shoes(conn)

                except Exception as e:
                    print(e)
                    print("Connection Error")

    def send_shoes(self, conn):
        print("Ready to send: %s" % self.ready_to_send)
        while not self.ready_to_send:
            pass
        print("Sending %d shoes" % len(self.get_shoes()))
        for shoe in self.shoes:
            print(shoe)
        try:
            with conn:
                json_shoes = [s.to_json() for s in self.get_shoes()]
                conn.sendall(json.dumps(json_shoes).encode('utf-8'))
        except Exception as e:
            print(e)
            print(json_shoes)

    def get_shoes(self):
        with self.mutex:
            return copy.deepcopy(self.shoes)


class shoe_details():
    current_shoe_id = 1

    def __init__(self, name: str, price: str, release_date: str, ID: int = None, image: bytes = None):
        if ID is None:
            self.id = shoe_details.current_shoe_id
            shoe_details.current_shoe_id += 1
        else:
            self.id = ID

        self.name = name
        self.price = price
        self.release_date = release_date
        self.image = image
        self.image_path = None

    @classmethod
    def from_tuple(self, shoe_tuple, ID: bool = False, image: bool = False):
        if not ID and not image:
            return shoe_details(shoe_tuple[0], shoe_tuple[1], shoe_tuple[2])

        elif ID and image:
            return shoe_details(shoe_tuple[0], shoe_tuple[1], shoe_tuple[2], ID=shoe_tuple[3], image=shoe_tuple[4])

        elif ID and not image:
            return shoe_details(shoe_tuple[0], shoe_tuple[1], shoe_tuple[2], ID=shoe_tuple[3])

        else:
            assert len(shoe_tuple) == 4
            return shoe_details(shoe_tuple[0], shoe_tuple[1], shoe_tuple[2], image=shoe_tuple[3])

    def to_json(self) -> dict:
        return {
            "id": self.id,
            "name": self.name,
            "price": self.price,
            "release_date": self.release_date,
            "image": binascii.hexlify(self.image).decode('utf-8').upper() if self.image is not None else None
        }

    def is_valid(self) -> bool:
        if self.name is None or self.name == "":
            return False
        elif self.price is None or self.price == "":
            return False
        elif self.release_date is None or self.release_date == "":
            return False

        return True

    def get_image(self, sem: threading.BoundedSemaphore = None):
        if self.image_path is not None:
            self.get_image_from_file(self.image_path)
        else:
            options = get_options()
            with webdriver.Chrome("chromedriver.exe", options=options) as driver:
                driver.get("https://thesolesupplier.co.uk/release-dates/?sort=UPCOMING_RELEASES")

                element = driver.find_element(By.XPATH, "//img[@alt = '" + self.name + "']")
                self.image = requests.get(element.get_attribute('src')).content
        if sem is not None:
            sem.release()

    def get_image_from_file(self, path: str):
        with open(path, 'rb') as f:
            shoe_image = b''
            data = f.read(1)
            shoe_image += data
            while data:
                data = f.read(1)
                shoe_image += data
            self.image = shoe_image

    def save_image(self, folder_name: str):
        if self.image is None:
            return
        if not os.path.isdir(folder_name):
            os.makedirs(folder_name)

        image_path = folder_name + '/' + str(self.id) + '.png'

        with open(image_path, 'wb') as f:
            f.write(self.image)

        self.image_path = image_path

    @classmethod
    def from_json(cls, json_shoe: dict):
        return shoe_details(json_shoe['name'], json_shoe['price'], json_shoe['release_date'], ID=json_shoe['id'],
                            image=binascii.unhexlify(json_shoe['image']) if json_shoe['image'] is not None else None)

    def __str__(self):
        string = "%d: %s, %s, %s" % (self.id, self.name, self.price, self.release_date)
        string += "\n    img path: %s, img: %s" % (self.image_path, self.image is not None)
        return string


def get_options():
    option = Options()
    option.headless = True
    option.add_argument('--disable-blink-features=AutomationControlled')
    option.add_experimental_option("excludeSwitches", ["enable-automation", "enable-logging"])
    option.add_experimental_option('useAutomationExtension', False)
    return option


def get_all_elements(class_name: str):
    options = get_options()
    driver = webdriver.Chrome("chromedriver.exe", options=options)
    driver.get("https://thesolesupplier.co.uk/release-dates/?sort=UPCOMING_RELEASES")
    elements = driver.find_elements(By.CLASS_NAME, class_name)
    return elements, driver


def get_all_shoe_pages():
    elements, driver = get_all_elements('card__main-link')
    pages = [ page.get_attribute('href') for page in elements ]
    driver.close()
    return pages


def delete_old_shoe_images(latest_id: int):
    for i in range(1, latest_id):
        os.remove(DEFAULT_SHOE_IMAGE_FOLDER + '/' + str(latest_id - i) + '.png')


def get_all_data_from_page_thread(link, shoe_data: list, mutex: threading.Lock = None,
                                  sem: threading.BoundedSemaphore = None):
    options = get_options()
    with webdriver.Chrome("chromedriver.exe", options=options) as driver:
        driver.get(link)
        name = driver.find_element(By.CLASS_NAME, 'product__title').text
        price = driver.find_element(By.CLASS_NAME, 'price__regular-price').text
        release_date = driver.find_element(By.CLASS_NAME, 'release-date').text

    if mutex is not None:
        mutex.acquire()
        shoe_data.append((name, price, release_date))
        mutex.release()

    else:
        shoe_data.append((name, price, release_date))

    if sem is not None:
        sem.release()


def scrape_all_shoes() -> list[shoe_details]:
    threads = []
    try:
        pages = get_all_shoe_pages()
        data = []
        sem = threading.BoundedSemaphore(10)
        mutex = threading.Lock()

        for page in pages:
            get_data_thread = threading.Thread(target=get_all_data_from_page_thread, args=(page, data, mutex, sem))
            sem.acquire()
            get_data_thread.start()
            threads.append(get_data_thread)
    except WebDriverException as e:
        print("Page crashed, retrying")
        for t in threads:
            t.join()
        return scrape_all_shoes()

    # Wait for all threads to finish


    shoes = [ shoe_details.from_tuple(d) for d in data ]
    return list(filter(lambda s: s.is_valid(), shoes))


def parse_endpoint(string: str, default_port: int = None) -> tuple[str, int]:
    # IPv6 with port
    if string[0] == '[':
        ip_end_index = string.index(']')
        ip_address = string[1:ip_end_index]
        port = int(string[ip_end_index + 2:])

    # IPv6 without port
    elif string.count(':') > 1:
        ip_address = string
        port = default_port

    return ip_address, port


def socket_readall(s: socket.socket) -> bytes:
    data = b''
    while True:
        recvd = s.recv(10000)
        if recvd == b'':
            return data
        data += recvd


def get_shoes_from_service(addr: str = "::1", port: int = 5051, image_folder: str = None) -> list[shoe_details]:
    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
        s.settimeout(120)
        s.connect((addr, port))
        data = socket_readall(s).decode('utf-8')

        json_data = json.loads(data)
        shoes = [shoe_details.from_json(json_shoe) for json_shoe in json_data]
        if image_folder is not None:
            for shoe in shoes:
                shoe.save_image(image_folder)
        return shoes


def parse_args():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group2 = parser.add_argument_group()
    group.add_argument('-s', '--service', action='store_true', default=False,
                       help='Use this argument to run server side code')
    group.add_argument('-c', '--client', action='store_true', default=False,
                       help='Use this argument to run client side code')
    parser.add_argument('-e', '--endpoint', type=str, default='[::1]:5051',
                        help='Specify an endpoint to either host or connect to')
    group2.add_argument('-i', '--images', action='store_true', default= True,
                        help='This argument tells the script to save shoe images (if client)')
    group2.add_argument('-f', '--folder', type=str, default=DEFAULT_SHOE_IMAGE_FOLDER,
                        help='Name of the folder for shoe images to be stored')
    parser.add_argument('-t', '--time', type=int, default=1200,
                        help='The interval time between fetching latest shoes in seconds')
    return parser.parse_args()


def main():
    args = parse_args()
    addr, port = parse_endpoint(args.endpoint, 5051)

    if args.service:
        interval = args.time
        service = shoe_service(addr, port, interval)
        service.start()
        while True:
            pass

    elif args.client:
        print(args)
        if args.images:
            shoes = get_shoes_from_service(addr, port, args.folder)
        else:
            shoes = get_shoes_from_service(addr, port)
        for shoe in shoes:
            print(shoe)
            print("")


if __name__ == '__main__':
    main()
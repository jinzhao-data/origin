# -*- coding: utf-8 -*-
from PIL import ImageGrab
import os
from PIL import Image
import pytesseract
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup

def main():
    # 1.截屏
    im00 =ImageGrab.grab((50,310, 700, 1000))
    # 2. 文字识别
    text = pytesseract.image_to_string(im00, lang='chi_sim')
    print(text)

    # 3. 去百度知道搜索
    text = text[2:]  # 把题号去掉
    wd = urllib.request.quote(text)
    url = 'https://zhidao.baidu.com/search?ct=17&pn=0&tn=ikaslist&rn=10&fr=wwwt&word={}'.format(
        wd)
    result = urlopen(url)
    body = BeautifulSoup(result.read(), 'html5lib')
    good_result_div = body.find(class_='list-header').find('dd')
    second_result_div = body.find(class_='list-inner').find(class_='list')
    if good_result_div is not None:
        good_result = good_result_div.get_text()
        print(good_result.strip())

    if second_result_div is not None:
        second_result = second_result_div.find('dl').find('dd').get_text()
        print(second_result.strip())
if __name__ == '__main__':
    main()

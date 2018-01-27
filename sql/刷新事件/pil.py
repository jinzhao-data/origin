from PIL import ImageGrab
import os
from PIL import Image
import pytesseract
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup

def main():
    # 1.截屏
    im00 =ImageGrab.grab((50,310, 700, 500))
    # 2. 文字识别
    text = pytesseract.image_to_string(im00, lang='chi_sim')
    print(text)

    # 3. 去百度知道搜索
    text = text[2:]  # 把题号去掉
    wd = urllib.request.quote(text)
    url = 'https://zhidao.baidu.com/search?ct=17&pn=0&tn=ikaslist&rn=10&fr=wwwt&word={}'.format(
        wd)
    print(url)
    result = urlopen(url)
    print(type(result.read()))
if __name__ == '__main__':
    main()

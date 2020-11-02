from bs4 import BeautifulSoup
import requests
import json 

url = requests.get('https://www.iei.or.kr/intro/teacher.kh')
soup = BeautifulSoup(url.text, 'html.parser')
imgurl = "https://www.iei.or.kr"

soupfinder = soup.find('div',{'class': 'intro_list'})
souplist = list()
soupli = soupfinder.select('li')
for i in soupli: 
    choice = imgurl+ i.find('img')['src']
    name = i.find('p').text
    res = {} 
    res['이름'] = name
    res['사진'] = pic
    souplist.append(res)

tmp = {}
tmp['kh'] = souplist
tmp_json = json.dumps(tmp, ensure_ascii=False)
print(tmp_json)
with open('teacher.json', 'w', encoding='utf-8') as f:
    f.write(tmp_json)
  
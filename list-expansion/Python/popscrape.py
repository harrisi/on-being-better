from lxml import html
import requests

page = requests.get('https://www2.portofportland.com/PDX/Flights?Day=Today&TimeFrom=12%3A00+AM&TimeTo=11%3A59+PM&Type=D&FlightNum=&CityFromTo=&Airline=')
tree = html.fromstring(page.content)

gates = tree.xpath('//*[@id="flight-table"]/tbody//td[position()=7]')
times = tree.xpath('//*[@id="flight-table"]/tbody//td[position()=1]')

pairs = zip(gates, times)

for (g, t) in pairs:
  print("Gate:\t" + g.text_content().strip() +
        ";\tTime:\t" + t.text_content().strip())

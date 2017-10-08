import urllib2
import sys
from sys import argv
from urllib2 import Request, urlopen, URLError, HTTPError

url = sys.argv[1]

req = urllib2.Request(url)
try: response = urllib2.urlopen(req)

except HTTPError as e:
	print 'Error code:', e.code
	sys.exit(2)

except URLError as e:
	print(e.reason)
	sys.exit(2)

else:
	the_page = response.read().lower()
#credit to Nonades for this one

	if 'normal' in the_page:
		print "Status returned Normal"
		sys.exit(0)

	elif 'warning' in the_page:
		print "Status returned Warning"
		sys.exit(1)
	
	elif 'critical' in the_page:
		print "Status returned Critical"
		sys.exit(2)

	else:
		print "Unknown response"
		sys.exit(3)

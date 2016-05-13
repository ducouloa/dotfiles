#!/usr/bin/env python2.7
import sys
import datetime


INDEX_FORMAT_PRE = "%4C %?M?+& ?%02M %2e %Z "
INDEX_FORMAT_POST = " %-15.15L (%?l?%4l&%4c?) %s%"


if __name__ == '__main__':
   year, month, day = sys.argv[1].split()
   msg_date = datetime.date(int(year), int(month), int(day))
   if msg_date == datetime.datetime.now().date():
      print INDEX_FORMAT_PRE + "%7[%H:%M]" + INDEX_FORMAT_POST
   else:
      print INDEX_FORMAT_PRE + "%7[%b %e]" + INDEX_FORMAT_POST

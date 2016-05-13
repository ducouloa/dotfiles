#!/usr/bin/env python2.7

from icalendar import Calendar
from dateutil import rrule
from dateutil.tz import tzlocal
import os
import pytz
import datetime

HOME = os.getenv('HOME')
MY_CALENDAR = HOME + '/.local/share/acal/acal.ics'
MY_TIME_ZONE = 'Europe/Paris'

with open(MY_CALENDAR, 'r') as calfile:
    cal = Calendar.from_ical(calfile.read())

events = []


for event in cal.walk('vevent'):

    date = event.get('dtstart')
    time = date.dt.astimezone(pytz.timezone(MY_TIME_ZONE))
    timezone = event.get('tzinfo')
    event_rrule = event.get('rrule')
    if event_rrule:
        str_rule = ''
        for k, v in event_rrule.items():
            str_rule = str_rule + k + '=' + str(v[0]) + ';'
        try:
            rule = rrule.rrulestr(str_rule[:-1], dtstart=date.dt)
        except Exception, e:
            print e
        date = rule.after(datetime.datetime.now(tzlocal()))
    else:
        date = time

    summary = event.get('summary')
    events.append({
       'date': date.strftime('%Y-%m-%d'),
       'start': time.strftime("%H:%M"),
       'summary': summary if summary else 'No summary',
    })

events.sort(key=lambda event: event['date'])

for ev in events:
    print (ev['date'] + ', ' + ev['start'] + ' __ ' + ev['summary']).encode('utf-8')

#!/usr/bin/python
from icalendar import Calendar
from dateutil import rrule
from dateutil.tz import tzlocal
import os
import pytz
import datetime

HOME = os.getenv('HOME')
MY_AGENDA = HOME + '/.local/share/acal/acal.ics'
MY_TIME_ZONE = 'Europe/Paris'


def add_if_not_occured(event):
    date = event.get('dtstart')
    # timezone = event.get('tzinfo')
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
        date = date.dt

    if date.astimezone(pytz.timezone(MY_TIME_ZONE)) - datetime.datetime.now(tzlocal()) >= datetime.timedelta(0):
        new_cal.add_component(event)


# resulting calendar with the new events from the new file
new_cal = Calendar()


if os.path.exists(MY_AGENDA):
    # list all referenced UID events
    with open(MY_AGENDA, 'rb') as calfile:
        old_cal = Calendar.from_ical(calfile.read())
        for event in old_cal.walk('vevent'):
            add_if_not_occured(event)


#  Write the update general calendar to file
with open(MY_AGENDA, 'w+') as gen_cal:
    gen_cal.write(new_cal.to_ical())

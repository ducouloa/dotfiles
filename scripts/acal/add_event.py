#!/usr/bin/python
import os
import uuid
import pytz
from datetime import datetime
from icalendar import Calendar, Event

#  STORE_PATH = os.path.join(os.getenv('HOME'), 'dotfiles/scripts/acal/tmp/')
#  if not os.path.exists(STORE_PATH):
#     os.makedirs(STORE_PATH)

HOME = os.getenv('HOME')
MY_AGENDA = HOME + '/.local/share/acal/acal.ics'
MY_TIME_ZONE = pytz.timezone('Europe/Paris')


def add_to_new_calendar(event):
    """ Add an event to the new calendar if its id is not referenced.
    Thus, new event must be proceed first to overwrite old ones.
    """
    for component in new_cal.subcomponents:
        if component.name == 'VEVENT' and component['UID'] == event['UID']:
            break
    else:
        new_cal.add_component(event)


# resulting calendar with the new event get from stdin
new_cal = Calendar()

event = Event()

summary = raw_input("Event summary: ")
event.add('summary', summary)

while(True):
    start = raw_input('start: year month day [hour minute]: ')
    dtstart = start.split(' ')
    if len(dtstart) == 3:
        event.add('dtstart', datetime(int(dtstart[0]),
                                      int(dtstart[1]),
                                      int(dtstart[2]), tzinfo=MY_TIME_ZONE))
        break
    elif len(dtstart) == 5:
        event.add('dtstart', datetime(int(dtstart[0]),
                                      int(dtstart[1]),
                                      int(dtstart[2]),
                                      int(dtstart[3]),
                                      int(dtstart[4]), tzinfo=MY_TIME_ZONE))
        break

while(True):
    end = raw_input('end: year month day [hour minute]: ')
    dtend = end.split(' ')
    if len(dtend) == 3:
        event.add('dtend', datetime(int(dtend[0]),
                                    int(dtend[1]),
                                    int(dtend[2]), tzinfo=MY_TIME_ZONE))
        break
    elif len(dtend) == 5:
        event.add('dtend', datetime(int(dtend[0]),
                                    int(dtend[1]),
                                    int(dtend[2]),
                                    int(dtend[3]),
                                    int(dtend[4]), tzinfo=MY_TIME_ZONE))
        break

description = raw_input('description: ')
event.add('description', description)

event['uid'] = str(uuid.uuid4())

add_to_new_calendar(event)

if os.path.exists(MY_AGENDA):
    # list all referenced UID events
    with open(MY_AGENDA, 'rb') as calfile:
        old_cal = Calendar.from_ical(calfile.read())
        for component in old_cal.subcomponents:
            if component.name == 'VEVENT':
                add_to_new_calendar(component)


#  Write the update general calendar to file
with open(MY_AGENDA, 'w+') as gen_cal:
    gen_cal.write(new_cal.to_ical())

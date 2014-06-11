#!/usr/bin/python
import os
import sys
from icalendar import Calendar

#  STORE_PATH = os.path.join(os.getenv('HOME'), 'dotfiles/scripts/acal/tmp/')
#  if not os.path.exists(STORE_PATH):
#     os.makedirs(STORE_PATH)

HOME = os.getenv('HOME')
MY_AGENDA = HOME + '/.local/share/acal/acal.ics'


def add_to_new_calendar(event):
    """ Add an event to the new calendar if its id is not referenced.
    Thus, new event must be proceed first to overwrite old ones.
    """
    for component in new_cal.subcomponents:
        if component.name == 'VEVENT' and component['UID'] == event['UID']:
            break
    else:
        new_cal.add_component(event)


# resulting calendar with the new events from the new file
new_cal = Calendar()

try:
    with open(sys.argv[1], 'r') as calfile:
        cal = Calendar.from_ical(calfile.read())
        for component in cal.subcomponents:
            if component.name == 'VEVENT':
                add_to_new_calendar(component)
except:
    print "Exception"


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

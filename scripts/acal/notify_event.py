#!/usr/bin/env python

from icalendar import Calendar
from dateutil import rrule
from dateutil.tz import tzlocal
from Tkinter import *
import ScrolledText
import time
import os
import pytz
import datetime

""" Usage: dump_event.py
"""


class Application(Frame):
    def repeat_event(self):
        if self.repeat:
            self.repeat_btn["text"] = "no repeat"
            self.repeat = False
        else:
            self.repeat_btn["text"] = "repeat"
            self.repeat = True

    def fillDescription(self, desc):
        self.desc = ScrolledText.ScrolledText(master=None, wrap=WORD, width=80, height=20)
        self.desc.pack(padx=3, pady=3, fill=BOTH, expand=True)
        self.desc.insert(INSERT, desc)

    def createWidgets(self):
        self.QUIT = Button(self)
        self.QUIT["text"] = "OK"
        self.QUIT["fg"] = "red"
        self.QUIT["command"] = self.quit
        self.QUIT.pack({"side": "right"})

        self.repeat_btn = Button(self)
        self.repeat_btn["text"] = "no repeat",
        self.repeat_btn["command"] = self.repeat_event
        self.repeat_btn.pack({"side": "left"})

    def __init__(self, master=None, description=None):
        self.repeat = False
        Frame.__init__(self, master)
        self.pack({"side": "bottom"})
        self.fillDescription(description)
        self.createWidgets()


def show_alarm(desc):
    root = Tk()
    app = Application(master=root, description=desc)
    app.mainloop()
    root.destroy()
    return app.repeat


HOME = os.getenv('HOME')
MY_CALENDAR = HOME + '/.local/share/acal/acal.ics'
MY_TIME_ZONE = 'Europe/Paris'

with open(MY_CALENDAR, 'r') as calfile:
    cal = Calendar.from_ical(calfile.read())

events = []


for event in cal.walk('vevent'):
    date = event.get('dtstart')
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
        date = date.dt

    event_time = date.astimezone(pytz.timezone(MY_TIME_ZONE))

    summary = event.get('summary')
    description = event.get('description')
    events.append({
       'time': event_time,
       'snooze_time': event_time,
       'description': description if description else 'No description',
       'summary': summary if summary else 'No summary',
    })


while 1:
    for event in events:
        delta = event['snooze_time'] - datetime.datetime.now(tzlocal())
        # print divmod(delta.days * 86400 + delta.seconds, 60)
        if delta < datetime.timedelta(0):
            events.remove(event)
            continue
        if delta < datetime.timedelta(minutes=15):
            repeat = show_alarm(event['description'])
            if repeat:
                event['snooze_time'] = event['snooze_time'] + datetime.timedelta(minutes=5)
            else:
                events.remove(event)

    time.sleep(60)

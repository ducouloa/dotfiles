#!/usr/bin/env python2.7
from Tkinter import *
import ScrolledText


TEST_DESCRIPTION = """ \
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet."""


class Application(Frame):
    def say_hi(self):
        print "hi there, everyone!"

    def createWidgets(self):
        self.QUIT = Button(self)
        self.QUIT["text"] = "QUIT"
        self.QUIT["fg"] = "red"
        self.QUIT["command"] = self.quit
        self.QUIT.pack({"side": "right"})

        self.hi_there = Button(self)
        self.hi_there["text"] = "Hello",
        self.hi_there["command"] = self.say_hi
        self.hi_there.pack({"side": "left"})

        self.meeting_desc = ScrolledText.ScrolledText(master=None, wrap=WORD, width=80, height=20)
        self.meeting_desc.pack(padx=1, pady=1, fill=BOTH, expand=True)
        self.meeting_desc.insert(INSERT, TEST_DESCRIPTION)

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.pack({"side": "bottom"})
        self.createWidgets()


class App(Frame):
    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.pack()

        self.entrythingy = Entry()
        self.entrythingy.pack()

        # here is the application variable
        self.contents = StringVar()
        # set it to some value
        self.contents.set("this is a variable")
        # tell the entry widget to watch this variable
        self.entrythingy["textvariable"] = self.contents

        # and here we get a callback when the user hits return.
        # we will have the program print out the value of the
        # application variable when the user hits return
        self.entrythingy.bind('<Key-Return>',
                              self.print_contents)

    def print_contents(self, event):
        print "hi. contents of entry is now ---->", \
              self.contents.get()


root = Tk()
app = Application(master=root)
app.mainloop()
root.destroy()

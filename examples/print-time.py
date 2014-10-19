#!/usr/bin/env python

import os
import atexit
import logging
import time

#### Python Pillar client
# Creates pid file
PID_PATH = '/tmp/pillar'
pid = str(os.getpid())
pidfile = "%s/pillar.%s.pid" % (PID_PATH, pid)
if os.path.isfile(pidfile):
    print "%s already exists, exiting" % pidfile
    sys.exit()
else:
    file(pidfile, 'w').write(pid)
def on_exit():
    os.unlink(pidfile)


atexit.register(on_exit)
####


#### Actual worker code
print os.environ.get('MY_ENV')

logging.basicConfig(filename='/tmp/print-time.log',level=logging.DEBUG)

while True:
    logging.debug("Checkin: %s %d" % (pid, int(time.time())))
    time.sleep(5)
####
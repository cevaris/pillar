#!/usr/bin/env python

import os
import atexit
import logging
import time
import sys
import signal

#### Python Pillar client
# Creates pid file
PID_PATH  = '/tmp/pillar'
WORKER_ID = os.environ.get('WORKER_ID')
pid = str(os.getpid())
pidfile = "%s/pillar.%s.pid" % (PID_PATH, WORKER_ID)
if os.path.isfile(pidfile):
    print "%s already exists, exiting" % pidfile
    sys.exit()
else:
    file(pidfile, 'w').write(pid)

def cleanup(*args):
    # print "Removing file %s" % pidfile
    if os.path.exists(pidfile):
        os.remove(pidfile)
    sys.exit()

# atexit.register(cleanup)
signal.signal(signal.SIGTERM, cleanup)
####


#### Actual worker code
print "python %s" % os.environ.get('MY_ENV')

logging.basicConfig(filename='/tmp/print-time.log',level=logging.DEBUG)

while True:
    logging.debug("Checkin: %s %d" % (pid, int(time.time())))
    time.sleep(5)
####
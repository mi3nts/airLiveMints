import os
import time

while True:
	os.system("rsync -avzrtu -e "ssh -p 2222"  mints@mintsdata.utdallas.edu:raw/ /home/teamlarylive/minstData/raw/")
	time.sleep(1)



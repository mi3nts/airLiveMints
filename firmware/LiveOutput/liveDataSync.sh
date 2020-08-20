while true; do
 rsync -avzrtu -e "ssh -p 2222"  mints@mintsdata.utdallas.edu:raw/ /home/teamlarylive/minstData/raw/
 sleep 10
done

# openTSDB

find the opentsdb pod: `kubectl get po -A`

shell into pod: `kubectl exec....`

then:

- copy and paste the following:

```bash
cat >loadavg-collector.sh <<\EOF
#!/bin/bash
set -e
while true; do
  awk -v now=`date +%s` -v host=`hostname` \
  '{ print "put proc.loadavg.1m " now " " $1 " host=" host;
    print "put proc.loadavg.5m " now " " $2 " host=" host }' /proc/loadavg
  sleep 15
done | nc -w 30 0 4242
EOF
chmod +x loadavg-collector.sh
nohup ./loadavg-collector.sh &
```

- press `ENTER` to start the script using `nohup`
- press `ENTER` again
- type `exit` and press `ENTER`

sync
sleep 5
echo 1 > /proc/sys/vm/drop_caches
sleep 5
echo 2 > /proc/sys/vm/drop_caches
sleep 5
echo 3 > /proc/sys/vm/drop_caches
sleep 5
echo "chache memory has been cleared"

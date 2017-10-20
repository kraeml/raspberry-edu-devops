for i in 01 02 03 04; do
    ssh pi@cluster-${i}.local sudo shutdown -r +1
done
sudo shutdown -r +1
exit

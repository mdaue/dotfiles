TMP_PATH=/var/tmp
TMPL_PATH=${PWD}/

nvidia-smi
if [ $? != 0 ]; then
    exit
fi

echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=${TMP_PATH}" | sudo tee /etc/modprobe.d/nvidia-power-management.conf 

sudo rm -f /etc/systemd/system/nvidia-suspend.service # if /dev/null
sudo rm -f /etc/systemd/system/nvidia-resume.service # if /dev/null
sudo rm -f /etc/systemd/system/nvidia-hibernate.service # if /dev/null

sudo install --mode 644 "${TMPL_PATH}/nvidia-suspend.service" /lib/systemd/system
sudo install --mode 644 "${TMPL_PATH}/nvidia-hibernate.service" /lib/systemd/system
sudo install --mode 644 "${TMPL_PATH}/nvidia-resume.service" /lib/systemd/system

sudo install --mode 755 "${TMPL_PATH}/nvidia" /lib/systemd/system-sleep
sudo install --mode 755 "${TMPL_PATH}/nvidia-sleep.sh" /usr/bin

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

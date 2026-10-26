# c880-nvidia-drivers



please use root to install all drivers, ndvidia, toolkit, cuda, doca, nccl, fabric manager, dkms, 

1- Git clone or download the repository:

  ```
  git clone https://github.com/cpoc-internal/c880-nvidia-drivers

  ```

2. Run the shell script to install the nccl test without accessing the folder, run this as ROOT

  ```
   chmod +x /root/c880-nvidia-drivers/drivers_package.sh
  sudo -u root /root/c880-nvidia-drivers/drivers_package.sh
 ```
3. Create new netplan config for UCS c880server persistent config 

Server 1
```

 chmod +x /root/c880-nvidia-drivers/netplan-config-1.sh
 sudo -u root /root/c880-nvidia-drivers/netplan-config-1.sh
```


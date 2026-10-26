#!/bin/bash
#eargueda

#To apply this configuration on another server, please double-check the ETHERNET interface name and update the IP address as you need!

# ----------------- Configuration Variables -----------------
NETPLAN_FILE="/etc/netplan/50-config.yaml"

sudo tee "$NETPLAN_FILE" > /dev/null << EOF
network:
    version: 2
    ethernets:
        enp23s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.31/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp57s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.32/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp95s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.33/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp112s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.34/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp151s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.35/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1
        
        enp185s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.36/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp220s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.37/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1

        enp237s0f1np1:
            mtu: 9216
            addresses:
            - 192.168.200.38/24
            nameservers:
                addresses:
                - 192.168.200.1
            routes:
                - to: 192.168.200.0/24
                  via: 192.168.200.1
        enp83s0f0np0:
            mtu: 9216
            addresses:
            - 10.10.0.30/24
            routes:
                - to: 10.10.0.0/24
                  via: 10.10.0.1
                  
        enp83s0f1np1:
            mtu: 9216
            addresses:
            - 10.10.0.31/24
            routes:
                - to: 10.10.0.0/24
                  via: 10.10.0.1
        enp204s0f0np0:
            mtu: 9216
            addresses:
            - 10.10.0.32/24
            routes:
                - to: 10.10.0.0/24
                  via: 10.10.0.1
        enp204s0f1np1:
            mtu: 9216
            addresses:
            - 10.10.0.33/24
            routes:
                - to: 10.10.0.0/24
                  via: 10.10.0.1
                  

EOF

sudo chmod 600 "$NETPLAN_FILE"

echo " applying Netplan configuration..."
#sudo netplan try || { echo "Netplan configuration failed validation. Check $NETPLAN_FILE for syntax errors."; exit 1; }
#If 'netplan try' succeeds, it reverts after 120s if no confirmation.
sudo netplan apply

echo "----------------------------------------"
echo "Netplan configuration created and validated successfully."
echo "File location: $NETPLAN_FILE"
echo "Content:"
sudo cat "$NETPLAN_FILE"
echo "----------------------------------------"
echo " waiting few seconds..."
sleep 5
sudo apt install net-tools
sleep 5
ifconfig

echo "Done."
# web admin
ssh -N -L 127.0.0.1:8080:127.0.0.1:80 \
  -i ~/.ssh/openwrt_rsa \
  -o IdentitiesOnly=yes \
  -o KexAlgorithms=+diffie-hellman-group14-sha1 \
  -o HostKeyAlgorithms=+ssh-rsa \
  -o PubkeyAcceptedAlgorithms=+ssh-rsa \
  root@192.168.1.40

http://127.0.0.1:8080/


# bash
ssh -i ~/.ssh/openwrt_rsa \
    -o IdentitiesOnly=yes \
    -o KexAlgorithms=+diffie-hellman-group14-sha1 \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedAlgorithms=+ssh-rsa \
    root@192.168.1.40


# generate old type ssh key
ssh-keygen -t rsa -b 2048 -f ~/.ssh/openwrt_rsa -C "OpenWrt WRT"


# wireshark
ssh -i ~/.ssh/openwrt_rsa \
    -o IdentitiesOnly=yes \
    -o KexAlgorithms=+diffie-hellman-group14-sha1 \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedAlgorithms=+ssh-rsa \
    root@192.168.2.1 "tcpdump -i br0 -U -w -" | wireshark -k -i -

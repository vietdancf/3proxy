#! /bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

ngẫu nhiên () {
	tr < /dev/urandom -dc A-Za-z0-9 | đầu -c5
	tiếng vang
}

mảng=(1 2 3 4 5 6 7 8 9 0 abcdef)
gen64 () {
	ip64 () {
		echo  " ${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]} "
	}
	tiếng vang  " $1 : $( ip64 ) : $ ( ip64 ) : $( ip64 ) : $( ip64 ) "
}
cài đặt_3proxy () {
    echo  " cài đặt 3proxy "
    URL= " https://github.com/z3APA3A/3proxy/archive/3proxy-0.8.6.tar.gz "
    quên $URL 
    tar -xvf 3proxy- *
    cd 3proxy-3proxy-0.8.6
    làm -f Makefile.Linux
    mkdir -p /usr/local/etc/3proxy/{bin,log,stat}
    cp src/3proxy/usr/local/etc/3proxy/bin/
    # cp ./scripts/rc.d/proxy.sh /etc/init.d/3proxy
    # chmod +x /etc/init.d/3proxy
    # chkconfig 3proxy trên
    cd  $WORKDIR
}

gen_3proxy () {
    con mèo << EOF
yêu tinh
maxconn 2000
máy chủ 1.1.1.1
máy chủ 8.8.4.4
nserver 2001:4860:4860::8888
nserver 2001:4860:4860::8844
nschache 65536
hết giờ 1 5 30 60 180 1800 15 60
thiết lập 65535
thiết lập 65535
kích thước ngăn xếp 6291456
tuôn ra
$( awk -F " / "  ' {in "\n" \
"" $1 "\n" \
"proxy -6 -n -a -p" $4 " -i" $3 " -e"$5"\n" \
"tuôn ra\n"} '  ${WORKDATA} )
EOF
}

gen_proxy_file_for_user () {
    mèo > proxy.txt << EOF
$( awk -F " / "  ' {in $3 ":" $4 ":" $1 ":" $2 } '  ${WORKDATA} )
EOF
}


gen_data () {
    tiếp theo $FIRST_PORT  $LAST_PORT  |  trong khi  đọc cổng ;  LÀM
        tiếng vang  " // Viettrandeptrai / $port / $( gen64 $IP6 ) "
    xong
}

gen_iptables () {
    con mèo << EOF
    $( awk -F " / "  ' {print "iptables -I INPUT -p tcp --dport " $4 " -m state --state NEW -j ACCEPT"} '  ${WORKDATA} ) 
EOF
}

gen_ifconfig () {
    con mèo << EOF
$( awk -F " / "  ' {print "ifconfig eth0 inet6 add " $5 "/64"} '  ${WORKDATA} )
EOF
}
tiếng vang  " cài đặt ứng dụng "
yum -y cài đặt gcc net-tools bsdtar zip > /dev/null

cài đặt_3proxy

tiếng vang  " thư mục làm việc = /home/bkns "
WORKDIR= " /home/bkns "
WORKDATA= " ${WORKDIR} /data.txt "
mkdir $WORKDIR  &&  cd  $_

IP4= $( curl -4 -s icanhazip.com )
IP6= $( curl -6 -s icanhazip.com | cut -f1-4 -d ' : ' )

echo  " Internal ip = ${IP4} . Exteranl sub for ip6 = ${IP6} "

FIRST_PORT=32000
LAST_PORT=34000

gen_data > $WORKDIR /data.txt
gen_iptables > $WORKDIR /boot_iptables.sh
gen_ifconfig > $WORKDIR /boot_ifconfig.sh
chmod +x boot_ * .sh /etc/rc.local

gen_3proxy > /usr/local/etc/3proxy/3proxy.cfg

con mèo >> /etc/rc.local << EOF
bash ${WORKDIR} /boot_iptables.sh
bash ${WORKDIR} /boot_ifconfig.sh
ulimit -n 10048
/usr/local/etc/3proxy/bin/3proxy /usr/local/etc/3proxy/3proxy.cfg
EOF

bash /etc/rc.local

gen_proxy_file_for_user
rm -rf /root/3proxy-3proxy-0.8.6

tiếng vang  " Proxy bắt đầu "

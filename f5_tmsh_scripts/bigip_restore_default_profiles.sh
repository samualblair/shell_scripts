#!/bin/bash
# Michael W Johnson - bigip_restore_default_profiles v17-2024
# Procedure and scripts for recovering default profiles on BIG-IP , v17 tested, should be valid for other versions too
# See https://my.f5.com/manage/s/article/K51888238

# ================
# Begin - Take a UCS Backup
# ================
tmsh save sys ucs "$(echo $HOSTNAME | cut -d'.' -f1)-$(date +%H%M-%m%d%y)"


# ================
## Procedure 1 - clientssl
# ================

tmsh list ltm profile client-ssl one-line | grep 'ltm profile client-ssl clientssl {' | sed 's,ltm profile client-ssl clientssl ,ltm profile client-ssl clientsslCustomDefault ,g' > /var/tmp/clientsslCustomDefault.conf
tmsh load sys config file /var/tmp/clientsslCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/clientssl {$,        /Common/clientsslCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_1.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/clientssl { }$,        /Common/clientsslCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_1.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_1.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_1.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile client-ssl \/Common\/clientssl \{/ { print }' /var/tmp/K51888238_1.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_1.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config



# ================
## Procedure 2 - serverssl
# ================

tmsh list ltm profile server-ssl one-line | grep 'ltm profile server-ssl serverssl {' | sed 's,ltm profile server-ssl serverssl ,ltm profile server-ssl serversslCustomDefault ,g' > /var/tmp/serversslCustomDefault.conf
tmsh load sys config file /var/tmp/serversslCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/serverssl {$,        /Common/serversslCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_2.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/serverssl { }$,        /Common/serversslCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_2.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_2.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_2.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile server-ssl \/Common\/serverssl \{/ { print }' /var/tmp/K51888238_2.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_2.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 3 - tcp-legacy
# ================

tmsh list ltm profile tcp one-line | grep 'ltm profile tcp tcp-legacy {' | sed 's,ltm profile tcp tcp-legacy ,ltm profile tcp tcp-legacyCustomDefault ,g' > /var/tmp/tcp-legacyCustomDefault.conf
tmsh load sys config file /var/tmp/tcp-legacyCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/tcp-legacy {$,        /Common/tcp-legacyCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_3.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/tcp-legacy { }$,        /Common/tcp-legacyCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_3.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_3.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_3.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile tcp \/Common\/tcp-legacy \{/ { print }' /var/tmp/K51888238_3.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_3.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 4 - tcp-wan-optimized
# ================

tmsh list ltm profile tcp one-line | grep 'ltm profile tcp tcp-wan-optimized {' | sed 's,ltm profile tcp tcp-wan-optimized ,ltm profile tcp tcp-wan-optimizedCustomDefault ,g' > /var/tmp/tcp-wan-optimizedCustomDefault.conf
tmsh load sys config file /var/tmp/tcp-wan-optimizedCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/tcp-wan-optimized {$,        /Common/tcp-wan-optimizedCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_4.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/tcp-wan-optimized { }$,        /Common/tcp-wan-optimizedCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_4.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_4.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_4.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile tcp \/Common\/tcp-wan-optimized \{/ { print }' /var/tmp/K51888238_4.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_4.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 5 - fastL4
# ================

tmsh list ltm profile fastl4 one-line | grep 'ltm profile fastl4 fastL4 {' | sed 's,ltm profile fastl4 fastL4 ,ltm profile fastl4 fastL4CustomDefault ,g' > /var/tmp/fastL4CustomDefault.conf
tmsh load sys config file /var/tmp/fastL4CustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/fastL4 {$,        /Common/fastL4CustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_5.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/fastL4 { }$,        /Common/fastL4CustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_5.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_5.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_5.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile fastl4 \/Common\/fastL4 \{/ { print }' /var/tmp/K51888238_5.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_5.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 6 - http
# ================

tmsh list ltm profile http one-line | grep 'ltm profile http http {' | sed 's,ltm profile http http ,ltm profile http httpCustomDefault ,g' > /var/tmp/httpCustomDefault.conf
tmsh load sys config file /var/tmp/httpCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/http {$,        /Common/httpCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_6.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/http { }$,        /Common/httpCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_6.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_6.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_6.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile http \/Common\/http \{/ { print }' /var/tmp/K51888238_6.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_6.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 7 - tcp-lan-optimized
# ================

tmsh list ltm profile tcp one-line | grep 'ltm profile tcp tcp-lan-optimized {' | sed 's,ltm profile tcp tcp-lan-optimized ,ltm profile tcp tcp-lan-optimizedCustomDefault ,g' > /var/tmp/tcp-lan-optimizedCustomDefault.conf
tmsh load sys config file /var/tmp/tcp-lan-optimizedCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/tcp-lan-optimized {$,        /Common/tcp-lan-optimizedCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_7.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/tcp-lan-optimized { }$,        /Common/tcp-lan-optimizedCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_7.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_7.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_7.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile tcp \/Common\/tcp-lan-optimized \{/ { print }' /var/tmp/K51888238_7.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_7.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 8 - optimized-caching
# ================

tmsh list ltm profile web-acceleration one-line | grep 'ltm profile web-acceleration optimized-caching {' | sed 's,ltm profile web-acceleration optimized-caching ,ltm profile web-acceleration optimized-cachingCustomDefault ,g' > /var/tmp/optimized-cachingCustomDefault.conf
tmsh load sys config file /var/tmp/optimized-cachingCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/optimized-caching {$,        /Common/optimized-cachingCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_8.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/optimized-caching { }$,        /Common/optimized-cachingCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_8.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_8.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_8.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile web-acceleration \/Common\/optimized-caching \{/ { print }' /var/tmp/K51888238_8.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_8.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 9 - webacceleration
# ================

tmsh list ltm profile web-acceleration one-line | grep 'ltm profile web-acceleration webacceleration {' | sed 's,ltm profile web-acceleration webacceleration ,ltm profile web-acceleration webaccelerationCustomDefault ,g' > /var/tmp/webaccelerationCustomDefault.conf
tmsh load sys config file /var/tmp/webaccelerationCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/webacceleration {$,        /Common/webaccelerationCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_9.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/webacceleration { }$,        /Common/webaccelerationCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_9.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_9.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_9.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile web-acceleration \/Common\/webacceleration \{/ { print }' /var/tmp/K51888238_9.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_9.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config

# ================
## Procedure 10 - fasthttp
# ================

tmsh list ltm profile fasthttp one-line | grep 'ltm profile fasthttp fasthttp {' | sed 's,ltm profile fasthttp fasthttp ,ltm profile fasthttp fasthttpCustomDefault ,g' > /var/tmp/fasthttpCustomDefault.conf
tmsh load sys config file /var/tmp/fasthttpCustomDefault.conf merge
tmsh save sys config

# Need to match both possible line cases
sed -i.bak 's,^        /Common/fasthttp {$,        /Common/fasthttpCustomDefault {,g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_10.bigip.conf.bak_sed1
sed -i.bak 's,^        /Common/fasthttp { }$,        /Common/fasthttpCustomDefault { },g' /config/bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_10.bigip.conf.bak_sed2

cp /config/bigip.conf /var/tmp/K51888238_10.bigip.conf
cp /config/bigip.conf.bak /var/tmp/K51888238_10.bigip.conf.bak

awk 'BEGIN { FS = "\n" ; RS = "\n}\n" ; ORS = "\n}\n" }; !/^ltm profile fasthttp \/Common\/fasthttp \{/ { print }' /var/tmp/K51888238_10.bigip.conf | sed ':a;N;$!ba;s,\n\n}$,,g' > /config/bigip.conf

tmsh load sys config verify

tmsh load sys config


### Back out procedure ONLY IF NEEDED AT THIS POINT
cp /var/tmp/K51888238_10.bigip.conf.bak /config/bigip.conf
tmsh load sys config
tmsh save sys config


# ================
# All procedures completed - Save sys config
# ================

tmsh save sys config

tmsh delete ltm pool /Common/ExamplePool
tmsh delete ltm node /Common/192.0.2.1
tmsh delete ltm node /Common/192.0.2.2
tmsh delete ltm snatpool /Common/SNAT_internal
tmsh delete ltm snat-translation /Common/192.0.2.50
tmsh delete ltm profile client-ssl /Common/www-ssl.example.com-client
tmsh delete ltm monitor smtp /Common/Example_smtp
tmsh delete sys file ssl-cert /Common/SSLCchain
tmsh delete sys file ssl-cert /Common/ssl.www.example.com.crt
tmsh delete sys file ssl-key /Common/ssl.www.example.com.key
tmsh delete ltm monitor http /Common/HTTP_HEAD_200_OK
tmsh save sys config

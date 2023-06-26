secret_key=$1
clear && python3 ./src/init.py << EOF
2
localhost
3306
root
serverpass
client_demo
2
Client A
localhost
$secret_key
EOF


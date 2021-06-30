# Configuration RabbitMQ Server on Windows

Foobar is a Python library for dealing with word pluralization.

## Open Port 5672

Open port 5672 on windows. [How to open port on Windows](https://www.firehousesoftware.com/webhelp/FH/Content/FHEnterprise/FHEnterpriseInstallationGuide/24_StaticPort.htm)

## Enable Loopback User
Copy this rule and paste it on `%APPDATA%\RabbitMQ\advanced.config`
``` bash
[{rabbit, [{loopback_users, []}]}].
```
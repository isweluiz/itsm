# Install orts on CENTOS 8 

Before run my script for install otrs

https://centos.pkgs.org/8/centos-powertools-x86_64/perl-DateTime-1.50-1.el8.x86_64.rpm.html

Install perl-DateTime rpm package:

```bash
# dnf --enablerepo=powertools install perl-DateTime
```

You can enable it with the following commands:

```bash
yum install dnf-plugins-core
```
Or: 

```bash
yum config-manager --set-enabled powertools
```
Or: 

```bash
yum config-manager --set-enabled PowerTools
```


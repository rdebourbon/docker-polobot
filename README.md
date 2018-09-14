# Docker PoloniexLendingBot

### Ports
- **TCP 8100** - Web Interface

### Volumes
- **/data** - Data and configuration data

Docker runs as uid 65534 (nobody on debian, nfsnobody on fedora). When mounting volumes from the host, ensure this uid has the correct permission on the folders.


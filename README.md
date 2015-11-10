This is to let you have your own all-in-oneclick server for ESXi auto deployment.

Steps:  
1. Clone this repo  
2. Create directory (roles/esxi_director/files/photon/), and put photon ovf files to it  
3. Download ESXi 5.5U3 and 6.0U1 build (iso files) to: roles/esxi_director/files/  
4. Prepare a Ubuntu server 14.04 64bits  
5. Setup passwordless access from your compute to Ubuntu server  
6. Add server info (ip username) to hosts file  
7. Run following commands to get the server ready:  
ansible-playbook sites.yml -i hosts -u [SSH_USER] --ask-sudo-pass


What will you get:  
1. A jenkins job to deploy ESXi from bare metal  
2. A jenkins job to add more ESXi builds via url or user upload  

Service the server configured and provided:
- Apache2
- TFTP
- DHCP Server (disabled by default)
- OVFTool
- ipmitool
- Jenkins
from netaddr import IPRange
import re
import subprocess
import socket
import sys

if len(sys.argv) != 4:
    print 'Usage: ', sys.argv[0], 'start_ip end_ip output_file'
    print 'For example: 10.111.90.1 10.111.90.30 out.txt'
    sys.exit(1)

outputFile = open(sys.argv[3], 'a')

iprange = IPRange(sys.argv[1], sys.argv[2])

for ip in iprange:
    print 'Pinging IP: ', ip
    ret = subprocess.call("ping -c 1 %s" % ip,
        shell=True,
        stdout=open('/dev/null', 'w'),
        stderr=subprocess.STDOUT)
    if ret == 0:
        print "%s: is alive" % ip
    else:
        print "%s: did not respond\n" % ip
        continue

    fqdn = socket.getfqdn(str(ip))
    if fqdn == str(ip):
        continue

    print 'FQDN is:', fqdn, '\n'

    pid = subprocess.Popen(['arp', '-n', str(ip)], stdout=subprocess.PIPE)
    s = pid.communicate()[0]
    mac = re.search(r'(([a-f\d]{1,2}\:){5}[a-f\d]{1,2})', s).groups()[0]
    index = fqdn.index('.')
    hostname = fqdn[:index]
    line = 'host {} {{\n'.format(hostname)
    outputFile.write(line)
    line = '  hardware ethernet {};\n'.format(mac)
    outputFile.write(line)
    line = '  fixed-address {};\n'.format(fqdn)
    outputFile.write(line)
    outputFile.write('}\n\n')

outputFile.close()

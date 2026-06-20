Add-DnsServerClientSubnet -Name "BR" -IPv4Subnet 172.30.1.0/24
Add-DnsServerClientSubnet -Name "HQ" -IPv4Subnet 172.20.100.0/24
Add-DnsServerClientSubnet -Name "REMOTE" -IPv4Subnet 192.168.200.0/24


Add-DnsServerZoneScope -Name "external" -ZoneName "wsmb2026.my"


Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "@" -ZoneName "wsmb2026.my" -ZoneScope "external" 
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "www" -ZoneName "wsmb2026.my" -ZoneScope "external" 
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "adfs" -ZoneName "wsmb2026.my" -ZoneScope "external"
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "HQ-DC" -ZoneName "wsmb2026.my" -ZoneScope "external"
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "HQ-SRV" -ZoneName "wsmb2026.my" -ZoneScope "external"
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "HQ-FILE" -ZoneName "wsmb2026.my" -ZoneScope "external"
Add-DnsServerResourceRecordA -IPv4Address "1.9.250.97" -Name "HQ-EDGE" -ZoneName "wsmb2026.my" -ZoneScope "external"

Add-DnsServerQueryResolutionPolicy -Name "ExternalPolicy" -ZoneName "wsmb2026.my" -Action ALLOW -ClientSubnet "ne,BR,HQ,REMOTE" -ZoneScope "external,1"


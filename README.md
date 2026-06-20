# Windows-Based-Architecture
A secure multi-site corporate infrastructure featuring Active Directory, hybrid PKI, ADFS, and certificate-based IKEv2 IPsec VPN

## Introduction
This repository showcases simulation of the deployment of a resilent, secure multi-site hybrid infrastructure.The solution simulates a modern corporate expansion by integrating a few virtual machine of Windows Server 2022 and Debian 13 Linux management to ensure rapid connection, secure and automate some configuration management.

## Project Objective & Site Breakdown
The infrastructure has been divided across network into 3 segments:
> * **Headquarters (wsmb2026.my):** Centralizes core identity services, corporate PKI, and high-availability storage
> * **Branch (branch.wsmb2026.my):** Simulates child domain of HQ and also a remote office running local domain services managed via Linux automation
> * **INET (Internet):** Simulates the public internet, root DNS routing, and secure site-to-site VPN tunnels

## Project Objective

To design and deploy a secure, multi-site enterprise infrastructure that connects corporate networks across a simulated public internet.

1. **Identity & Secure Authentication:** Creates a multi-tier domain environment and Certificate Authority trust chain to enable secure, federated Single Sign-On (SSO) for remote workers.

2. **Ansible & Scripting Deployment:** Reduce human errors by using Linux Ansible to push system rules, and PowerShell to automate user lifecycles.

3. **Data & Storage Management:** Ensures corporate data is always safe, organized, and optimized with using data deduplication services and network shares.

4. **Edge Routing & VPN Transit:** Secures edge networks by forcing all inter-site corporate traffic through persistent, certificate encryption tunnels across the public internet.

## Technical Architecture & Implementation Workflow

<img width="1440" height="598" alt="image" src="https://github.com/user-attachments/assets/9f32a3ef-122b-4c7c-8825-68fb5198fc27" />

### A-HEADQUARTERS (wsmb2026.my)
> Acts as the central of core identity management, security enforcement, and federated access control
   * **Identity Management:** Deploys Primary ADDS with appropriate parameter Powershell for bulk-user creation specifc for provisioning framework.
   * **Secure Single Sign-On (SS0):** Integrates Active Directory Federation services and WAP to pre-authenticated external access to the internal backend server
   * **Enterprise PKI Infrastructure:** Implements and Enterprise Subordinate Certification (ADCS) to handle internal certficates for services such as auto-enrollment certificate, HTTPS services and CRL/AIA externsion.
   * **Provisioning File Architecture:** Setup a deduplicated RAID 5 storage volume hosting by DFS namespaces, Work Folders, and file sharing enumeration based permissions. 
### B-BRANCH (branch.wsmb2026.my)
> Simulates a remote office extending local infrastructure capabilities while still maintaining parity with Headquarters.
   * **Centralized Identity Management:** Provisioning credential for users that can have permissions and rights according department responsibilities.
   * **Automated Active Directory:** Automated Windows domain group and folder permission setup using Ansible on Debian Linux.
   *  **WinRM Execution:** Enforces a secure remote management via WinRM over port HTTPS 5986 and eliminates others unencrypted channels communication.

### C-INET (ns.msftncsi.com)
> This segments will simulate a real indicator of NCSI connectivity and make it similar like internet access.
   *  **DNS & Connectivity Check:** Built a fake internet Root DNS and microsoft NCSI service to test domain name resolution and connectivity.
   *  **Root Certificate Authority:** Set up a standalone Root CA (ISP-CA) to issue certificates for enterprise systems.
   *  **Secure VPN Tunnels:** Configured Windows RRAS to run IKEV2 IPsec site-to-site VPN tunnels between Headquarters and Branch using certificates for authentication.


### Verification 1: Identity & Secure Authentication (ADDS, ADCS, ADFS)
* **What & Why:** Verifying that the multi-tier Active Directory environment authenticates users globally, enterprise certificates auto-enroll securely, and federated SSO tokens generate without errors.
* **Chaining:** Confirms that Objective 1 is met by validating Active Directory Domain Services (ADDS) replication health, Active Directory Certificate Services (ADCS) template isolation boundaries, and Active Directory Federation Services (ADFS) endpoint responses.
* **Verification & Expected Logs:**

#### *Check inbound replication summary and core domain controller health status*
```powershell
PS C:\Users\Administrator> repadmin /showrepl

Repadmin: running command /showrepl against full DC localhost
Default-First-Site-Name\HQ-DC
DSA Options: IS_GC
Site Options: (none)
DSA object GUID: ecf173e0-9f8d-42e3-a2f0-6e5d2000738b
DSA invocationID: ecf173e0-9f8d-42e3-a2f0-6e5d2000738b

==== INBOUND NEIGHBORS ======================================

CN=Configuration,DC=wsmb2026,DC=my
    Default-First-Site-Name\BR-DC via RPC
        DSA object GUID: 115646ef-7a16-4c29-a3a5-12513dd9afd4
        Last attempt @ 2026-06-20 14:12:41 was successful.

CN=Schema,CN=Configuration,DC=wsmb2026,DC=my
    Default-First-Site-Name\BR-DC via RPC
        DSA object GUID: 115646ef-7a16-4c29-a3a5-12513dd9afd4
        Last attempt @ 2026-06-20 13:55:31 was successful.

DC=ForestDnsZones,DC=wsmb2026,DC=my
    Default-First-Site-Name\BR-DC via RPC
        DSA object GUID: 115646ef-7a16-4c29-a3a5-12513dd9afd4
        Last attempt @ 2026-06-20 13:55:31 was successful.

DC=branch,DC=wsmb2026,DC=my
    Default-First-Site-Name\BR-DC via RPC
        DSA object GUID: 115646ef-7a16-4c29-a3a5-12513dd9afd4
        Last attempt @ 2026-06-20 14:19:07 was successful.

PS C:\Users\Administrator>
```

#### *Verify active custom templates published on the CA and audit enrollment permission blocks*
```powershell
PS C:\> certutil -catemplates | Select-String "WSMB_"

WSMB_VPN: WSMB_VPN -- Auto-Enroll
WSMB_Servers: WSMB_Servers -- Auto-Enroll
WSMB_Managers: WSMB_Managers -- Auto-Enroll
```
<img width="937" height="577" alt="Screenshot from 2026-06-20 14-59-50" src="https://github.com/user-attachments/assets/847ab9b0-2cc0-4dd8-907b-f8f92a7adef2" />

<img width="508" height="687" alt="image" src="https://github.com/user-attachments/assets/877b3edc-9d38-4cd6-a427-3238886995a6" />




#### *Test secure Active Directory Federation Services (ADFS) sign-in page reachability*
```powershell
PS C:\> Test-NetConnection -ComputerName "adfs.wsmb2026.my" -Port 443 | Select-Object ComputerName, RemoteAddress, TcpTestSucceeded

ComputerName     RemoteAddress TcpTestSucceeded                                                                                                       ------------     ------------- ----------------                                                                                                       adfs.wsmb2026.my 172.20.100.20             True  
```
<img width="1294" height="733" alt="image" src="https://github.com/user-attachments/assets/e661dfa6-f9a6-4d0d-8305-8dd1e65d80d1" />

### Verification 2: Automated Infrastructure & Storage Access Control (Ansible)
* **What & Why:** Enforcing consistent enterprise storage structures and explicit ACL security boundaries across target Windows Domain Controllers using a Linux Ansible Control Node to eliminate manual permission drift.
* **Verification & Expected Logs:**
 
```bash
# Run the deployment playbook from the Linux Ansible Control Node
root@itnsa:/opt/ansible# ansible-playbook manage-shares.yml --check

PLAY [manage-shares.yml] ***********************************************************************************************************************************************************

TASK [Create a new group] **********************************************************************************************************************************************************
ok: [BR-DC] => (item={'key': 'wsmbone', 'value': None})
ok: [BR-DC] => (item={'key': 'wsmbtwo', 'value': None})
ok: [BR-DC] => (item={'key': 'wsmbthree', 'value': None})

TASK [Create folder] ***************************************************************************************************************************************************************
ok: [BR-DC]

TASK [Share Everyone] **************************************************************************************************************************************************************
ok: [BR-DC]

TASK [Create Folder for Variables] *************************************************************************************************************************************************
ok: [BR-DC] => (item={'key': 'share01', 'value': {'name': 'wsmb_share01', 'read': 'wsmbone', 'write': 'wsmbtwo'}})
ok: [BR-DC] => (item={'key': 'share02', 'value': {'name': 'wsmb_share02', 'read': 'wsmbtwo', 'write': 'wsmbthree'}})

TASK [Remove Inheritance Variables] ************************************************************************************************************************************************
ok: [BR-DC] => (item={'key': 'share01', 'value': {'name': 'wsmb_share01', 'read': 'wsmbone', 'write': 'wsmbtwo'}})
ok: [BR-DC] => (item={'key': 'share02', 'value': {'name': 'wsmb_share02', 'read': 'wsmbtwo', 'write': 'wsmbthree'}})

TASK [Add Admin Account to Variables] **********************************************************************************************************************************************
skipping: [BR-DC] => (item={'key': 'share01', 'value': {'name': 'wsmb_share01', 'read': 'wsmbone', 'write': 'wsmbtwo'}}) 
skipping: [BR-DC] => (item={'key': 'share02', 'value': {'name': 'wsmb_share02', 'read': 'wsmbtwo', 'write': 'wsmbthree'}}) 
skipping: [BR-DC]

TASK [Setup Read Access for Variables] *********************************************************************************************************************************************
skipping: [BR-DC] => (item={'key': 'share01', 'value': {'name': 'wsmb_share01', 'read': 'wsmbone', 'write': 'wsmbtwo'}}) 
skipping: [BR-DC] => (item={'key': 'share02', 'value': {'name': 'wsmb_share02', 'read': 'wsmbtwo', 'write': 'wsmbthree'}}) 
skipping: [BR-DC]

TASK [Setup Modify access for Variables] *******************************************************************************************************************************************
skipping: [BR-DC] => (item={'key': 'share01', 'value': {'name': 'wsmb_share01', 'read': 'wsmbone', 'write': 'wsmbtwo'}}) 
skipping: [BR-DC] => (item={'key': 'share02', 'value': {'name': 'wsmb_share02', 'read': 'wsmbtwo', 'write': 'wsmbthree'}}) 
skipping: [BR-DC]

PLAY RECAP *************************************************************************************************************************************************************************
BR-DC                      : ok=5    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0   
```

### Verification 3: Data & Storage Management Infrastructure
* **What & Why:** Validating enterprise storage reliability, block-level capacity optimization via Data Deduplication, and centralized access paths using Distributed File System (DFS).
* **Verification & Expected Logs:**

#### *Verify RAID 5 Volume Status and Operational Health on HQ-FILE*
```powershell
PS G:\> Get-Volume -DriveLetter G | Select-Object DriveLetter, FileSystemType, HealthStatus, SizeRemaining

DriveLetter FileSystemType HealthStatus SizeRemaining
----------- -------------- ------------ -------------
          G NTFS           Healthy         1573298176
```


#### *Verify Data Deduplication Schedule and Volume Optimization Status on HQ-FILE*
```powershell
PS G:\> Get-DedupVolume -Volume G:

Enabled            UsageType          SavedSpace           SavingsRate          Volume
-------            ---------          ----------           -----------          ------
True               Default            660.31 MB            42 %                 G:

PS G:\> Get-DedupSchedule

Enabled    Type               StartTime              Days               Name
-------    ----               ---------              ----               ----
True       Optimization                                                 BackgroundOptimization
True       Optimization       12:00 AM               {Sunday, Monday... ThroughputOptimization
True       GarbageCollection  2:45 AM                Saturday           WeeklyGarbageCollection
True       Scrubbing          3:45 AM                Saturday           WeeklyScrubbing
```

#### *Verify Distributed File System (DFS) Active Namespaces Links on HQ-FILE*
```powershell
PS G:\> Get-DfsnRoot -Path "\\wsmb2026.my\fileshare"

Path                    Type      Properties   TimeToLiveSec State  Description
----                    ----      ----------   ------------- -----  -----------
\\wsmb2026.my\fileshare Domain V2 Site Costing 300           Online


PS G:\> Get-DfsnFolder -Path "\\wsmb2026.my\fileshare\*" | Select-Object Path, Targetpath, State

Path                           Targetpath State
----                           ---------- -----
\\wsmb2026.my\fileshare\public            Online
\\wsmb2026.my\fileshare\wsmb              Online

```

### Verification 4: Edge Routing & VPN Transit Infrastructure
* **What & Why:** Verifying secure edge perimeter boundaries, internal network address translation (NAT), and persistent IPsec IKEv2 Site-to-Site VPN tunnels secured via Enterprise PKI certificates.
* **Verification & Expected Logs:**

#### *Check the operational state and persistence of the Site-to-Site VPN interface on both HQ-EDGE & BR-EDGE*
```powershell
PS C:\> Get-VpnS2SInterface -Name "vpn" | Select-Object Name, ConnectionState, AuthenticationMethod, IsPersistent

Name ConnectionState AuthenticationMethod IsPersistent
---- --------------- -------------------- ------------
vpn  Connected       MachineCertificates
```

#### *Verify Edge IP Routing and Public/Internal Interface Configuration*
```powershell
PS C:\> Get-NetIPAddress -InterfaceAlias "Ethernet0", "Ethernet1" -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress, IPv4Address, PrefixLength

InterfaceAlias IPAddress   IPv4Address PrefixLength
-------------- ---------   ----------- ------------
Ethernet1      1.9.250.110 1.9.250.110           28
Ethernet0      172.30.1.1  172.30.1.1            24
```


#### *Validate secure cross-site ICMP reachability through the active VPN tunnel from HQ-EDGE into Branch corporation*
```powershell
PS C:\> Test-NetConnection -ComputerName "172.30.1.100"                                                                                                                                                                                         
ComputerName           : 172.30.1.100
RemoteAddress          : 172.30.1.100
InterfaceAlias         : vpn
SourceAddress          : 169.254.33.243
PingSucceeded          : True
PingReplyDetails (RTT) : 1 ms
```

---

---

## Conclusion Summary

This project successfully demonstrates a secure, high-availability, and automated multi-site enterprise infrastructure. By integrating Windows Server 2022 with Linux Ansible automation, the architecture delivers three core values:

* **Resiliency & Cost Optimization:** Cross-site Active Directory replication and RAID 5 storage guarantee zero downtime during link failures. Additionally, configuring Data Deduplication optimized storage capacity by immediately saving **42% of disk space**.
* **Enterprise-Grade Security:** The environment moves toward a Zero-Trust model by replacing weak entry points with automated **Enterprise PKI Certificates (ADCS)**, secure **Federated Single Sign-On (ADFS)** tokens, and a persistent **IKEv2 IPsec VPN Tunnel** to encrypt all traffic across the public internet.
* **Modern IT Automation:** Utilizing Linux Ansible control nodes to configure Windows systems via WinRM over HTTPS eliminates manual configuration errors, prevents security drift, and ensures the entire network can be deployed cleanly and scaled efficiently.




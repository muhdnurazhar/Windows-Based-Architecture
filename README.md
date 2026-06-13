# Windows-Based-Architecture
A secure multi-site corporate infrastructure featuring Active Directory, hybrid PKI, ADFS, and certificate-based IKEv2 IPsec VPN

## Introduction
This repository showcases simulation of the deployment of a resilent, secure multi-site hybrid infrastructure.The solution simulates a modern corporate expansion by integrating a few virtual machine of Windows Server 2022 and Debian 13 Linux management to ensure rapid connection, secure and automate some configuration management.

### Project Objective & Site Breakdown
The infrastructure has been divided across network into 3 segments:

1. A-HEADQUARTERS (wsmb2026.my)
> Acts as the central of core identity management, security enforcement, and federated access control
   * **Identity Management:** Deploys Primary ADDS with appropriate parameter Powershell for bulk-user creation specifc for provisioning framework.
   * **Secure Single Sign-On (SS0):** Integrates Active Directory Federation services and WAP to pre-authenticated external access to the internal backend server
   * **Enterprise PKI Infrastructure:** Implements and Enterprise Subordinate Certification (ADCS) to handle internal certficates for services such as auto-enrollment certificate, HTTPS services and CRL/AIA externsion.
   * **Provisioning File Architecture:** Setup a deduplicated RAID 5 storage volume hosting by DFS namespaces, Work Folders, and file sharing enumeration based permissions. 
2. B-BRANCH (branch.wsmb2026.my)
> Simulates a remote office extending local infrastructure capabilities while still maintaining parity with Headquarters.
   * **Centralized Identity Management:** Provisioning credential for users that can have permissions and rights according department responsibilities.
   * **Automated Active Directory:** Automated Windows domain group and folder permission setup using Ansible on Debian Linux.
   *  **WinRM Execution:** Enforces a secure remote management via WinRM over port HTTPS 5986 and eliminates others unencrypted channels communication.

3. C-INET (ns.msftncsi.com)
> This segments will simulate a real indicator of NCSI connectivity and make it similar like internet access.
   *  **DNS & Connectivity Check:** Built a fake internet Root DNS and microsoft NCSI service to test domain name resolution and connectivity.
   *  **Root Certificate Authority:** Set up a standalone Root CA (ISP-CA) to issue certificates for enterprise systems.
   *  **Secure VPN Tunnels:** Configured Windows RRAS to run IKEV2 IPsec site-to-site VPN tunnels between Headquarters and Branch using certificates for authentication.

### Technical Architecture & Implementation Workflow

<img width="1440" height="598" alt="image" src="https://github.com/user-attachments/assets/9f32a3ef-122b-4c7c-8825-68fb5198fc27" />

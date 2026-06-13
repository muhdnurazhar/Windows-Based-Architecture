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


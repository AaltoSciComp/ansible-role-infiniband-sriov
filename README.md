Ansible-role-infiniband
=======================

A role to manage infiniband setup and configs including sr-iov. Tested on RHEL 9.x variant systems. 

Role Variables
--------------

**setup_sriov: "true/false"**. If defined, sets up a systemd service on a boot time to bring up 
Infiniband Virtual Functions if those are enabled in Bios/Infiniband card firmware level. Allows 
giving these virtual devises (node and port) predefined GUIDs.

    sriov_port_node_guid:
    - 11:22:33:44:55:66:77:01,11:22:33:44:55:66:77:11
    - 11:22:33:44:55:66:77:02,11:22:33:44:55:66:77:12


**setup_libvirt_pcie**: "true/false"**. If defined allows host server to attach devices 
(usually above virtual functions) to existing libvirt machines. This brings Infiniband capability 
directly to libvirt virtual machines. Assumes "community.libvirt" is available for Ansible.

kvm_ib_dev:
  vm1:
    ib_bus: 0x01
    ib_slot: 0x00
    ib_function: 0x1


Example Playbook
----------------

Setup above variables and simply include the role.

    - hosts: servers
      roles:
         - { role: ansible-role-infiniband, tags: ['infiniband'] }

License
-------

MIT

Author Information
------------------

Mikko Hakala

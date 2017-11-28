samba
=====
Install and configure a samba server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:
    
``samba``
---------

Installs the samba server package and service.

``samba.client``
----------------

Installs the samba client package.

``samba.config``
----------------

Includes the ``samba`` state.

Creates a ``smb.conf`` based on defaults. Pillars, if defined, are merged with defaults.  The presence of the ``krb5.default_realm`` parameter in pillar data ensures Active Directory configuration is integrated with 'global' section of ``smb.conf``.

``samba.users``
----------------

Includes the ``samba`` state.

Creates samba users (via ``smbpasswd``)  based on pillar data.

``samba.winbind``
----------------

Includes the ``samba`` state. 

Installs samba-winbind packages and updates NSS (nsswitch.conf).

``samba.winbind-ad``
----------------

Includes the ``winbind`` state.

Active Directory integration.


Configuration
=============

Installing the samba package will include a default ``smb.conf`` from linux distribution binaries. To generate a default formula ``smb.conf`` instead use the ``samba.config`` state which applies configuration based on formula defaults (defaults.yaml), but optionally customized via pillar data.


{% from "samba/map.jinja" import samba with context %}

include:
  - samba.winbind

{% if grains.os_family in ('RedHat',) %}

samba_winbind_ad_authconfig:
  cmd.run:
    - name: {{ samba.winbind.pam_authconfig }}
    - onlyif: test -f /usr/sbin/authconfig
    - require:
      - pkg: samba_winbind_software
    - watch_in:
      - service: samba_winbind_services

{% else %}

  {% for config in samba.winbind.nsswitch.regex %}
samba_winbind_nsswitch_{{ config[0] }}:
  file.replace:
    - name: /etc/nsswitch.conf
    - pattern: {{ config[1] }}
    - repl: {{ config[2] }}
    - backup: '.salt.bak'
    - require:
      - pkg: samba_winbind_software
  {% endfor %}

  {% if grains.os_family in ('Debian',) %}

samba_winbind_ad_common_session:
  file.replace:
    - name: {{ samba.winbind.pam_common.session_config }}
    - onlyif: test -f {{ samba.winbind.pam_common.session_config }}
    - pattern: {{ samba.winbind.pam_common_session.regex[0] }}
    - repl: {{ samba.winbind.pam_common_session.regex[1] }}
    - backup: '.salt.bak'
    - require:
      - pkg: samba_winbind_software
    - require_in:
      - samba_winbind_ad_common_auth

samba_winbind_ad_common_auth:
  file.append:
    - name: {{ samba.winbind.pam_common.auth_config }}
    - onlyif: test -f {{ samba.winbind.pam_common.auth_config }}
    - text:
      {% for text in samba.winbind.pam_common.auth_text %}
      - {{ text }}
      {% endfor %} 
    - watch_in:
      - service: samba_winbind_services

  {% endif %}
{% endif %}

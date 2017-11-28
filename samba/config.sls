{% from "samba/map.jinja" import samba with context %}

include:
  - samba

samba_config:
  file.managed:
    - name: {{ samba.config }}
    - source: {{ samba.config_src }}
    - user: root
    - group: {{ samba.get('root_group', 'root') }}
    - mode: 0644
    - template: jinja
    - watch_in:
      - service: samba

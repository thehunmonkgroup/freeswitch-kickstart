{% from 'vars.jinja' import freeswitch_git_checkout with context %}

include:
  - service.freeswitch
  - service.httpd

verto-demo-symlink-html:
  file.symlink:
    - name: /var/www/html/demo
    - target: {{ freeswitch_git_checkout }}/html5/verto/demo
    - require:
      - cmd: freeswitch-build
      - pkg: httpd-packages

verto-video-demo-symlink-html:
  file.symlink:
    - name: /var/www/html/verto
    - target: {{ freeswitch_git_checkout }}/html5/verto/video_demo
    - require:
      - cmd: freeswitch-build
      - pkg: httpd-packages

verto-video-demo-symlink-dialplan:
  file.symlink:
    - name: /usr/local/freeswitch/conf/dialplan/default/0000_verto_video_demo.xml
    - target: {{ freeswitch_git_checkout }}/html5/verto/video_demo/dp/dp.xml
    - require:
      - cmd: freeswitch-build

/var/www/html/sounds:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - require:
      - pkg: httpd-packages

# TODO: Remove this?
#/usr/local/freeswitch/conf/dialplan/default/0000_dp.xml:
#  file.managed:
#    - source: salt://service/freeswitch/verto-demo/0000_dp.xml
#    - user: root
#    - group: root
#    - mode: 644
#    - require:
#      - cmd: freeswitch-build

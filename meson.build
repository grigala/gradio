project('gradio', ['vala', 'C'], version : '6.0')

i18n = import('i18n')

cc = meson.get_compiler('c')
libm = cc.find_library('m', required: false)
glib = dependency('glib-2.0')
gobject = dependency('gobject-2.0')
gio = dependency('gio-2.0')
gtk = dependency('gtk+-3.0', version : '>=3.20')
libsoup = dependency('libsoup-2.4')
json_glib = dependency('json-glib-1.0')
gstreamer = dependency('gstreamer-1.0')
gstreamer_pbutils = dependency('gstreamer-pbutils-1.0')
sqlite3 = dependency('sqlite3')

add_project_arguments('-DGETTEXT_PACKAGE="gradio"', language: 'c')
add_project_arguments('-DDATADIR="' + get_option('datadir') + '"', language: 'c')
add_project_arguments('-DG_LOG_DOMAIN="gradio"', language: 'c')


subdir('data')
subdir('po')
subdir('external')
subdir('src')

meson.add_install_script('meson_post_install.sh')

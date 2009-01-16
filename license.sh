#!/bin/sh

# Working notes on license status: it's a bit mixed here
#
# gui/win32/Main/TrayIcon.cpp|h have none
# gui/win32/Main/StdAfx.cpp/h are generated (have none)
# gui/win32/Main/resource.h is generated (has none)
# gui/linux-gtk/* is GPLv2
# contrib/netsimpcap is GPLv3
# src/win32/ce/ws2tcpip.h has none
# src/olsr_ip_prefix_list.h has none
# lib/secure/src/md5.h is some homegrown RSA Inc.
# lib/quagga states GPLv2 or LGPLv2

bsd_revised()
  cat<<EOF

The olsr.org Optimized Link-State Routing daemon(olsrd)
$1
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions 
are met:

* Redistributions of source code must retain the above copyright 
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright 
  notice, this list of conditions and the following disclaimer in 
  the documentation and/or other materials provided with the 
  distribution.
* Neither the name of olsr.org, olsrd nor the names of its 
  contributors may be used to endorse or promote products derived 
  from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.
EOF

case "$1" in
    "")
        echo "Please provide a file name."
        exit 1
    ;;
    license.txt)
        bsd_revised "Copyright (c) 2004, Andreas Tonnesen(andreto@olsr.org)
                    Thomas Lopatic(thomas@lopatic.de)"|diff -q $1 - && echo "$1 matches."
    ;;
    src/common/string.*|src/ipcalc.*|src/plugin_util.*)
        bsd_revised "$(hg log $1|sed -n '/user:/{s/[^ ]* *//;s/.$/&/;h};/date:/{s/[^ ]* *[^ ]* *[^ ]* *[^ ]* *[^ ]* */Copyright (c) /;s/ [^ ]*$/, /;G;s/\n//;s/@/æ/;p}'|sort|uniq)"
    ;;
    *)
        bsd_revised "Copyright (c) 2004-$(date +%Y), the olsr.org team - see HISTORY file"
    ;;
esac
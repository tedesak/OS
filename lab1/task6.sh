#!/bin/bash
grep '^\[ *[^ ]*\]' /var/log/anaconda/X.log | awk '/(WW)/{$3="Warning:"; print $0}' > full.log
grep '^\[ *[^ ]*\]' /var/log/anaconda/X.log | awk '/(II)/{$3="Information:"; print $0}' >> full.log
cat full.log 
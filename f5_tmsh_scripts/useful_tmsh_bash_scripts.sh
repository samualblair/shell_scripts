# Provided initially be  Robin_78503 Nimbostratus at https://community.f5.com/t5/technical-forum/modify-vs-profiles-using-tmsh/td-p/117679
# Simple but useful scripted ways to make many repeated changes


# Here are a whole bunch that you may use (with extreme caution of coarse because lazy_sysadmin & be especially cautious on systems that use non-http virtual servers like ldap):

# Lists the names of the virtual servers with the basic tcp profile assigned:
tmsh list ltm virtual one-line | grep "profiles.*\ tcp\ " | awk '{ print $3 }'

# Changes the individual virtual server’s profile manually (edit VIRTUAL_SERVER_NAME to whichever one you want to edit):
tmsh mod ltm virtual $VIRTUAL_SERVER_NAME profiles add { tcp-wan-optimized { context all } } profiles delete { tcp }

# This is ugly but performs the previous two steps on all virtual servers that need the change made:
tmsh list ltm virtual one-line | grep "profiles.*\ tcp\ " | awk '{ print $3 }' | xargs -I vs_name tmsh mod ltm virtual vs_name profiles add { tcp-wan-optimized { context all } } profiles delete { tcp }

# Lists the virtual servers with only simple http compression applied:
tmsh list ltm virtual one-line | grep "profiles.*\ httpcompression\ " | awk '{ print $3 }'

# manually change individual virtual server (edit variable):
tmsh mod ltm virtual $VIRTUAL_SERVER_NAME profiles add { wan-optimized-compression { context all } } profiles delete { httpcompression }

# Again, super ugly but does the job. Move all to wan-optimized-compression:
tmsh list ltm virtual one-line | grep "profiles.*\ httpcompression\ " | awk '{ print $3 }' | xargs -I vs_name tmsh mod ltm virtual vs_name profiles add { wan-optimized-compression { context all } } profiles delete { httpcompression }

# Wait a sec, which ones do not have the wan-optimized-compression profile enabled?
tmsh list ltm virtual one-line | grep -v " wan-optimized-compression\ "

# Apply this to all of them:
tmsh list ltm virtual one-line | grep -v " wan-optimized-compression\ " | grep virtual | awk '{ print $3 }' | xargs -I vs_name tmsh mod ltm virtual vs_name profiles add { wan-optimized-compression { context all } }

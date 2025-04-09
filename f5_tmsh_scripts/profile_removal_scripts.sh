# Inspiration from commands provided by Robin_78503 Nimbostratus at https://community.f5.com/t5/technical-forum/modify-vs-profiles-using-tmsh/td-p/117679

# Looking to remove this profile "request-log /Common/F5-Analytics-local.app/pr-F5-Analytics-logging"
# On a single virtual server this would be a tmsh command:
# tmsh modify ltm virtual <VS_NAME_HERE> profiles delete { /Common/F5-Analytics-local.app/pr-F5-Analytics-logging }

# From All of the virtual servers
# This simple bash 'script' (command chain) should acomplish this.
# 1 # Filters entire config into virtual servers only, in one-line format
# 2 # Filters the output from 1 by just items with the profile of interest
# 3 # Filters the elements down to just the profile name
# 4 # Finally sets the virtual server name to the the value from 3 and runs th removal command (for each vaule found in 3)

# Run from BASH not TMSH

# Can test what the expeted commands to run would be with this version - WILL NOT RUN COMMANDS, just ECHO the commands to the screen
tmsh list ltm virtual one-line | grep "profiles.*\ PROFILENAME\ " | awk '{ print $3 }' | xargs -I vs_name echo tmsh modify ltm virtual vs_name profiles delete { PROFILENAME }

# THIS WILL GENERATE AND RUN EACH OF THE COMMANDS - REMOVING THE PROFILE FROM ALL VIRTUAL SERVERS
tmsh list ltm virtual one-line | grep "profiles.*\ PROFILENAME\ " | awk '{ print $3 }' | xargs -I vs_name tmsh modify ltm virtual vs_name profiles delete { PROFILENAME }

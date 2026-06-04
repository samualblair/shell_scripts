#!/bin/bash
# Inspiration from commands provided by Robin_78503 Nimbostratus at https://community.f5.com/t5/technical-forum/modify-vs-profiles-using-tmsh/td-p/117679

# Looking to remove this profile "request-log /Common/F5-Analytics-local.app/pr-F5-Analytics-logging"
# On a single virtual server this would be a tmsh command:
# tmsh modify ltm virtual <VS_NAME_HERE> profiles delete { /Common/F5-Analytics-local.app/pr-F5-Analytics-logging }

# From All of the virtual servers
# This simple bash script (command chain) should accomplish this.
# 1 # Filters entire config into virtual servers only, in one-line format
# 2 # Filters the output from 1 by just items with the profile of interest
# 3 # Filters the elements down to just the profile name
# 4 # Finally sets the virtual server name to the the value from 3 and runs th removal command (for each value found in 3)

# The script will run through each profile listed in variable (list) F5_PROFILES_TO_REMOVE
# The output (the commands used, and any errors) will be redirected into a text file with the name of the 'profile name' + _removal.txt

# Run from BASH not TMSH

# Be sure to populate list of profiles to remove below
F5_PROFILES_TO_REMOVE="serverldap1 tcpprofile123 analyticsprofile321"

# Ensure profiles to remove files are in proper list ($F5_PROFILES_TO_REMOVE)

for f5_profile_to_remove in $F5_PROFILES_TO_REMOVE
do

  echo "###### PARSING DATE: $(date)" >> "${f5_profile_to_remove}_removal.txt"

  # Can test what the expected commands to run would be with this version - WILL NOT RUN COMMANDS, just ECHO the commands to the screen
  tmsh list ltm virtual one-line | grep "profiles.*\ ${f5_profile_to_remove}\ " | awk '{ print $3 }' | xargs -I vs_name echo tmsh modify ltm virtual vs_name profiles delete \{ ${f5_profile_to_remove} \} >> "${f5_profile_to_remove}_removal.txt"

  # THIS WILL GENERATE AND RUN EACH OF THE COMMANDS - REMOVING THE PROFILE FROM ALL VIRTUAL SERVERS
  tmsh list ltm virtual one-line | grep "profiles.*\ ${f5_profile_to_remove}\ " | awk '{ print $3 }' | xargs -I vs_name tmsh modify ltm virtual vs_name profiles delete \{ ${f5_profile_to_remove} \} >> "${f5_profile_to_remove}_removal.txt"

  echo "###### PARSING END   ######" >> "${f5_profile_to_remove}_removal.txt"

done
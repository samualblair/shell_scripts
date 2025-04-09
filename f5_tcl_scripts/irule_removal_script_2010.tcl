# TCL script leveraging TMSH scripting to remove iRule from ALL Virtual Servers
# This Script takes the input of an iRule name and removes from ALL virtual servers that have it.
# The script will return a list of virtual server names that it was removed from.
# Obtained from F5 DevCentral https://community.f5.com/t5/technical-articles/rapid-irule-removal-via-tmsh-script/ta-p/287349
# Article published (last updated) May 14 2010
# Demonstration on https://youtu.be/OHWGukAttSI

# Example to create the script (could also just copy to scripts folder):
# (tmos)# edit cli script script_name_here.tcl 

# Example to run script via CLI (from tmsh):
# (tmos)# run cli script script_name_here.tcl irule_name_here

proc script::run {} {
    if { $tmsh::argc != 2 } {
        puts "A single rule name must be provided"
        exit
    }
    set rulename [lindex $tmsh::argv 1]
    set rules ""
    set vips [tmsh::get_config /ltm virtual]
    set vips_in_play ""

    tmsh::begin_transaction

    foreach vip $vips {
        if { [tmsh::get_field_value $vip "rules" rules] == 0 } {
            continue
        }
        if { [lsearch -exact $rules $rulename] == -1 } {
            continue
        }
        if { [llength $rules] < 2 } {
            tmsh::modify /ltm virtual [tmsh::get_name $vip] rules none
            lappend vips_in_play $vip
        } else {
            set id [lsearch -exact $rules $rulename]
            set keepers [lreplace $rules $id $id]
            tmsh::modify /ltm virtual [tmsh::get_name $vip] rules "{ $keepers }"
            lappend vips_in_play $vip
        }
    }

    tmsh::commit_transaction

    puts "The $rulename iRule was removed from the following virtuals: "
    foreach x $vips_in_play {
        puts "\t[tmsh::get_name $x]"
    }
}

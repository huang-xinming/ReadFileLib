##############################################################
# Read .csv file to list
# .csv format is
# header1,header2,header3,....
# a      ,      b,      c,
##############################################################
proc ReadCSVtoList {f_in start_line elem_num} {
    #arg f_in:input file path, eg. "C:/Working/config.csv"
    #arg start_line: the line num to start reading from, first line is 1
    #arg elem_num: number of elements in each line
    #output return a list
	set file_in [open $f_in r];
	set temp [read $file_in];
	close $file_in
	set temp [split $temp "\n"];
	set count [llength $temp];
    if {$count<$start_line} {
        return -code error "Error: Reading from Line $start_line in a $count Line file"
    } else {
        set temp_list "";
        for {set i [expr $start_line-1]} {$i<$count} {incr i} {
        	set data [split [lindex $temp $i] ","]
            if {[llength $data]==$elem_num} {
				if {[lsearch -exact $data ""]==-1} {
					lappend temp_list $data;
				} else {
					set tmpid [lsearch -exact $data ""]
					return -code error "Error: No.[expr $tmpid+1] elem in Line [expr $i+1] is empty"
				}
            } elseif {[llength $data]==0} {
            	puts "Line [expr $i+1] is Empty,Skipped"
            } else {
                return -code error "Error: Number of Elements in Line [expr $i+1] is not $elem_num"
            }
        }
        return $temp_list
    }
}
#usage:
set f_in [file join [file dir [info script]] "config.csv"]
puts $f_in
puts [ReadCSVtoList $f_in 1 4]
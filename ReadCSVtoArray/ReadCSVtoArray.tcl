#	read .csv file to array
#	input .csv:
#		ArrayName,ArrayElem_1,ArrayElem_2,ArrayElem_3
#		Huang,Male,1984/4/7,Master
#		Swift,Female,1945/1/2,Bachlor
#	output:
#		array(huang Xinming) {Male 1984/4/7 Master}

proc ReadCSVtoArray {myArray f_in start_line elem_num name_index} {
    #art myArray: the variable to store the data, myArray(name)
	#arg f_in:input file path, eg. "C:/Working/config.csv"
    #arg start_line: the line num to start reading from, first line is 1
    #arg elem_num: number of elements in each line
	#arg name_index: the index of elems used as array name, 1 is first elem, 2 is first two elem seperated by ","
    #output return array
	upvar $myArray tmp_array;
	set file_in [open $f_in r];
	set temp [read $file_in];
	close $file_in
	set temp [split $temp "\n"];
	set count [llength $temp];
    if {$count<$start_line} {
        return -code error "Error: Reading from Line $start_line in a $count Line file"
    } else {
        for {set i [expr $start_line-1]} {$i<$count} {incr i} {
			set data [split [lindex $temp $i] ","]
            if {[llength $data]==$elem_num} {
				if {[lsearch -exact $data ""]==-1} {
					set tmp_name [lrange $data 0 [expr $name_index-1]]
					set array_name [lindex $tmp_name 0];
					for {set ii 1} {$ii<$name_index} {incr ii} {
						append array_name "," [lindex $tmp_name $ii]
					}
					set tmp_array($array_name) [lrange $data [expr $name_index] end]
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
    }
}
#usage:
set f_in [file join [file dir [info script]] "config.csv"]
puts $f_in
ReadCSVtoArray test_array $f_in 2 4 1
foreach n [array names test_array] {
	puts "name:$n value:$test_array($n)"
}
#usage:
array unset test_array
ReadCSVtoArray test_array $f_in 2 4 2
foreach n [array names test_array] {
	puts "name:$n value:$test_array($n)"
}




#source lib file
set libDir [file join [file dir [info script]] "lib"]
source "$libDir/ReadCSV.tcl"

catch {namespace delete ::Test}
namespace eval ::Test {
	set f_in [file join [file dir [info script]] "config.csv"]
	variable test_list;
}

#usage: read to array
proc ::Test::ArrayTest {} {
	::ReadCSV::toArray ::Test::test_array $::Test::f_in 2 4 2
}
::Test::ArrayTest
foreach n [array names ::Test::test_array] {
		puts "name:$n value:$::Test::test_array($n)"
	}

#usage: read to list
proc ::Test::ListTest {} {
	::ReadCSV::toList ::Test::test_list $::Test::f_in 2 4
}
::Test::ListTest
puts $::Test::test_list
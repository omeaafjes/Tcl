# This procedure takes a list "inlist" as argument and pushes the position of the elements forward by "trans"

proc cyclicPerm { inlist trans } {
 set l [ llength $inlist ]
 set helplist {}
 for { set i 0 } { $i < $l } { incr i} {
  set m [ expr [ expr $i + $trans ] % $l ] 
  lappend $helplist [lindex $inlist [ $m ]]
 }
 return $helplist
}


package provide mytools 1.0
package require Tcl 8.6

namespace eval ::mytools {

namespace export hexToAscii hexToAscii3 xorStr toHex asciiToHex ascii strToBin xorHex xorHex2 hexToList xorEnc xorEnc2 findCapitals arrCipher arrXor reconWord

}

proc ::mytools::hexToAscii { input } {
 set LEN [ llength $input ]
 for { set i 0 } { $i < $LEN } { incr i } {
  set h [ split [lindex $input $i] : ]
  #puts $h
  set out([lindex $h 0]) [lindex $h 1]
  }
 return [array get out]
}

proc ::mytools::hexToAscii3 { input1 } {
 set input [ string tolower $input1 ]
 set LEN [ llength $input ]
 for { set i 0 } { $i < $LEN - 1 } { incr i } {
  set h [ split [lindex $input $i] : ]
  #puts $h
  set out([lindex $h 0]) [lindex $h 1]
  }
 return [array get out]
}

proc mytools::xorStr { str1 str2 } {
 set out {}
 if { [llength $str1 ] > [llength $str2 ] } {
  set max [ llength $str2 ]
 } else {
 set max [ llength $str1 ]
 }
for { set i 0} { $i < $max } {incr i} {
 lappend out [ expr [ lindex $str1 $i ] ^ [ lindex $str2 $i ] ]
}

return $out

} 
  
proc ::mytools::toHex input {
 set out {}
  foreach m $input { 
   lappend out 0x$m
  }
 return out
}

proc ::mytools::asciiToHex { input } {
 set LEN [ llength $input ]
 for { set i 0 } { $i < $LEN } { incr i } {
  set h [ split [lindex $input $i] : ]
  #puts $h
  set out([lindex $h 1]) [lindex $h 0]
  }
 return [array get out]
}


proc ::mytools::ascii {} {
    set res {}
    for {set i 33} {$i<127} {incr i} {
        append res "[format %2.2X:%c $i $i] "
        if {$i%16==0} {append res \n}
    }
    set res
}

proc ::mytools::strToList input {
 set output { }
 set slen [string length $input]
  
  for {set i 0} {$i < $slen} { incr i} {
   lappend output [string range $input $i $i]
  }
 return $output
}

proc ::mytools::listToString input { 
 for { set i 0 } { $i < [llength $input] } { incr i } {
  append out [lindex $input $i]
 }
 return i
}

proc ::mytools::strToBin input {
 set N [llength $input]
 binary scan $input "c*" out
 return $out
}

proc ::mytools::xorHex { hex1 hex2 } {
 scan $hex1 %llx dec1
 scan $hex2 %llx dec2
  
 set r [ expr $dec1 ^ $dec2 ]


return [ format %llx $r ] 

}

proc ::mytools::hexToList hexs {
 set l {}
 for { set i 0 } { $i < [string length $hexs ] } { incr i 2 } { 
 lappend l [string index $hexs $i][string index $hexs [ expr $i + 1 ] ]
 }
return $l
}

proc ::mytools::xorHex2 { hex1 hex2 } {
 set l1 [ string length $hex1 ]
 set l2 [ string length $hex2 ]
 if { $l1 > $l2 } {
  set start [ expr $l1 - $l2 ]
  set h1 [ string range $hex1 $start $l1 ]
  set h2 $hex2
 } else {
 set start [ expr $l2 - $l1 ]
 set h1 $hex1
 set h2 [ string range $hex2 $start $l2 ]
 }
 
 scan $h1 %llx dec1
 scan $h2 %llx dec2
  
 set r [ expr $dec1 ^ $dec2 ]


return [ format %llx $r ] 

}

proc ::mytools::xorEnc { c1 c2 } {
 set rc1 [ string reverse $c1 ]
 set rc2 [ string reverse $c2 ]
 set r12 [ mytools::xorHex2 $rc1 $rc2 ]
 set rl [ mytools::hexToList $r12 ]
 
  return [ string reverse $rl ]
}

proc ::mytools::xorEnc2 { c1 c2 } {
 set rc1 [ string reverse $c1 ]
 set rc2 [ string reverse $c2 ]
 set r12 [ mytools::xorHex2 $rc1 $rc2 ]
 set rr12 [ string reverse $r12 ]
 
  return [ mytools::hexToList $rr12 ]
}

proc ::mytools::findCapitals input {

set cap { 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 51 52 53 54 55 56 57 58 59 5a }
set l {}
set res {}

foreach k $cap {
 set p [ lsearch -all $input $k ]
 lappend l $p
}

foreach q $l {
 set res [ concat $res $q ]
}

return [ lsort -integer $res ]
}

proc ::mytools::arrCipher { } {
#defines the ciphers and provides an array with the ciphers as elements
#use commands " array set ta [ arrCipher ]" to use array output 

set c1 315c4eeaa8b5f8aaf9174145bf43e1784b8fa00dc71d885a804e5ee9fa40b16349c146fb778cdf2d3aff021dfff5b403b510d0d0455468aeb98622b137dae857553ccd8883a7bc37520e06e515d22c954eba5025b8cc57ee59418ce7dc6bc41556bdb36bbca3e8774301fbcaa3b83b220809560987815f65286764703de0f3d524400a19b159610b11ef3e
 
set c2 234c02ecbbfbafa3ed18510abd11fa724fcda2018a1a8342cf064bbde548b12b07df44ba7191d9606ef4081ffde5ad46a5069d9f7f543bedb9c861bf29c7e205132eda9382b0bc2c5c4b45f919cf3a9f1cb74151f6d551f4480c82b2cb24cc5b028aa76eb7b4ab24171ab3cdadb8356f

set c3 32510ba9a7b2bba9b8005d43a304b5714cc0bb0c8a34884dd91304b8ad40b62b07df44ba6e9d8a2368e51d04e0e7b207b70b9b8261112bacb6c866a232dfe257527dc29398f5f3251a0d47e503c66e935de81230b59b7afb5f41afa8d661cb

set c4 32510ba9aab2a8a4fd06414fb517b5605cc0aa0dc91a8908c2064ba8ad5ea06a029056f47a8ad3306ef5021eafe1ac01a81197847a5c68a1b78769a37bc8f4575432c198ccb4ef63590256e305cd3a9544ee4160ead45aef520489e7da7d835402bca670bda8eb775200b8dabbba246b130f040d8ec6447e2c767f3d30ed81ea2e4c1404e1315a1010e7229be6636aaa

set c5 3f561ba9adb4b6ebec54424ba317b564418fac0dd35f8c08d31a1fe9e24fe56808c213f17c81d9607cee021dafe1e001b21ade877a5e68bea88d61b93ac5ee0d562e8e9582f5ef375f0a4ae20ed86e935de81230b59b73fb4302cd95d770c65b40aaa065f2a5e33a5a0bb5dcaba43722130f042f8ec85b7c2070

set c6 32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd2061bbde24eb76a19d84aba34d8de287be84d07e7e9a30ee714979c7e1123a8bd9822a33ecaf512472e8e8f8db3f9635c1949e640c621854eba0d79eccf52ff111284b4cc61d11902aebc66f2b2e436434eacc0aba938220b084800c2ca4e693522643573b2c4ce35050b0cf774201f0fe52ac9f26d71b6cf61a711cc229f77ace7aa88a2f19983122b11be87a59c355d25f8e4

set c7 32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd90f1fa6ea5ba47b01c909ba7696cf606ef40c04afe1ac0aa8148dd066592ded9f8774b529c7ea125d298e8883f5e9305f4b44f915cb2bd05af51373fd9b4af511039fa2d96f83414aaaf261bda2e97b170fb5cce2a53e675c154c0d9681596934777e2275b381ce2e40582afe67650b13e72287ff2270abcf73bb028932836fbdecfecee0a3b894473c1bbeb6b4913a536ce4f9b13f1efff71ea313c8661dd9a4ce

set c8 315c4eeaa8b5f8bffd11155ea506b56041c6a00c8a08854dd21a4bbde54ce56801d943ba708b8a3574f40c00fff9e00fa1439fd0654327a3bfc860b92f89ee04132ecb9298f5fd2d5e4b45e40ecc3b9d59e9417df7c95bba410e9aa2ca24c5474da2f276baa3ac325918b2daada43d6712150441c2e04f6565517f317da9d3

set c9 271946f9bbb2aeadec111841a81abc300ecaa01bd8069d5cc91005e9fe4aad6e04d513e96d99de2569bc5e50eeeca709b50a8a987f4264edb6896fb537d0a716132ddc938fb0f836480e06ed0fcd6e9759f40462f9cf57f4564186a2c1778f1543efa270bda5e933421cbe88a4a52222190f471e9bd15f652b653b7071aec59a2705081ffe72651d08f822c9ed6d76e48b63ab15d0208573a7eef027

set c10 466d06ece998b7a2fb1d464fed2ced7641ddaa3cc31c9941cf110abbf409ed39598005b3399ccfafb61d0315fca0a314be138a9f32503bedac8067f03adbf3575c3b8edc9ba7f537530541ab0f9f3cd04ff50d66f1d559ba520e89a2cb2a83

set c11 32510ba9babebbbefd001547a810e67149caee11d945cd7fc81a05e9f85aac650e9052ba6a8cd8257bf14d13e6f0a803b54fde9e77472dbff89d71b57bddef121336cb85ccb8f3315f4b52e301d16e9f52f904

set cl [ concat $c1 $c2 $c3 $c4 $c5 $c6 $c7 $c8 $c9 $c10 $c11 ]
 
foreach k { 0 1 2 3 4 5 6 7 8 9 10 } {
 set ca($k) [ lindex $cl $k ]
}

return [ array get ca ]

} 


proc ::mytools::arrXor { } {
#defines the ciphers and provides a 2-dimensional array with the with the i,j-th element being the xor of m(i) with m(j)
#use commands " array set p [ arrXor ]" to use array output 

set c1 315c4eeaa8b5f8aaf9174145bf43e1784b8fa00dc71d885a804e5ee9fa40b16349c146fb778cdf2d3aff021dfff5b403b510d0d0455468aeb98622b137dae857553ccd8883a7bc37520e06e515d22c954eba5025b8cc57ee59418ce7dc6bc41556bdb36bbca3e8774301fbcaa3b83b220809560987815f65286764703de0f3d524400a19b159610b11ef3e
 
set c2 234c02ecbbfbafa3ed18510abd11fa724fcda2018a1a8342cf064bbde548b12b07df44ba7191d9606ef4081ffde5ad46a5069d9f7f543bedb9c861bf29c7e205132eda9382b0bc2c5c4b45f919cf3a9f1cb74151f6d551f4480c82b2cb24cc5b028aa76eb7b4ab24171ab3cdadb8356f

set c3 32510ba9a7b2bba9b8005d43a304b5714cc0bb0c8a34884dd91304b8ad40b62b07df44ba6e9d8a2368e51d04e0e7b207b70b9b8261112bacb6c866a232dfe257527dc29398f5f3251a0d47e503c66e935de81230b59b7afb5f41afa8d661cb

set c4 32510ba9aab2a8a4fd06414fb517b5605cc0aa0dc91a8908c2064ba8ad5ea06a029056f47a8ad3306ef5021eafe1ac01a81197847a5c68a1b78769a37bc8f4575432c198ccb4ef63590256e305cd3a9544ee4160ead45aef520489e7da7d835402bca670bda8eb775200b8dabbba246b130f040d8ec6447e2c767f3d30ed81ea2e4c1404e1315a1010e7229be6636aaa

set c5 3f561ba9adb4b6ebec54424ba317b564418fac0dd35f8c08d31a1fe9e24fe56808c213f17c81d9607cee021dafe1e001b21ade877a5e68bea88d61b93ac5ee0d562e8e9582f5ef375f0a4ae20ed86e935de81230b59b73fb4302cd95d770c65b40aaa065f2a5e33a5a0bb5dcaba43722130f042f8ec85b7c2070

set c6 32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd2061bbde24eb76a19d84aba34d8de287be84d07e7e9a30ee714979c7e1123a8bd9822a33ecaf512472e8e8f8db3f9635c1949e640c621854eba0d79eccf52ff111284b4cc61d11902aebc66f2b2e436434eacc0aba938220b084800c2ca4e693522643573b2c4ce35050b0cf774201f0fe52ac9f26d71b6cf61a711cc229f77ace7aa88a2f19983122b11be87a59c355d25f8e4

set c7 32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd90f1fa6ea5ba47b01c909ba7696cf606ef40c04afe1ac0aa8148dd066592ded9f8774b529c7ea125d298e8883f5e9305f4b44f915cb2bd05af51373fd9b4af511039fa2d96f83414aaaf261bda2e97b170fb5cce2a53e675c154c0d9681596934777e2275b381ce2e40582afe67650b13e72287ff2270abcf73bb028932836fbdecfecee0a3b894473c1bbeb6b4913a536ce4f9b13f1efff71ea313c8661dd9a4ce

set c8 315c4eeaa8b5f8bffd11155ea506b56041c6a00c8a08854dd21a4bbde54ce56801d943ba708b8a3574f40c00fff9e00fa1439fd0654327a3bfc860b92f89ee04132ecb9298f5fd2d5e4b45e40ecc3b9d59e9417df7c95bba410e9aa2ca24c5474da2f276baa3ac325918b2daada43d6712150441c2e04f6565517f317da9d3

set c9 271946f9bbb2aeadec111841a81abc300ecaa01bd8069d5cc91005e9fe4aad6e04d513e96d99de2569bc5e50eeeca709b50a8a987f4264edb6896fb537d0a716132ddc938fb0f836480e06ed0fcd6e9759f40462f9cf57f4564186a2c1778f1543efa270bda5e933421cbe88a4a52222190f471e9bd15f652b653b7071aec59a2705081ffe72651d08f822c9ed6d76e48b63ab15d0208573a7eef027

set c10 466d06ece998b7a2fb1d464fed2ced7641ddaa3cc31c9941cf110abbf409ed39598005b3399ccfafb61d0315fca0a314be138a9f32503bedac8067f03adbf3575c3b8edc9ba7f537530541ab0f9f3cd04ff50d66f1d559ba520e89a2cb2a83

set c11 32510ba9babebbbefd001547a810e67149caee11d945cd7fc81a05e9f85aac650e9052ba6a8cd8257bf14d13e6f0a803b54fde9e77472dbff89d71b57bddef121336cb85ccb8f3315f4b52e301d16e9f52f904

set cl [ concat $c1 $c2 $c3 $c4 $c5 $c6 $c7 $c8 $c9 $c10 $c11 ]
 
foreach k { 0 1 2 3 4 5 6 7 8 9 10 } {
 set ca($k) [ lindex $cl $k ]
}

foreach k { 0 1 2 3 4 5 6 7 8 9 10 } {
 foreach l { 0 1 2 3 4 5 6 7 8 9 10 } {
  set xor($k,$l) [ mytools::xorEnc2 $ca($k) $ca($l) ]
 }
}



return [ array get xor ]

}

proc ::mytools::reconWord  { q } {
# takes array q as input as key, value list
 array set xor $q
 foreach i { 0 1 2 3 4 5 6 7 8 9 } {
  foreach k [ mytools::findCapitals $xor($i,10) ] {
   set word($k) [ lindex $xor($i,10) $k ]
   puts word($k)
  }
 }
 return [ array get word ]
}   

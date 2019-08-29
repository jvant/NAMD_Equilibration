#!/tcl

mol new gilt_del_NAG-BMA-solv_ion.psf

for {set i 1} {$i <= 15 } {incr i} {
    mol addfile step6.$i\_equilibration.dcd waitfor -1
}

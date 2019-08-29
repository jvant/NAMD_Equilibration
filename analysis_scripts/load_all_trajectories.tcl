#!tcl

####################################################################
#                       Calculate RMSD for a trajectory
#
#                       Author: John Vant; jvant@asu.edu
#
####################################################################

set pdbs { 5nmk 5nmh 5hhn 1qr1 1t21 3d25 3hpj 3mre 3pwl 3pwn 4l3c }

foreach name $pdbs {
    # set path to dcds
    set namd_dir_path ../systems/$name
    
    # Load psf and dcds
    mol new $namd_dir_path/$name-solv_ion.psf
    for {set i 1} {$i <= 30} {incr i} {
	mol addfile $namd_dir_path/step$i\_equilibration.dcd waitfor -1
}}


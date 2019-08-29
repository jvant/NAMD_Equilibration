#!tcl

####################################################################
#                       Calculate RMSD for a trajectory
#
#                       Author: John Vant; jvant@asu.edu
#
####################################################################

# set variable name to be folder/pdb name
set name [lindex $argv 0]

# set path to dcds
set namd_dir_path ../systems/$name

# initiate file for writing
set outfile [open $name-equilibration-rmsd.dat w]

# Load psf and dcds
mol new $namd_dir_path/$name-solv_ion.psf
for {set i 1} {$i <= 30} {incr i} {
    mol addfile $namd_dir_path/step$i\_equilibration.dcd waitfor -1
}

# Set params for rmsd calculations
set num_steps [molinfo top get numframes]
set reference [atomselect top "protein" frame 0]
set compare [atomselect top "protein"]

# Start looping through frames and calculating rmsd
for {set frame 0} {$frame < $num_steps} {incr frame} {
    
    $compare frame $frame
    set trans_mat [measure fit $compare $reference]
    $compare move $trans_mat
    set rmsd_val [measure rmsd $compare $reference]
    puts $outfile $rmsd_val

}

# close file to see output                  
close $outfile

# Always end a script this way!
exit

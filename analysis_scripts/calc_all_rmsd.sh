#!/bin/bash



for name in 1qr1  1t21  3d25  3hpj  3mre  3pwl  3pwn  4l3c  5hhn  5nmh  5nmk
do
    
    vmd -dispdev none -e ./calc_rmsd.tcl -args $name
    
done

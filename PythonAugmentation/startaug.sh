#!/bin/bash
#shell script that uses python modules to create reverb and noise augmentations
# forked from https://github.com/iver56/audiomentations and recoded by Lars Monstad for the Mirage Project
#chmod +x testscript
#example - ./testscript -e 
#csvconvert.py needs to be in rootfolder
# Created by Lars Monstad for the Mirage Project
while getopts e: flag
do
    case "${flag}" in
        e) foldername=${OPTARG};;   
    esac
done

cd $foldername 

a=$""
x=$""
for x in */
do
   x=$(sed 's/\///g' <<< $x)
   a=$"python-Augmented-"
   cd $x/audio/
   a+=$x
   echo "creating augmented folders"
   mkdir "../../../$a"
   mkdir "../../../$a/audio"
   mkdir "../../../$a/annotations"
     for file in *.wav
     do 
        python3 ../../../aug/augment.py "../$foldername/$x/audio/$file"
        ofile="${file%.*}.csv"
        echo "Creating CSV files"
        for file2 in ../../../aug/output/* 
        do
            file3=${file2##*/} 
            echo $file3
            cp -- "../annotations/$ofile" "../../../$a/annotations/${file3%.wav}.csv"
        done 
        mv ../../../aug/output/* "../../../$a/audio"   
    done
    cd ../../
done

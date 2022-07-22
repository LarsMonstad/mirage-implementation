#!/bin/bash
#create songfolder structure 
#chmod +x testscript
#example - ./testscript -e
#csvconvert.py needs to be in rootfolder 
while getopts e: flag
do
    case "${flag}" in
        e) foldername=${OPTARG};;   
    esac
done

# creating folders ! 

cd MusicTracker/Batches/Pitch

mkdir $foldername
cd $foldername 
 
# Results =  $foldername/Results
mkdir Files
mkdir MainEvaluation
mkdir SongEvaluation


#move to musictracker/sets 

cd ../../../Sets/  

mkdir $foldername
cd $foldername
mkdir Songs
mkdir Songs/AllSongs
cd Songs/AllSongs

# Make subfolders for song
mkdir Annotations 
   mkdir Annotations/Pitch
   mkdir Annotations/Chords
   mkdir Annotations/Rhythm
   mkdir Annotations/Global
   mkdir Annotations/HP
   
# Results =  $foldername/Results
mkdir Results
   mkdir Results/Figure
   mkdir Results/Figure/Pitchogram
   mkdir Results/Figure/Onsetgram
   mkdir Results/Pitch
   mkdir Results/Chords
   mkdir Results/Rhythm
   mkdir Results/HP
   mkdir Results/HP/H
   mkdir Results/HP/P
   mkdir Results/HP/Main
   mkdir Results/HP/NV
   mkdir Results/HP/V
   mkdir Results/EQ
   

# mkdir $foldername/Mixes
   mkdir Mixes
   mkdir Mixes/Main
   mkdir Mixes/H
   mkdir Mixes/P
   mkdir Mixes/V
   mkdir Mixes/NV
   mkdir Mixes/PP
   mkdir Mixes/PH

#mkdir  $foldername/Tracks
   mkdir Tracks
   mkdir Tracks/Vocals
   mkdir Tracks/Guitar
   mkdir Tracks/Drums
   mkdir Tracks/Bass
   mkdir Tracks/Piano
   mkdir Tracks/Percussion
   mkdir Tracks/Strings
   mkdir Tracks/Organ
   mkdir Tracks/Brass
   mkdir Tracks/Other

#mkdir  $foldername/Synths
   mkdir Synths
   mkdir Synths/Midi
#   makeInstrumentFolders Midi
   cd Synths
   mkdir Midi/Vocals
   mkdir Midi/Guitar
   mkdir Midi/Drums
   mkdir Midi/Bass
   mkdir Midi/Piano
   mkdir Midi/Percussion
   mkdir Midi/Strings
   mkdir Midi/Organ
   mkdir Midi/Brass
   mkdir Midi/Other
   mkdir Audio
   #cd Synths
#   makeInstrumentFolders audio
   mkdir Audio/Vocals
   mkdir Audio/Guitar
   mkdir Audio/Drums
   mkdir Audio/Bass
   mkdir Audio/Piano
   mkdir Audio/Percussion
   mkdir Audio/Strings
   mkdir Audio/Organ
   mkdir Audio/Brass
   mkdir Audio/Other
cd ../

#cd is allsongs 

# converting csv to ann 
ls 

cp ../../../../../$foldername/audio/* Mixes/Main

cd ../../../../../$foldername/annotations/
# converting csv to ann 
for file in *.csv 
do 
   python3 ../../csvconvert.py $file > ${file%.*}.ann
done
#delette csv files
for file in *.csv 
do 
   rm $file 
done
#cd is annotations
cd ../../MusicTracker/Sets/$foldername/Songs/AllSongs

cp ../../../../../$foldername/annotations/* Annotations/Pitch


#create list.txt
cd Mixes/Main/
#rm list.txt
ls > list.txt
sed -i -e 's#^#\\\Songs\\\AllSongs\\\Mixes\\\Main\\#' list.txt 
sed -i -e "s#^#$foldername#" list.txt 
sed -i '$d' list.txt 
cat list.txt
mv list.txt ../../../../../../Batches/Pitch/$foldername
cat ../../../../../../Batches/Pitch/$foldername/list.txt

#delete the last line of listt


# change scheluder to create ann2anf
#   ann2anf('$foldername'); 




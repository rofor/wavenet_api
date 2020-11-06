#!/bin/bash
## todo
# access token

mkdir temp
cp $1 temp/$1
cd temp
tr '\n' ' ' <  $1 | sed -e 's/[.] \s*/. \n/g' | split -l 1
cd ../
rm temp/$1


n=10000
digits=${#n} # number of digits, here calculated from the original number

for f in temp/*;do
file=$(cat $f)

# count
n=$[$n+00001];


curl -H "Authorization: Bearer "WNqVrvjcwZD1VUKrtArkug_O -H "Content-Type: application/json; charset=utf-8" --data "{
  'input':{
    'text':'I\'ve added the event to your calendar.'
  },
  'voice':{
    'languageCode':'en-gb',
    'name':'en-GB-Standard-A',
    'ssmlGender':'FEMALE'
  },
  'audioConfig':{
    'audioEncoding':'MP3'
  }
}" "https://texttospeech.googleapis.com/v1/text:synthesize"  > temp/synthesize-text.txt

## Cut out relevant data from resopnse
awk -F\" '{print $4}'  temp/synthesize-text.txt > temp/audio.txt

## Decode base64 to mp3
base64 temp/audio.txt --decode > $1-$n.mp3


done



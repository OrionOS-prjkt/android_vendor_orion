#!/bin/bash
#
# Copyright (C) 2019-2023 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#$1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=LINEAGE_VERSION
gappsOTAjson=./vendor/OrionOTA/builds/gapps/$1.json
vanillaOTAjson=./vendor/OrionOTA/builds/vanilla/$1.json
output=$2/$1.json

# Initialize JSON output
json_output='{
  "response": ['
first_entry=true

# Function to extract and append data from JSON files
extract_data() {
    local json_file=$1

    maintainer=$(grep -n "\"maintainer\"" $json_file | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs)
    oem=$(grep -n "\"oem\"" $json_file | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs)
    device=$(grep -n "\"device\"" $json_file | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs)
    device_name=$(grep -n "\"device_name\"" $json_file | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs)
    filename=$3
    version=$(echo "$3" | cut -d'-' -f2)
    download="https://sourceforge.net/projects/orionos/files/A14/$1/$filename/download"
    buildprop=$2/system/build.prop
    linenr=$(grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1)
    timestamp=$(sed -n $linenr'p' < $buildprop | cut -d'=' -f2)
    md5=$(md5sum "$2/$3" | cut -d' ' -f1)
    size=$(stat -c "%s" "$2/$3")

    # Add data to JSON output
    if [ "$first_entry" = true ]; then
        first_entry=false
    else
        json_output+=","
    fi
    
    json_output+='{
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$device'",
        "device_name": "'$device_name'",
        "filename": "'$filename'",
        "download": "'$download'",
        "timestamp": '$timestamp',
        "md5": "'$md5'",
        "size": '$size',
        "version": "'$version'"
    }'
}

# Process gapps OTA JSON if it exists
if [ -f $gappsOTAjson ]; then
    extract_data $gappsOTAjson
fi

# Process vanilla OTA JSON if it exists
if [ -f $vanillaOTAjson ]; then
    extract_data $vanillaOTAjson
fi

# Finalize JSON output
if [ "$first_entry" = true ]; then
    # No entries added, create dummy file
    echo 'There is no official support for this device yet' > $output
else
    json_output+=']
}'
    echo "$json_output" > $output
fi

echo "Output file created at: $output"

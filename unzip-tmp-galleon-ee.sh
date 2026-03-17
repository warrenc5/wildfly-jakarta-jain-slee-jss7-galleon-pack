#!/bin/bash

# Function to decompose Maven GAV coordinates
# Usage: gav "groupId:artifactId:version" or "groupId:artifactId:packaging:version"
# Returns: group (dots to slashes), artifactId, version, packaging via printf
gav() {
    local gav_input="$1"
    local IFS=':'
    local parts=($gav_input)
    local group artifact version packaging

    # Handle both GAV (3 parts) and GAVP (4 parts) formats
    if [ ${#parts[@]} -eq 3 ]; then
        group="${parts[0]}"
        artifact="${parts[1]}"
        version="${parts[2]}"
        packaging="jar"
    elif [ ${#parts[@]} -eq 4 ]; then
        group="${parts[0]}"
        artifact="${parts[1]}"
        packaging="${parts[2]}"
        version="${parts[3]}"
    else
        echo "Error: Invalid GAV format. Expected groupId:artifactId:version or groupId:artifactId:packaging:version" >&2
        return 1
    fi

    # Convert dots to slashes in group
    local group_path="${group//.//}"

    # Return parsed components
    printf '%s\n%s\n%s\n%s\n' "$group_path" "$artifact" "$version" "$packaging"
}

# Function to build find command arguments from GAV coordinates
# Usage: gav_f "groupId:artifactId:version" or "groupId:artifactId:packaging:version"
# Returns: array of find arguments for matching Maven artifacts
gav_f() {
    local gav_input="$1"
    local -a parsed
    mapfile -t parsed < <(gav "$gav_input")

    local group_path="${parsed[0]}"
    local artifact="${parsed[1]}"
    local version="${parsed[2]}"
    local packaging="${parsed[3]}"

    # Build result array for find command
    local result=()
    result+=("-ipath")
    result+=("*$group_path*")
    result+=("-a" "-ipath")
    result+=("*$artifact*")

    # Add packaging if present
    if [ -n "$packaging" ]; then
        result+=("-a" "-ipath")
        result+=("*.$packaging")
    fi

    result+=("-a" "-ipath")
    result+=("*$version*")

    # Return array by printing elements
    printf '%s\n' "${result[@]}"
}

VERSION_CORE=13.0.3.Final
VERSION_CORE=17.0.3.Final
VERSION_WILDFLY=21.0.1.Final
VERSION_WILDFLY=26.1.3.Final
VERSION_WILDFLY=39.0.0.Final
VERSION_DATASOURCES=2.2.6.Final
VERSION_DATASOURCES=11.2.0.Final
VERSION_MOBICENTS=9.0.0-SNAPSHOT

ALL=(
   org.mobicents.servers.jainslee.core:wildfly-mobicents-slee-galleon-pack:zip:$VERSION_MOBICENTS
   org.wildfly:wildfly-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly:wildfly-servlet-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly.core:wildfly-core-galleon-pack:zip:$VERSION_CORE
   org.wildfly:wildfly-ee-galleon-pack:zip:$VERSION_WILDFLY
   org.wildfly:wildfly-datasources-galleon-pack:zip:$VERSION_DATASOURCES
)

#ALL=(
#   org.wildfly:wildfly-servlet-galleon-pack:zip:$VERSION_WILDFLY
#)

# Loop through all coordinates and find/unzip them
cd tmp
for COORD in "${ALL[@]}"; do
    echo "Processing: $COORD"
    mapfile -t fargs < <(gav_f "$COORD")
    #printf '%s\n' "${fargs[@]}"
    mvn dependency:copy -Dartifact=$COORD -DoutputDirectory=.
    find /media/work/.m2/repository "${fargs[@]}" -print -exec unzip -q -o {} -d ./${COORD} \;
done

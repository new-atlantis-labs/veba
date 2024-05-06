#!/bin/bash
# __version__ = "2024.5.6"
# VEBA_DATABASE_VERSION = "VDB_v6"
# MICROEUKAYROTIC_DATABASE_VERSION = "MicroEuk_v3"
# usage: bash veba/download_databases.sh /path/to/veba_database_destination/ [optional positional argument: /path/to/conda_environments/]

# Arguments
DATABASE_DIRECTORY=${1:-"."}
REALPATH_DATABASE_DIRECTORY=$(realpath $DATABASE_DIRECTORY)
SCRIPT_DIRECTORY=$(dirname "$0")

CONDA_ENVS_PATH=${2:-"$(conda info --base)/envs/"}

# N_JOBS=$(2:-"1")

# Database structure
echo ". .. ... ..... ........ ............."
echo "Creating directories"
echo ". .. ... ..... ........ ............."

mkdir -vp $DATABASE_DIRECTORY
mkdir -vp ${DATABASE_DIRECTORY}/Annotate
mkdir -vp ${DATABASE_DIRECTORY}/Classify
# >${DATABASE_DIRECTORY}/log

# Versions
DATE=$(date)
echo $DATE > ${DATABASE_DIRECTORY}/ACCESS_DATE

# Databases
echo ". .. ... ..... ........ ............."
echo "Downloading and configuring database (markers)"
echo ". .. ... ..... ........ ............."
bash ${SCRIPT_DIRECTORY}/download_databases-markers.sh | grep -v "\[partial-database\]"

echo ". .. ... ..... ........ ............."
echo "Downloading and configuring database (preprocess)"
echo ". .. ... ..... ........ ............."
bash ${SCRIPT_DIRECTORY}/download_databases-preprocess.sh | grep -v "\[partial-database\]"

echo ". .. ... ..... ........ ............."
echo "Downloading and configuring database (classify)"
echo ". .. ... ..... ........ ............."
echo "This might take a while depending on source database i/o speed..."
bash ${SCRIPT_DIRECTORY}/download_databases-classify.sh | grep -v "\[partial-database\]"

echo ". .. ... ..... ........ ............."
echo "Downloading and configuring database (annotate)"
echo ". .. ... ..... ........ ............."
echo "This might take a while depending on source database i/o speed..."
bash ${SCRIPT_DIRECTORY}/download_databases-annotate.sh | grep -v "\[partial-database\]"

# Environment variables
echo ". .. ... ..... ........ ............."
echo "Configuring environment variables (CONDA_ENVS_PATH: ${CONDA_ENVS_PATH})"
echo ". .. ... ..... ........ ............."
bash ${SCRIPT_DIRECTORY}/update_environment_variables.sh ${REALPATH_DATABASE_DIRECTORY} ${CONDA_ENVS_PATH}

echo -e " _    _ _______ ______  _______\n  \  /  |______ |_____] |_____|\n   \/   |______ |_____] |     |"
echo -e "........................................."
echo -e "     Database Configuration Complete     "
echo -e ".........................................."
echo -e "The VEBA database environment variable is set in your VEBA conda environments: \n\tVEBA_DATABASE=${REALPATH_DATABASE_DIRECTORY}"
echo -e "For walkthroughs on different workflows, please refer to the documentation: \n\thttps://github.com/jolespin/veba/blob/main/walkthroughs/README.md"
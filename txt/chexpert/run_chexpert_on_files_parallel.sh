#!/bin/sh
# simple script to call chexpert labeler on many files

REPORT_PATH=$1
CHEXPERT_PATH=$2
PARALLEL_JOBS=$3

if [ -z "$REPORT_PATH" ]
then
    echo "You must call this script as: ./run_chexpert_on_files.sh FOLDER_WITH_DATA_CSVS CHEXPERT_GIT_PATH N_PARALLEL_JOBS"
    exit 1
else
    echo "Source of data: $REPORT_PATH"
fi

if [ -z "$CHEXPERT_PATH" ]
then
    echo "You must call this script as: ./run_chexpert_on_files.sh FOLDER_WITH_DATA_CSVS CHEXPERT_GIT_PATH N_PARALLEL_JOBS"
    exit 1
else
    echo "Location of CheXpert code: $CHEXPERT_PATH"
fi

if [ -z "$PARALLEL_JOBS" ]
then
    echo "You must call this script as: ./run_chexpert_on_files.sh FOLDER_WITH_DATA_CSVS CHEXPERT_GIT_PATH N_PARALLEL_JOBS"
    exit 1
else
    echo "Number of parallel jobs: $PARALLEL_JOBS"
fi
sleep 2

ls -1 $REPORT_PATH | cut -d. -f 1 | parallel --jobs $PARALLEL_JOBS python $CHEXPERT_PATH/label.py --verbose --reports_path $REPORT_PATH/{1}.csv --output_path {1}_labeled.csv --mention_phrases_dir $CHEXPERT_PATH/phrases/mention --unmention_phrases_dir $CHEXPERT_PATH/phrases/unmention --pre_negation_uncertainty_path $CHEXPERT_PATH/patterns/pre_negation_uncertainty.txt --negation_path $CHEXPERT_PATH/patterns/negation.txt --post_negation_uncertainty_path $CHEXPERT_PATH/patterns/post_negation_uncertainty.txt
